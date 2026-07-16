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
