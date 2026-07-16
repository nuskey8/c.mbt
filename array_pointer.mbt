///|
#borrow(value)
extern "c" fn bytes_as_pointer_raw(value : Bytes) -> Pointer[CUInt8] = "c_mbt_bytes_as_pointer"

///|
#borrow(value)
extern "c" fn int_array_as_pointer_raw(
  value : FixedArray[Int],
) -> Pointer[CInt32] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn uint_array_as_pointer_raw(
  value : FixedArray[UInt],
) -> Pointer[CUInt32] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn byte_array_as_pointer_raw(
  value : FixedArray[Byte],
) -> Pointer[CUInt8] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn int16_array_as_pointer_raw(
  value : FixedArray[Int16],
) -> Pointer[CInt16] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn uint16_array_as_pointer_raw(
  value : FixedArray[UInt16],
) -> Pointer[CUInt16] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn pointer_array_as_pointer_raw(
  value : FixedArray[Pointer[Unit]],
) -> Pointer[Pointer[Unit]] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn readonly_pointer_array_as_pointer_raw(
  value : FixedArray[ReadOnlyPointer[Unit]],
) -> Pointer[ReadOnlyPointer[Unit]] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn csize_array_as_pointer_raw(
  value : FixedArray[CSize],
) -> Pointer[CSize] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn cint8_array_as_pointer_raw(
  value : FixedArray[CInt8],
) -> Pointer[CInt8] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn cbool_array_as_pointer_raw(
  value : FixedArray[CBool],
) -> Pointer[CBool] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn cchar_array_as_pointer_raw(
  value : FixedArray[CChar],
) -> Pointer[CChar] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn csigned_char_array_as_pointer_raw(
  value : FixedArray[CSignedChar],
) -> Pointer[CSignedChar] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn clong_array_as_pointer_raw(
  value : FixedArray[CLong],
) -> Pointer[CLong] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn cunsigned_long_array_as_pointer_raw(
  value : FixedArray[CUnsignedLong],
) -> Pointer[CUnsignedLong] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn cptrdiff_array_as_pointer_raw(
  value : FixedArray[CPtrDiff],
) -> Pointer[CPtrDiff] = "c_mbt_fixed_array_as_pointer"

///|
fn[T] erase_pointer_array(
  value : FixedArray[Pointer[T]],
) -> FixedArray[Pointer[Unit]] = "%identity"

///|
fn[T] restore_pointer_array_pointer(
  value : Pointer[Pointer[Unit]],
) -> Pointer[Pointer[T]] = "%identity"

///|
fn[T] erase_readonly_pointer_array(
  value : FixedArray[ReadOnlyPointer[T]],
) -> FixedArray[ReadOnlyPointer[Unit]] = "%identity"

///|
fn[T] restore_readonly_pointer_array_pointer(
  value : Pointer[ReadOnlyPointer[Unit]],
) -> Pointer[ReadOnlyPointer[T]] = "%identity"

///|
#borrow(value)
extern "c" fn int64_array_as_pointer_raw(
  value : FixedArray[Int64],
) -> Pointer[CInt64] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn uint64_array_as_pointer_raw(
  value : FixedArray[UInt64],
) -> Pointer[CUInt64] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn float_array_as_pointer_raw(
  value : FixedArray[Float],
) -> Pointer[CFloat] = "c_mbt_fixed_array_as_pointer"

///|
#borrow(value)
extern "c" fn double_array_as_pointer_raw(
  value : FixedArray[Double],
) -> Pointer[CDouble] = "c_mbt_fixed_array_as_pointer"

///|
pub(open) trait BytesAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt8]
}

///|
pub(open) trait IntArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt32]
}

///|
pub(open) trait UIntArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt32]
}

///|
pub(open) trait ByteArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt8]
}

///|
pub(open) trait Int16ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt16]
}

///|
pub(open) trait UInt16ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt16]
}

///|
pub type PointerArray

///|
pub type ReadOnlyPointerArray

///|
pub(open) trait CSizeArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CSize]
}

///|
pub(open) trait CInt8ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt8]
}

///|
pub(open) trait CBoolArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CBool]
}

///|
pub(open) trait CCharArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CChar]
}

///|
pub(open) trait CSignedCharArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CSignedChar]
}

///|
pub(open) trait CLongArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CLong]
}

///|
pub(open) trait CUnsignedLongArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUnsignedLong]
}

///|
pub(open) trait CPtrDiffArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CPtrDiff]
}

///|
pub(open) trait Int64ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt64]
}

///|
pub(open) trait UInt64ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt64]
}

///|
pub(open) trait FloatArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CFloat]
}

///|
pub(open) trait DoubleArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CDouble]
}

///|
pub impl BytesAsPointer for Bytes with fn as_pointer(self) {
  bytes_as_pointer_raw(self)
}

///|
pub impl IntArrayAsPointer for FixedArray[Int] with fn as_pointer(self) {
  int_array_as_pointer_raw(self)
}

///|
pub impl UIntArrayAsPointer for FixedArray[UInt] with fn as_pointer(self) {
  uint_array_as_pointer_raw(self)
}

///|
pub impl ByteArrayAsPointer for FixedArray[Byte] with fn as_pointer(self) {
  byte_array_as_pointer_raw(self)
}

///|
pub impl Int16ArrayAsPointer for FixedArray[Int16] with fn as_pointer(self) {
  int16_array_as_pointer_raw(self)
}

///|
pub impl UInt16ArrayAsPointer for FixedArray[UInt16] with fn as_pointer(self) {
  uint16_array_as_pointer_raw(self)
}

///|
pub fn[T] PointerArray::as_pointer(
  value : FixedArray[Pointer[T]],
) -> Pointer[Pointer[T]] {
  restore_pointer_array_pointer(
    pointer_array_as_pointer_raw(erase_pointer_array(value)),
  )
}

///|
pub fn[T] ReadOnlyPointerArray::as_pointer(
  value : FixedArray[ReadOnlyPointer[T]],
) -> Pointer[ReadOnlyPointer[T]] {
  restore_readonly_pointer_array_pointer(
    readonly_pointer_array_as_pointer_raw(erase_readonly_pointer_array(value)),
  )
}

///|
pub impl CSizeArrayAsPointer for FixedArray[CSize] with fn as_pointer(self) {
  csize_array_as_pointer_raw(self)
}

///|
pub impl CInt8ArrayAsPointer for FixedArray[CInt8] with fn as_pointer(self) {
  cint8_array_as_pointer_raw(self)
}

///|
pub impl CBoolArrayAsPointer for FixedArray[CBool] with fn as_pointer(self) {
  cbool_array_as_pointer_raw(self)
}

///|
pub impl CCharArrayAsPointer for FixedArray[CChar] with fn as_pointer(self) {
  cchar_array_as_pointer_raw(self)
}

///|
pub impl CSignedCharArrayAsPointer for FixedArray[CSignedChar] with fn as_pointer(
  self,
) {
  csigned_char_array_as_pointer_raw(self)
}

///|
pub impl CLongArrayAsPointer for FixedArray[CLong] with fn as_pointer(self) {
  clong_array_as_pointer_raw(self)
}

///|
pub impl CUnsignedLongArrayAsPointer for FixedArray[CUnsignedLong] with fn as_pointer(
  self,
) {
  cunsigned_long_array_as_pointer_raw(self)
}

///|
pub impl CPtrDiffArrayAsPointer for FixedArray[CPtrDiff] with fn as_pointer(
  self,
) {
  cptrdiff_array_as_pointer_raw(self)
}

///|
pub impl Int64ArrayAsPointer for FixedArray[Int64] with fn as_pointer(self) {
  int64_array_as_pointer_raw(self)
}

///|
pub impl UInt64ArrayAsPointer for FixedArray[UInt64] with fn as_pointer(self) {
  uint64_array_as_pointer_raw(self)
}

///|
pub impl FloatArrayAsPointer for FixedArray[Float] with fn as_pointer(self) {
  float_array_as_pointer_raw(self)
}

///|
pub impl DoubleArrayAsPointer for FixedArray[Double] with fn as_pointer(self) {
  double_array_as_pointer_raw(self)
}
