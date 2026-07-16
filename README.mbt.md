# C.mbt

Provides C FFI types for MoonBit's native backend.

`Pointer[T]` represents a mutable `T *`. `ReadOnlyPointer[T]` represents a
read-only `const T *`. Both are `#external` types and are passed to C as raw
`void *` values. The pointee type `T` exists only at compile time and has no
runtime cost.

## Installation

```bash
moon add nuskey8/c
```

## Declaring C functions

Use the pointer types directly in native FFI declarations:

```moonbit nocheck
///|
/// C: const int32_t *library_values(Handle *handle);
#borrow(handle)
extern "c" fn library_values(handle : Handle) -> @c.ReadOnlyPointer[@c.CInt32] = "library_values"

///|
/// C: int library_calculate(double *output);
#borrow(output)
extern "c" fn library_calculate(output : @c.Pointer[@c.CDouble]) -> Int = "library_calculate"
```

Annotate pointer parameters with `#borrow` when C only uses them during the
call. Follow the C API's ownership contract if it stores the pointer.

## Null pointers

```moonbit nocheck
let pointer : @c.Pointer[@c.CInt32] = @c.Pointer::null()
if pointer.is_null() {
  // Do not read or write through it.
}
```

`address()` exposes the address as `UInt64`. `unsafe_from_address()` performs
the reverse operation and should only be used when the address is known to be
valid.

## Reading and writing

Read through `ReadOnlyPointer`; write through `Pointer`:

```moonbit nocheck
let input : @c.ReadOnlyPointer[@c.CInt32] = library_input()
let value : Int = input.read_int32()

let output : @c.Pointer[@c.CInt32] = library_output()
output.write_int32(value + 1)
```

A mutable pointer can be viewed as read-only. The reverse conversion is
intentionally unavailable:

```moonbit nocheck
///|
let input = output.as_readonly()

///|
let value = input.read_int32()
```

## Pointer arithmetic

`add` and `sub` take an unsigned `UInt64` element count. `offset` takes a
signed `Int64` element offset.

```moonbit nocheck
let first : @c.Pointer[@c.CInt32] = library_output()
let second = first.add(1UL) // advances by sizeof(int32_t)
second.write_int32(42)

let first_again = second.sub(1UL)
let previous = second.offset(-1L)
```

## Pointer-to-pointer values

Pointer types can be nested to any depth:

```moonbit nocheck
// C: Item **
let output : @c.Pointer[@c.Pointer[Item]] = library_output()
output.write_pointer(item_pointer)

let item : @c.Pointer[Item] = output.as_readonly().read_pointer()
```

Read-only pointees retain their constness:

```moonbit nocheck
// C: const Item **
let output : @c.Pointer[@c.ReadOnlyPointer[Item]] = library_const_output()
output.write_readonly_pointer(item_pointer.as_readonly())

let item : @c.ReadOnlyPointer[Item] =
  output.as_readonly().read_readonly_pointer()
```

The same operations compose for `T ***`, `T ****`, and deeper pointer types.

## Raw memory operations

Memory operation lengths are byte counts:

```moonbit nocheck
destination.copy_non_overlapping_from(source, byte_count) // memcpy
destination.move_from(source, byte_count)                 // memmove
destination.fill(b'\xff', byte_count)                      // memset
destination.zero(byte_count)
```

`copy_non_overlapping_from` requires non-overlapping source and destination
regions. Use `move_from` when they may overlap. Byte counts must fit the host
C `size_t`.

## C types and layout

Fixed-width markers include `CInt8`, `CUInt8`, `CInt16`, `CUInt16`, `CInt32`,
`CUInt32`, `CInt64`, and `CUInt64`. Platform C types include:

| C type           | Marker      | MoonBit value |
| ---------------- | ----------- | ------------- |
| `_Bool` / `bool` | `CBool`     | `Bool`        |
| `char`           | `CChar`     | `Int`         |
| `short`          | `CShort`    | `Int`         |
| `int`            | `CInt`      | `Int`         |
| `long`           | `CLong`     | `Int64`       |
| `long long`      | `CLongLong` | `Int64`       |
| `size_t`         | `CSize`     | `UInt64`      |
| `ptrdiff_t`      | `CPtrDiff`  | `Int64`       |
| `intptr_t`       | `CIntPtr`   | `Int64`       |
| `uintptr_t`      | `CUIntPtr`  | `UInt64`      |
| `float`          | `CFloat`    | `Float`       |
| `double`         | `CDouble`   | `Double`      |

Unsigned variants are available for the integer types. `CChar` follows the
host C compiler's implementation-defined plain-`char` signedness; use
`CSignedChar` or `CUnsignedChar` when signedness matters.

Every marker implements `SizeOf` and `AlignOf`, using the host C compiler for
platform-dependent values:

```moonbit nocheck
///|
let size = @c.CLong::size_of()

///|
let alignment = @c.CLong::align_of()
```

`Pointer[T]` and `ReadOnlyPointer[T]` also implement these traits, so nested
pointer arithmetic uses the host pointer size.

## Safety and ownership

Pointer values are non-owning. This package never allocates, frees, or extends
the lifetime of pointed-to memory. Before every read, write, or memory
operation, the caller must ensure that:

- the pointer is non-null;
- the allocation is still alive;
- the accessed range is in bounds;
- the address satisfies the pointee type's alignment;
- the pointee type matches the actual C object;
- mutable access is permitted by the C API;
- memory regions satisfy the selected copy operation's overlap rules.

Violating these requirements is undefined behavior. Operations that construct
or reinterpret a pointer are named `unsafe_` to make this boundary explicit.

## License

This library is released under the [MIT License](LICENSE).
