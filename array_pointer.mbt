///|
#borrow(value)
extern "c" fn bytes_as_pointer_raw(value : Bytes) -> ReadOnlyPointer[CUInt8] = "c_mbt_bytes_as_pointer"

///|
#borrow(value)
extern "c" fn int_array_as_pointer_raw(
  value : FixedArray[Int],
) -> Pointer[CInt32] = "c_mbt_int_array_as_pointer"

///|
#borrow(value)
extern "c" fn uint_array_as_pointer_raw(
  value : FixedArray[UInt],
) -> Pointer[CUInt32] = "c_mbt_uint_array_as_pointer"

///|
#borrow(value)
extern "c" fn byte_array_as_pointer_raw(
  value : FixedArray[Byte],
) -> Pointer[CUInt8] = "c_mbt_byte_array_as_pointer"

///|
#borrow(value)
extern "c" fn int16_array_as_pointer_raw(
  value : FixedArray[Int16],
) -> Pointer[CInt16] = "c_mbt_int16_array_as_pointer"

///|
#borrow(value)
extern "c" fn uint16_array_as_pointer_raw(
  value : FixedArray[UInt16],
) -> Pointer[CUInt16] = "c_mbt_uint16_array_as_pointer"

///|
#borrow(value)
extern "c" fn pointer_array_as_pointer_raw(
  value : FixedArray[Pointer[Unit]],
) -> Pointer[Pointer[Unit]] = "c_mbt_pointer_array_as_pointer"

///|
#borrow(value)
extern "c" fn readonly_pointer_array_as_pointer_raw(
  value : FixedArray[ReadOnlyPointer[Unit]],
) -> Pointer[ReadOnlyPointer[Unit]] = "c_mbt_readonly_pointer_array_as_pointer"

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
) -> Pointer[CInt64] = "c_mbt_int64_array_as_pointer"

///|
#borrow(value)
extern "c" fn uint64_array_as_pointer_raw(
  value : FixedArray[UInt64],
) -> Pointer[CUInt64] = "c_mbt_uint64_array_as_pointer"

///|
#borrow(value)
extern "c" fn float_array_as_pointer_raw(
  value : FixedArray[Float],
) -> Pointer[CFloat] = "c_mbt_float_array_as_pointer"

///|
#borrow(value)
extern "c" fn double_array_as_pointer_raw(
  value : FixedArray[Double],
) -> Pointer[CDouble] = "c_mbt_double_array_as_pointer"

///|
/// Borrows the read-only storage of `Bytes` as a C pointer.
pub(open) trait BytesAsPointer {
  fn as_pointer(Self) -> ReadOnlyPointer[CUInt8]
  fn[R] with_pointer(Self, (ReadOnlyPointer[CUInt8]) -> R) -> R
}

///|
pub(open) trait IntArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt32]
  fn[R] with_pointer(Self, (Pointer[CInt32]) -> R) -> R
}

///|
pub(open) trait UIntArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt32]
  fn[R] with_pointer(Self, (Pointer[CUInt32]) -> R) -> R
}

///|
pub(open) trait ByteArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt8]
  fn[R] with_pointer(Self, (Pointer[CUInt8]) -> R) -> R
}

///|
pub(open) trait Int16ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt16]
  fn[R] with_pointer(Self, (Pointer[CInt16]) -> R) -> R
}

///|
pub(open) trait UInt16ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt16]
  fn[R] with_pointer(Self, (Pointer[CUInt16]) -> R) -> R
}

///|
pub type PointerArray

///|
pub type ReadOnlyPointerArray

///|
pub(open) trait CSizeArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CSize]
  fn[R] with_pointer(Self, (Pointer[CSize]) -> R) -> R
}

///|
pub(open) trait CInt8ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt8]
  fn[R] with_pointer(Self, (Pointer[CInt8]) -> R) -> R
}

///|
pub(open) trait CBoolArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CBool]
  fn[R] with_pointer(Self, (Pointer[CBool]) -> R) -> R
}

///|
pub(open) trait CCharArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CChar]
  fn[R] with_pointer(Self, (Pointer[CChar]) -> R) -> R
}

///|
pub(open) trait CSignedCharArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CSignedChar]
  fn[R] with_pointer(Self, (Pointer[CSignedChar]) -> R) -> R
}

///|
pub(open) trait CLongArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CLong]
  fn[R] with_pointer(Self, (Pointer[CLong]) -> R) -> R
}

///|
pub(open) trait CUnsignedLongArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUnsignedLong]
  fn[R] with_pointer(Self, (Pointer[CUnsignedLong]) -> R) -> R
}

///|
pub(open) trait CPtrDiffArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CPtrDiff]
  fn[R] with_pointer(Self, (Pointer[CPtrDiff]) -> R) -> R
}

///|
pub(open) trait CIntPtrArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CIntPtr]
  fn[R] with_pointer(Self, (Pointer[CIntPtr]) -> R) -> R
}

///|
pub(open) trait CUIntPtrArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUIntPtr]
  fn[R] with_pointer(Self, (Pointer[CUIntPtr]) -> R) -> R
}

///|
pub(open) trait Int64ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CInt64]
  fn[R] with_pointer(Self, (Pointer[CInt64]) -> R) -> R
}

///|
pub(open) trait UInt64ArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CUInt64]
  fn[R] with_pointer(Self, (Pointer[CUInt64]) -> R) -> R
}

///|
pub(open) trait FloatArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CFloat]
  fn[R] with_pointer(Self, (Pointer[CFloat]) -> R) -> R
}

///|
pub(open) trait DoubleArrayAsPointer {
  fn as_pointer(Self) -> Pointer[CDouble]
  fn[R] with_pointer(Self, (Pointer[CDouble]) -> R) -> R
}

///|
pub impl BytesAsPointer for Bytes with fn as_pointer(self) {
  bytes_as_pointer_raw(self)
}

///|
pub impl BytesAsPointer for Bytes with fn[R] with_pointer(
  self : Bytes,
  action : (ReadOnlyPointer[CUInt8]) -> R,
) -> R {
  action(BytesAsPointer::as_pointer(self))
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
/// Borrows the array's contiguous storage for the duration of `action`.
/// The pointer must not be retained after `action` returns.
#borrow(value, action)
pub fn[T, R] PointerArray::with_pointer(
  value : FixedArray[Pointer[T]],
  action : (Pointer[Pointer[T]]) -> R,
) -> R {
  action(PointerArray::as_pointer(value))
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
/// Borrows the array's contiguous storage for the duration of `action`.
/// The pointer must not be retained after `action` returns.
#borrow(value, action)
pub fn[T, R] ReadOnlyPointerArray::with_pointer(
  value : FixedArray[ReadOnlyPointer[T]],
  action : (Pointer[ReadOnlyPointer[T]]) -> R,
) -> R {
  action(ReadOnlyPointerArray::as_pointer(value))
}

///|
pub impl CSizeArrayAsPointer for FixedArray[CSize] with fn as_pointer(self) {
  uint64_array_as_pointer_raw(self)
}

///|
pub impl CInt8ArrayAsPointer for FixedArray[CInt8] with fn as_pointer(self) {
  byte_array_as_pointer_raw(self)
}

///|
pub impl CBoolArrayAsPointer for FixedArray[CBool] with fn as_pointer(self) {
  byte_array_as_pointer_raw(self)
}

///|
pub impl CCharArrayAsPointer for FixedArray[CChar] with fn as_pointer(self) {
  byte_array_as_pointer_raw(self)
}

///|
pub impl CSignedCharArrayAsPointer for FixedArray[CSignedChar] with fn as_pointer(
  self,
) {
  byte_array_as_pointer_raw(self)
}

///|
#cfg(platform="windows")
pub impl CLongArrayAsPointer for FixedArray[CLong] with fn as_pointer(self) {
  int_array_as_pointer_raw(self)
}

///|
#cfg(not(platform="windows"))
pub impl CLongArrayAsPointer for FixedArray[CLong] with fn as_pointer(self) {
  int64_array_as_pointer_raw(self)
}

///|
#cfg(platform="windows")
pub impl CUnsignedLongArrayAsPointer for FixedArray[CUnsignedLong] with fn as_pointer(
  self,
) {
  uint_array_as_pointer_raw(self)
}

///|
#cfg(not(platform="windows"))
pub impl CUnsignedLongArrayAsPointer for FixedArray[CUnsignedLong] with fn as_pointer(
  self,
) {
  uint64_array_as_pointer_raw(self)
}

///|
pub impl CPtrDiffArrayAsPointer for FixedArray[CPtrDiff] with fn as_pointer(
  self,
) {
  int64_array_as_pointer_raw(self)
}

///|
pub impl CIntPtrArrayAsPointer for FixedArray[CIntPtr] with fn as_pointer(self) {
  int64_array_as_pointer_raw(self)
}

///|
pub impl CUIntPtrArrayAsPointer for FixedArray[CUIntPtr] with fn as_pointer(
  self,
) {
  uint64_array_as_pointer_raw(self)
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

///|
pub impl IntArrayAsPointer for FixedArray[Int] with fn[R] with_pointer(
  self : FixedArray[Int],
  action : (Pointer[CInt32]) -> R,
) -> R {
  action(IntArrayAsPointer::as_pointer(self))
}

///|
pub impl UIntArrayAsPointer for FixedArray[UInt] with fn[R] with_pointer(
  self : FixedArray[UInt],
  action : (Pointer[CUInt32]) -> R,
) -> R {
  action(UIntArrayAsPointer::as_pointer(self))
}

///|
pub impl ByteArrayAsPointer for FixedArray[Byte] with fn[R] with_pointer(
  self : FixedArray[Byte],
  action : (Pointer[CUInt8]) -> R,
) -> R {
  action(ByteArrayAsPointer::as_pointer(self))
}

///|
pub impl Int16ArrayAsPointer for FixedArray[Int16] with fn[R] with_pointer(
  self : FixedArray[Int16],
  action : (Pointer[CInt16]) -> R,
) -> R {
  action(Int16ArrayAsPointer::as_pointer(self))
}

///|
pub impl UInt16ArrayAsPointer for FixedArray[UInt16] with fn[R] with_pointer(
  self : FixedArray[UInt16],
  action : (Pointer[CUInt16]) -> R,
) -> R {
  action(UInt16ArrayAsPointer::as_pointer(self))
}

///|
pub impl CSizeArrayAsPointer for FixedArray[CSize] with fn[R] with_pointer(
  self : FixedArray[CSize],
  action : (Pointer[CSize]) -> R,
) -> R {
  action(CSizeArrayAsPointer::as_pointer(self))
}

///|
pub impl CInt8ArrayAsPointer for FixedArray[CInt8] with fn[R] with_pointer(
  self : FixedArray[CInt8],
  action : (Pointer[CInt8]) -> R,
) -> R {
  action(CInt8ArrayAsPointer::as_pointer(self))
}

///|
pub impl CBoolArrayAsPointer for FixedArray[CBool] with fn[R] with_pointer(
  self : FixedArray[CBool],
  action : (Pointer[CBool]) -> R,
) -> R {
  action(CBoolArrayAsPointer::as_pointer(self))
}

///|
pub impl CCharArrayAsPointer for FixedArray[CChar] with fn[R] with_pointer(
  self : FixedArray[CChar],
  action : (Pointer[CChar]) -> R,
) -> R {
  action(CCharArrayAsPointer::as_pointer(self))
}

///|
pub impl CSignedCharArrayAsPointer for FixedArray[CSignedChar] with fn[R] with_pointer(
  self : FixedArray[CSignedChar],
  action : (Pointer[CSignedChar]) -> R,
) -> R {
  action(CSignedCharArrayAsPointer::as_pointer(self))
}

///|
pub impl CLongArrayAsPointer for FixedArray[CLong] with fn[R] with_pointer(
  self : FixedArray[CLong],
  action : (Pointer[CLong]) -> R,
) -> R {
  action(CLongArrayAsPointer::as_pointer(self))
}

///|
pub impl CUnsignedLongArrayAsPointer for FixedArray[CUnsignedLong] with fn[R] with_pointer(
  self : FixedArray[CUnsignedLong],
  action : (Pointer[CUnsignedLong]) -> R,
) -> R {
  action(CUnsignedLongArrayAsPointer::as_pointer(self))
}

///|
pub impl CPtrDiffArrayAsPointer for FixedArray[CPtrDiff] with fn[R] with_pointer(
  self : FixedArray[CPtrDiff],
  action : (Pointer[CPtrDiff]) -> R,
) -> R {
  action(CPtrDiffArrayAsPointer::as_pointer(self))
}

///|
pub impl CIntPtrArrayAsPointer for FixedArray[CIntPtr] with fn[R] with_pointer(
  self : FixedArray[CIntPtr],
  action : (Pointer[CIntPtr]) -> R,
) -> R {
  action(CIntPtrArrayAsPointer::as_pointer(self))
}

///|
pub impl CUIntPtrArrayAsPointer for FixedArray[CUIntPtr] with fn[R] with_pointer(
  self : FixedArray[CUIntPtr],
  action : (Pointer[CUIntPtr]) -> R,
) -> R {
  action(CUIntPtrArrayAsPointer::as_pointer(self))
}

///|
pub impl Int64ArrayAsPointer for FixedArray[Int64] with fn[R] with_pointer(
  self : FixedArray[Int64],
  action : (Pointer[CInt64]) -> R,
) -> R {
  action(Int64ArrayAsPointer::as_pointer(self))
}

///|
pub impl UInt64ArrayAsPointer for FixedArray[UInt64] with fn[R] with_pointer(
  self : FixedArray[UInt64],
  action : (Pointer[CUInt64]) -> R,
) -> R {
  action(UInt64ArrayAsPointer::as_pointer(self))
}

///|
pub impl FloatArrayAsPointer for FixedArray[Float] with fn[R] with_pointer(
  self : FixedArray[Float],
  action : (Pointer[CFloat]) -> R,
) -> R {
  action(FloatArrayAsPointer::as_pointer(self))
}

///|
pub impl DoubleArrayAsPointer for FixedArray[Double] with fn[R] with_pointer(
  self : FixedArray[Double],
  action : (Pointer[CDouble]) -> R,
) -> R {
  action(DoubleArrayAsPointer::as_pointer(self))
}
