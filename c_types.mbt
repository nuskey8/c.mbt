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
pub type CUnsignedChar

///|
/// Marker for C `short`.
pub type CShort

///|
/// Marker for C `unsigned short`.
pub type CUnsignedShort

///|
/// Marker for C `int`.
pub type CInt

///|
/// Marker for C `unsigned int`.
pub type CUnsignedInt

///|
/// Marker for C `long`.
pub type CLong

///|
/// Marker for C `unsigned long`.
pub type CUnsignedLong

///|
/// Marker for C `long long`.
pub type CLongLong

///|
/// Marker for C `unsigned long long`.
pub type CUnsignedLongLong

///|
/// Marker for C `size_t`.
pub type CSize

///|
/// Marker for C `ptrdiff_t`.
pub type CPtrDiff

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
extern "c" fn sizeof_char_raw() -> Int64 = "c_mbt_sizeof_char"

///|
extern "c" fn sizeof_short_raw() -> Int64 = "c_mbt_sizeof_short"

///|
extern "c" fn sizeof_int_raw() -> Int64 = "c_mbt_sizeof_int"

///|
extern "c" fn sizeof_long_raw() -> Int64 = "c_mbt_sizeof_long"

///|
extern "c" fn sizeof_long_long_raw() -> Int64 = "c_mbt_sizeof_long_long"

///|
extern "c" fn sizeof_size_raw() -> Int64 = "c_mbt_sizeof_size"

///|
extern "c" fn sizeof_ptrdiff_raw() -> Int64 = "c_mbt_sizeof_ptrdiff"

///|
extern "c" fn sizeof_pointer_raw() -> Int64 = "c_mbt_sizeof_pointer"

///|
extern "c" fn alignof_raw(type_id : Int) -> Int64 = "c_mbt_alignof"

///|
/// Returns the C storage size of this pointer's element type, in bytes.
pub fn[T : SizeOf] Pointer::element_size(_self : Pointer[T]) -> Int64 {
  T::size_of()
}

///|
/// Returns the C storage size of this pointer's element type, in bytes.
pub fn[T : SizeOf] ReadOnlyPointer::element_size(
  _self : ReadOnlyPointer[T],
) -> Int64 {
  T::size_of()
}

///|
/// Returns the required C alignment of this pointer's element type.
pub fn[T : AlignOf] Pointer::element_alignment(_self : Pointer[T]) -> Int64 {
  T::align_of()
}

///|
/// Returns the required C alignment of this pointer's element type.
pub fn[T : AlignOf] ReadOnlyPointer::element_alignment(
  _self : ReadOnlyPointer[T],
) -> Int64 {
  T::align_of()
}

///|
/// Adds a signed element offset to a mutable pointer.
pub fn[T : SizeOf] Pointer::offset(
  self : Pointer[T],
  index : Int64,
) -> Pointer[T] {
  self.offset_bytes(index * T::size_of())
}

///|
/// Adds a signed element offset to a read-only pointer.
pub fn[T : SizeOf] ReadOnlyPointer::offset(
  self : ReadOnlyPointer[T],
  index : Int64,
) -> ReadOnlyPointer[T] {
  self.offset_bytes(index * T::size_of())
}

///|
pub impl SizeOf for CVoid with fn size_of() {
  1L
}

///|
pub impl SizeOf for CInt8 with fn size_of() {
  1L
}

///|
pub impl SizeOf for CUInt8 with fn size_of() {
  1L
}

///|
pub impl SizeOf for CInt16 with fn size_of() {
  2L
}

///|
pub impl SizeOf for CUInt16 with fn size_of() {
  2L
}

///|
pub impl SizeOf for CInt32 with fn size_of() {
  4L
}

///|
pub impl SizeOf for CUInt32 with fn size_of() {
  4L
}

///|
pub impl SizeOf for CInt64 with fn size_of() {
  8L
}

///|
pub impl SizeOf for CUInt64 with fn size_of() {
  8L
}

///|
pub impl SizeOf for CFloat with fn size_of() {
  4L
}

///|
pub impl SizeOf for CDouble with fn size_of() {
  8L
}

///|
pub impl SizeOf for CBool with fn size_of() {
  sizeof_bool_raw()
}

///|
pub impl SizeOf for CChar with fn size_of() {
  sizeof_char_raw()
}

///|
pub impl SizeOf for CSignedChar with fn size_of() {
  sizeof_char_raw()
}

///|
pub impl SizeOf for CUnsignedChar with fn size_of() {
  sizeof_char_raw()
}

///|
pub impl SizeOf for CShort with fn size_of() {
  sizeof_short_raw()
}

///|
pub impl SizeOf for CUnsignedShort with fn size_of() {
  sizeof_short_raw()
}

///|
pub impl SizeOf for CInt with fn size_of() {
  sizeof_int_raw()
}

///|
pub impl SizeOf for CUnsignedInt with fn size_of() {
  sizeof_int_raw()
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
pub impl SizeOf for CLongLong with fn size_of() {
  sizeof_long_long_raw()
}

///|
pub impl SizeOf for CUnsignedLongLong with fn size_of() {
  sizeof_long_long_raw()
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
pub impl[T] SizeOf for Pointer[T] with fn size_of() {
  sizeof_pointer_raw()
}

///|
pub impl[T] SizeOf for ReadOnlyPointer[T] with fn size_of() {
  sizeof_pointer_raw()
}

///|
pub impl AlignOf for CVoid with fn align_of() {
  1L
}

///|
pub impl AlignOf for CInt8 with fn align_of() {
  alignof_raw(1)
}

///|
pub impl AlignOf for CUInt8 with fn align_of() {
  alignof_raw(2)
}

///|
pub impl AlignOf for CInt16 with fn align_of() {
  alignof_raw(3)
}

///|
pub impl AlignOf for CUInt16 with fn align_of() {
  alignof_raw(4)
}

///|
pub impl AlignOf for CInt32 with fn align_of() {
  alignof_raw(5)
}

///|
pub impl AlignOf for CUInt32 with fn align_of() {
  alignof_raw(6)
}

///|
pub impl AlignOf for CInt64 with fn align_of() {
  alignof_raw(7)
}

///|
pub impl AlignOf for CUInt64 with fn align_of() {
  alignof_raw(8)
}

///|
pub impl AlignOf for CFloat with fn align_of() {
  alignof_raw(9)
}

///|
pub impl AlignOf for CDouble with fn align_of() {
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
pub impl AlignOf for CUnsignedChar with fn align_of() {
  alignof_raw(14)
}

///|
pub impl AlignOf for CShort with fn align_of() {
  alignof_raw(15)
}

///|
pub impl AlignOf for CUnsignedShort with fn align_of() {
  alignof_raw(16)
}

///|
pub impl AlignOf for CInt with fn align_of() {
  alignof_raw(17)
}

///|
pub impl AlignOf for CUnsignedInt with fn align_of() {
  alignof_raw(18)
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
pub impl AlignOf for CLongLong with fn align_of() {
  alignof_raw(21)
}

///|
pub impl AlignOf for CUnsignedLongLong with fn align_of() {
  alignof_raw(22)
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
pub impl[T] AlignOf for Pointer[T] with fn align_of() {
  alignof_raw(25)
}

///|
pub impl[T] AlignOf for ReadOnlyPointer[T] with fn align_of() {
  alignof_raw(25)
}
