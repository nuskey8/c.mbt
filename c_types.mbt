///|
/// Marker for C `_Bool`/`bool` storage.
pub type CBool

///|
/// Marker for plain C `char`. Its signedness is implementation-defined.
pub type CChar

///|
/// Marker for C `signed char`.
pub type CSignedChar

///|
/// Marker for C `unsigned char`.
pub type CUnsignedChar = Byte

///|
/// Marker for C `short`.
pub type CShort = Int16

///|
/// Marker for C `unsigned short`.
pub type CUnsignedShort = UInt16

///|
/// Marker for C `int`.
pub type CInt = Int

///|
/// Marker for C `unsigned int`.
pub type CUnsignedInt = UInt

///|
/// Marker for C `long`.
pub type CLong

///|
/// Marker for C `unsigned long`.
pub type CUnsignedLong

///|
/// Marker for C `long long`.
pub type CLongLong = Int64

///|
/// Marker for C `unsigned long long`.
pub type CUnsignedLongLong = UInt64

///|
/// Marker for C `size_t`.
pub type CSize

///|
/// Marker for C `ptrdiff_t`.
pub type CPtrDiff

///|
/// Marker for C `intptr_t`.
pub type CIntPtr

///|
/// Marker for C `uintptr_t`.
pub type CUIntPtr

///|
/// Types with a known C storage size.
pub(open) trait SizeOf {
  fn size_of() -> Int64
}

///|
/// Types with a known C alignment requirement.
pub(open) trait AlignOf {
  fn align_of() -> Int64
}

///|
extern "c" fn sizeof_bool_raw() -> Int64 = "c_mbt_sizeof_bool"

///|
extern "c" fn sizeof_long_raw() -> Int64 = "c_mbt_sizeof_long"

///|
extern "c" fn sizeof_size_raw() -> Int64 = "c_mbt_sizeof_size"

///|
extern "c" fn sizeof_ptrdiff_raw() -> Int64 = "c_mbt_sizeof_ptrdiff"

///|
extern "c" fn sizeof_intptr_raw() -> Int64 = "c_mbt_sizeof_intptr"

///|
extern "c" fn sizeof_uintptr_raw() -> Int64 = "c_mbt_sizeof_uintptr"

///|
extern "c" fn sizeof_pointer_raw() -> Int64 = "c_mbt_sizeof_pointer"

///|
extern "c" fn alignof_raw(type_id : Int) -> Int64 = "c_mbt_alignof"

///|
/// Moves a mutable pointer by a signed element offset.
pub fn[T : SizeOf] Pointer::offset(
  self : Pointer[T],
  count : Int64,
) -> Pointer[T] {
  pointer_from_raw(
    pointer_offset_bytes_raw(pointer_to_raw(self), count * T::size_of()),
  )
}

///|
/// Advances a mutable pointer by `count` elements.
pub fn[T : SizeOf] Pointer::add(
  self : Pointer[T],
  count : UInt64,
) -> Pointer[T] {
  pointer_from_raw(
    pointer_add_bytes_raw(
      pointer_to_raw(self),
      count * T::size_of().reinterpret_as_uint64(),
    ),
  )
}

///|
/// Moves a mutable pointer backward by `count` elements.
pub fn[T : SizeOf] Pointer::sub(
  self : Pointer[T],
  count : UInt64,
) -> Pointer[T] {
  pointer_from_raw(
    pointer_sub_bytes_raw(
      pointer_to_raw(self),
      count * T::size_of().reinterpret_as_uint64(),
    ),
  )
}

///|
/// Moves a read-only pointer by a signed element offset.
pub fn[T : SizeOf] ReadOnlyPointer::offset(
  self : ReadOnlyPointer[T],
  count : Int64,
) -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(
    pointer_offset_bytes_raw(
      readonly_pointer_to_raw(self),
      count * T::size_of(),
    ),
  )
}

///|
/// Advances a read-only pointer by `count` elements.
pub fn[T : SizeOf] ReadOnlyPointer::add(
  self : ReadOnlyPointer[T],
  count : UInt64,
) -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(
    pointer_add_bytes_raw(
      readonly_pointer_to_raw(self),
      count * T::size_of().reinterpret_as_uint64(),
    ),
  )
}

///|
/// Moves a read-only pointer backward by `count` elements.
pub fn[T : SizeOf] ReadOnlyPointer::sub(
  self : ReadOnlyPointer[T],
  count : UInt64,
) -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(
    pointer_sub_bytes_raw(
      readonly_pointer_to_raw(self),
      count * T::size_of().reinterpret_as_uint64(),
    ),
  )
}

///|
pub impl SizeOf for Unit with fn size_of() {
  1L
}

///|
pub impl SizeOf for CInt8 with fn size_of() {
  1L
}

///|
pub impl SizeOf for Byte with fn size_of() {
  1L
}

///|
pub impl SizeOf for Int16 with fn size_of() {
  2L
}

///|
pub impl SizeOf for UInt16 with fn size_of() {
  2L
}

///|
pub impl SizeOf for Int with fn size_of() {
  4L
}

///|
pub impl SizeOf for UInt with fn size_of() {
  4L
}

///|
pub impl SizeOf for Int64 with fn size_of() {
  8L
}

///|
pub impl SizeOf for UInt64 with fn size_of() {
  8L
}

///|
pub impl SizeOf for Float with fn size_of() {
  4L
}

///|
pub impl SizeOf for Double with fn size_of() {
  8L
}

///|
pub impl SizeOf for CBool with fn size_of() {
  sizeof_bool_raw()
}

///|
pub impl SizeOf for CChar with fn size_of() {
  1L
}

///|
pub impl SizeOf for CSignedChar with fn size_of() {
  1L
}

///|
pub impl SizeOf for CLong with fn size_of() {
  sizeof_long_raw()
}

///|
pub impl SizeOf for CUnsignedLong with fn size_of() {
  sizeof_long_raw()
}

///|
pub impl SizeOf for CSize with fn size_of() {
  sizeof_size_raw()
}

///|
pub impl SizeOf for CPtrDiff with fn size_of() {
  sizeof_ptrdiff_raw()
}

///|
pub impl SizeOf for CIntPtr with fn size_of() {
  sizeof_intptr_raw()
}

///|
pub impl SizeOf for CUIntPtr with fn size_of() {
  sizeof_uintptr_raw()
}

///|
pub impl[T] SizeOf for Pointer[T] with fn size_of() {
  sizeof_pointer_raw()
}

///|
pub impl[T] SizeOf for ReadOnlyPointer[T] with fn size_of() {
  sizeof_pointer_raw()
}

///|
pub impl AlignOf for Unit with fn align_of() {
  1L
}

///|
pub impl AlignOf for CInt8 with fn align_of() {
  alignof_raw(1)
}

///|
pub impl AlignOf for Byte with fn align_of() {
  alignof_raw(1)
}

///|
pub impl AlignOf for Int16 with fn align_of() {
  alignof_raw(3)
}

///|
pub impl AlignOf for UInt16 with fn align_of() {
  alignof_raw(4)
}

///|
pub impl AlignOf for Int with fn align_of() {
  alignof_raw(5)
}

///|
pub impl AlignOf for UInt with fn align_of() {
  alignof_raw(6)
}

///|
pub impl AlignOf for Int64 with fn align_of() {
  alignof_raw(7)
}

///|
pub impl AlignOf for UInt64 with fn align_of() {
  alignof_raw(8)
}

///|
pub impl AlignOf for Float with fn align_of() {
  alignof_raw(9)
}

///|
pub impl AlignOf for Double with fn align_of() {
  alignof_raw(10)
}

///|
pub impl AlignOf for CBool with fn align_of() {
  alignof_raw(11)
}

///|
pub impl AlignOf for CChar with fn align_of() {
  alignof_raw(12)
}

///|
pub impl AlignOf for CSignedChar with fn align_of() {
  alignof_raw(13)
}

///|
pub impl AlignOf for CLong with fn align_of() {
  alignof_raw(19)
}

///|
pub impl AlignOf for CUnsignedLong with fn align_of() {
  alignof_raw(20)
}

///|
pub impl AlignOf for CSize with fn align_of() {
  alignof_raw(23)
}

///|
pub impl AlignOf for CPtrDiff with fn align_of() {
  alignof_raw(24)
}

///|
pub impl AlignOf for CIntPtr with fn align_of() {
  alignof_raw(26)
}

///|
pub impl AlignOf for CUIntPtr with fn align_of() {
  alignof_raw(27)
}

///|
pub impl[T] AlignOf for Pointer[T] with fn align_of() {
  alignof_raw(25)
}

///|
pub impl[T] AlignOf for ReadOnlyPointer[T] with fn align_of() {
  alignof_raw(25)
}
