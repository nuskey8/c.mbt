///|
extern "c" fn test_int32_pointer() -> Pointer[CInt32] = "c_mbt_test_int32_pointer"

///|
extern "c" fn test_double_pointer() -> Pointer[CDouble] = "c_mbt_test_double_pointer"

///|
extern "c" fn test_pointer_pointer() -> Pointer[Pointer[CInt32]] = "c_mbt_test_pointer_pointer"

///|
extern "c" fn test_bytes_pointer() -> Pointer[CUnsignedChar] = "c_mbt_test_bytes_pointer"

///|
test "null pointers" {
  let mutable : Pointer[CInt32] = Pointer::null()
  let read_only_pointer : ReadOnlyPointer[CInt32] = ReadOnlyPointer::null()
  assert_true(mutable.is_null())
  assert_true(read_only_pointer.is_null())
  assert_eq(mutable.address(), 0UL)
  assert_eq(read_only_pointer.address(), 0UL)
}

///|
test "mutable pointer write and read-only pointer read" {
  let pointer = test_int32_pointer()
  assert_false(pointer.is_null())
  pointer.write_int32(-123456)
  assert_eq(pointer.as_readonly().read_int32(), -123456)
}

///|
test "byte offset and address round trip" {
  let first = test_int32_pointer()
  let second = first.add(1UL)
  second.write_int32(42)
  assert_eq(first.as_readonly().add(1UL).read_int32(), 42)
  let restored : Pointer[CInt32] = Pointer::unsafe_from_address(
    second.address(),
  )
  assert_eq(restored.as_readonly().read_int32(), 42)
}

///|
test "pointer cast preserves address" {
  let pointer = test_double_pointer()
  pointer.write_double(3.5)
  let void_pointer : Pointer[CVoid] = pointer.unsafe_cast()
  let restored : Pointer[CDouble] = void_pointer.unsafe_cast()
  assert_eq(restored.as_readonly().read_double(), 3.5)
}

///|
test "C type sizes and element offsets" {
  let pointer = test_int32_pointer()
  assert_eq(pointer.add(1UL).address() - pointer.address(), 4UL)
  pointer.write_int32(10)
  pointer.add(1UL).write_int32(20)
  let read_only_pointer = pointer.as_readonly()
  assert_eq(read_only_pointer.read_int32(), 10)
  assert_eq(read_only_pointer.add(1UL).read_int32(), 20)
  assert_eq(read_only_pointer.add(1UL).sub(1UL).address(), pointer.address())
  assert_eq(read_only_pointer.add(1UL).offset(-1L).address(), pointer.address())
}

///|
test "pointer-to-pointer read and write" {
  let value = test_int32_pointer()
  value.write_int32(77)
  let output = test_pointer_pointer()
  output.write_pointer(value)
  let restored = output.as_readonly().read_pointer()
  assert_eq(restored.address(), value.address())
  assert_eq(restored.as_readonly().read_int32(), 77)
}

///|
test "read-only pointer-to-pointer read and write" {
  let value = test_int32_pointer()
  value.write_int32(88)
  let output : Pointer[ReadOnlyPointer[CInt32]] = test_pointer_pointer().unsafe_cast()
  output.write_readonly_pointer(value.as_readonly())
  let restored = output.as_readonly().read_readonly_pointer()
  assert_eq(restored.address(), value.address())
  assert_eq(restored.read_int32(), 88)
}

///|
test "fill, copy, zero, and overlapping move" {
  let bytes = test_bytes_pointer()
  bytes.fill(b'\xaa', 16UL)
  bytes.write_unsigned_char(b'\x01')
  bytes.add(1UL).write_unsigned_char(b'\x02')
  bytes.add(2UL).write_unsigned_char(b'\x03')
  bytes.add(3UL).write_unsigned_char(b'\x04')
  bytes.add(8UL).copy_non_overlapping_from(bytes.as_readonly(), 4UL)
  assert_eq(bytes.as_readonly().add(8UL).read_unsigned_char(), b'\x01')
  assert_eq(bytes.as_readonly().add(11UL).read_unsigned_char(), b'\x04')
  bytes.add(1UL).move_from(bytes.as_readonly(), 4UL)
  assert_eq(bytes.as_readonly().add(1UL).read_unsigned_char(), b'\x01')
  assert_eq(bytes.as_readonly().add(4UL).read_unsigned_char(), b'\x04')
  bytes.add(8UL).zero(4UL)
  assert_eq(bytes.as_readonly().add(8UL).read_unsigned_char(), b'\x00')
  assert_eq(bytes.as_readonly().add(11UL).read_unsigned_char(), b'\x00')
}

///|
test "platform C scalar access" {
  let bytes = test_bytes_pointer()
  let bool_pointer : Pointer[CBool] = bytes.unsafe_cast()
  bool_pointer.write_bool(true)
  assert_true(bool_pointer.as_readonly().read_bool())
  let size_pointer : Pointer[CSize] = bytes.unsafe_cast()
  size_pointer.write_size(1234UL)
  assert_eq(size_pointer.as_readonly().read_size(), 1234UL)
}

///|
test "Bytes::as_pointer borrows its storage" {
  let bytes = b"abc"
  let pointer = BytesAsPointer::as_pointer(bytes)
  assert_eq(pointer.as_readonly().read_uint8(), b'a')
  assert_eq(pointer.add(2UL).as_readonly().read_uint8(), b'c')
  assert_eq(bytes.length(), 3)
}

///|
test "FixedArray::as_pointer borrows mutable storage" {
  let values : FixedArray[Int] = [10, 20]
  let pointer = IntArrayAsPointer::as_pointer(values)
  pointer.add(1UL).write_int32(99)
  assert_eq(values[1], 99)
}

///|
test "byte fixed arrays expose their storage" {
  let values : FixedArray[Byte] = [1, 2]
  let pointer = ByteArrayAsPointer::as_pointer(values)
  pointer.add(1UL).write_uint8(3)
  assert_eq(values[1], 3)
}

///|
test "16-bit fixed arrays expose their storage" {
  let signed : FixedArray[Int16] = [1, 2]
  let signed_pointer = Int16ArrayAsPointer::as_pointer(signed)
  signed_pointer.add(1UL).write_int16(3)
  assert_eq(signed[1], 3)

  let unsigned : FixedArray[UInt16] = [4, 5]
  let unsigned_pointer = UInt16ArrayAsPointer::as_pointer(unsigned)
  unsigned_pointer.add(1UL).write_uint16(6)
  assert_eq(unsigned[1], 6)
}

///|
test "pointer fixed arrays expose T double-pointer storage" {
  let first = test_int32_pointer()
  let second = first.add(1UL)
  let pointers : FixedArray[Pointer[CInt32]] = [first, second]
  let pointer : Pointer[Pointer[CInt32]] = PointerArray::as_pointer(pointers)
  assert_eq(pointer.as_readonly().read_pointer().address(), first.address())
  assert_eq(
    pointer.add(1UL).as_readonly().read_pointer().address(),
    second.address(),
  )
}

///|
test "read-only pointer fixed arrays expose const T double-pointer storage" {
  let first = test_int32_pointer().as_readonly()
  let second = test_int32_pointer().add(1UL).as_readonly()
  let pointers : FixedArray[ReadOnlyPointer[CInt32]] = [first, second]
  let pointer : Pointer[ReadOnlyPointer[CInt32]] = ReadOnlyPointerArray::as_pointer(
    pointers,
  )
  assert_eq(
    pointer.as_readonly().read_readonly_pointer().address(),
    first.address(),
  )
  assert_eq(
    pointer.add(1UL).as_readonly().read_readonly_pointer().address(),
    second.address(),
  )
}

///|
fn uint64_array_as_csize_array(value : FixedArray[UInt64]) -> FixedArray[CSize] = "%identity"

///|
test "size_t fixed arrays expose their storage" {
  let values = uint64_array_as_csize_array([11UL, 22UL])
  let pointer = CSizeArrayAsPointer::as_pointer(values)
  assert_eq(pointer.as_readonly().read_size(), 11UL)
  assert_eq(pointer.add(1UL).as_readonly().read_size(), 22UL)
}

///|
fn byte_array_as_cint8_array(value : FixedArray[Byte]) -> FixedArray[CInt8] = "%identity"

///|
fn byte_array_as_cbool_array(value : FixedArray[Byte]) -> FixedArray[CBool] = "%identity"

///|
fn byte_array_as_cchar_array(value : FixedArray[Byte]) -> FixedArray[CChar] = "%identity"

///|
fn byte_array_as_csigned_char_array(
  value : FixedArray[Byte],
) -> FixedArray[CSignedChar] = "%identity"

///|
fn int64_array_as_clong_array(value : FixedArray[Int64]) -> FixedArray[CLong] = "%identity"

///|
fn uint64_array_as_cunsigned_long_array(
  value : FixedArray[UInt64],
) -> FixedArray[CUnsignedLong] = "%identity"

///|
fn int64_array_as_cptrdiff_array(
  value : FixedArray[Int64],
) -> FixedArray[CPtrDiff] = "%identity"

///|
test "opaque C scalar fixed arrays expose their storage" {
  let int8 = CInt8ArrayAsPointer::as_pointer(byte_array_as_cint8_array([0xff]))
  assert_eq(int8.as_readonly().read_int8(), -1)

  let bool = CBoolArrayAsPointer::as_pointer(byte_array_as_cbool_array([1]))
  assert_eq(bool.as_readonly().read_bool(), true)

  let char = CCharArrayAsPointer::as_pointer(byte_array_as_cchar_array([65]))
  assert_eq(char.as_readonly().read_char(), 65)

  let signed_char = CSignedCharArrayAsPointer::as_pointer(
    byte_array_as_csigned_char_array([0xff]),
  )
  assert_eq(signed_char.as_readonly().read_signed_char(), -1)

  let long = CLongArrayAsPointer::as_pointer(int64_array_as_clong_array([42L]))
  assert_eq(long.as_readonly().read_long(), 42L)

  let unsigned_long = CUnsignedLongArrayAsPointer::as_pointer(
    uint64_array_as_cunsigned_long_array([43UL]),
  )
  assert_eq(unsigned_long.as_readonly().read_unsigned_long(), 43UL)

  let ptrdiff = CPtrDiffArrayAsPointer::as_pointer(
    int64_array_as_cptrdiff_array([-44L]),
  )
  assert_eq(ptrdiff.as_readonly().read_ptrdiff(), -44L)
}

///|
extern "c" fn test_cuint8_value() -> CUInt8 = "c_mbt_test_cuint8_value"

///|
extern "c" fn test_cint32_value() -> CInt32 = "c_mbt_test_cint32_value"

///|
test "fixed-width C aliases cross FFI directly" {
  let int32 : Int = test_cint32_value()
  let uint8 : Byte = test_cuint8_value()
  assert_eq(int32, 123)
  assert_eq(uint8, 0xff)
}

///|
test "16-bit reads and writes preserve MoonBit value types" {
  let signed : Pointer[CInt16] = test_bytes_pointer().unsafe_cast()
  let signed_value = Int16::from_int(-32768)
  signed.write_int16(signed_value)
  let signed_result : Int16 = signed.as_readonly().read_int16()
  assert_eq(signed_result, signed_value)
  signed.write_short(signed_value)
  let short_result : Int16 = signed.as_readonly().read_short()
  assert_eq(short_result, signed_value)

  let unsigned : Pointer[CUInt16] = signed.unsafe_cast()
  let unsigned_value : UInt16 = 65535
  unsigned.write_uint16(unsigned_value)
  let unsigned_result : UInt16 = unsigned.as_readonly().read_uint16()
  assert_eq(unsigned_result, unsigned_value)
  unsigned.write_unsigned_short(unsigned_value)
  let ushort_result : UInt16 = unsigned.as_readonly().read_unsigned_short()
  assert_eq(ushort_result, unsigned_value)
}
