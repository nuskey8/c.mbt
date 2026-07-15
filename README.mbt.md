# C.mbt

Typed, non-owning C pointer helpers for MoonBit's native backend.

```moonbit nocheck
///|
/// A C function returning `const int32_t *`.
#borrow(handle)
extern "c" fn values(handle : Handle) -> @c.ReadOnlyPointer[@c.CInt32] = "library_values"

///|
/// A C function accepting `double *`.
#borrow(output)
extern "c" fn calculate(output : @c.Pointer[@c.CDouble]) -> Int = "library_calculate"
```

The package provides:

- `null`, `is_null`, and numeric address conversion
- signed byte and element-offset operations
- mutable-to-read-only conversion
- explicit `unsafe_cast` between pointee types
- reads, writes, indexed `get_*`, and indexed `set_*` operations
- fixed-width and platform C types such as `CInt`, `CLong`, `CSize`, and
  `CPtrDiff`
- mutable and read-only pointer-to-pointer operations
- `memcpy`, `memmove`, and `memset`-style memory operations

Every pointee marker implements `SizeOf` and `AlignOf`. Use `T::size_of()` /
`T::align_of()` when the marker is known statically, or
`pointer.element_size()` / `pointer.element_alignment()` when working with a
pointer:

```moonbit nocheck
let second = values.offset(1L)
let item = values.as_readonly().get_int32(1L)
values.set_int32(1L, item + 1)
```

Pointer-to-pointer types preserve constness at both levels:

```moonbit nocheck
let output : @c.Pointer[@c.Pointer[Item]] = ...
output.write_pointer(item_pointer)
let item = output.as_readonly().read_pointer()
```

Raw memory operations take byte counts:

```moonbit nocheck
destination.copy_non_overlapping_from(source, byte_count)
destination.move_from(source, byte_count)
destination.fill(b'\xff', byte_count)
destination.zero(byte_count)
```

`copy_non_overlapping_from` has the same non-overlap requirement as `memcpy`;
use `move_from` when the regions may overlap. Byte counts must fit the host C
`size_t`.

Pointer values are non-owning. They do not extend the lifetime of C memory and
never free it. The caller must ensure that every dereference is non-null,
in-bounds, correctly aligned, correctly typed, and still alive. APIs that can
manufacture or reinterpret a pointer are named `unsafe_` to make that boundary
visible.

Use `as_readonly()` when passing a mutable pointer to code that only reads it.
There is intentionally no read-only-to-mutable conversion.
