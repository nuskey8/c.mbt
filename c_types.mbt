///|
/// Marker for C `_Bool`/`bool` storage.
pub type CBool = Byte

///|
/// Marker for plain C `char`. Its signedness is implementation-defined.
pub type CChar = Byte

///|
/// Marker for C `signed char`.
pub type CSignedChar = Byte

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
#cfg(platform="windows")
pub type CLong = Int

///|
/// Marker for C `long`.
#cfg(not(platform="windows"))
pub type CLong = Int64

///|
/// Marker for C `unsigned long`.
#cfg(platform="windows")
pub type CUnsignedLong = UInt

///|
/// Marker for C `unsigned long`.
#cfg(not(platform="windows"))
pub type CUnsignedLong = UInt64

///|
/// Marker for C `long long`.
pub type CLongLong = Int64

///|
/// Marker for C `unsigned long long`.
pub type CUnsignedLongLong = UInt64

///|
/// Marker for C `size_t`.
pub type CSize = UInt64

///|
/// Marker for C `ptrdiff_t`.
pub type CPtrDiff = Int64

///|
/// Marker for C `intptr_t`.
pub type CIntPtr = Int64

///|
/// Marker for C `uintptr_t`.
pub type CUIntPtr = UInt64

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
pub impl[T] AlignOf for Pointer[T] with fn align_of() {
  alignof_raw(25)
}

///|
pub impl[T] AlignOf for ReadOnlyPointer[T] with fn align_of() {
  alignof_raw(25)
}
