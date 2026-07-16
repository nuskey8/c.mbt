///|
extern "c" fn test_int32_pointer() -> Pointer[CInt32] = "c_mbt_test_int32_pointer"

///|
extern "c" fn test_double_pointer() -> Pointer[CDouble] = "c_mbt_test_double_pointer"

///|
extern "c" fn test_pointer_pointer() -> Pointer[Pointer[CInt32]] = "c_mbt_test_pointer_pointer"

///|
extern "c" fn test_bytes_pointer() -> Pointer[CUnsignedChar] = "c_mbt_test_bytes_pointer"

///|
#borrow(values)
extern "c" fn test_byte_array_round_trip(
  values : FixedArray[Byte],
  length : Int,
) -> UInt = "c_mbt_test_byte_array_round_trip"

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
  let pointer : ReadOnlyPointer[CUInt8] = BytesAsPointer::as_pointer(bytes)
  assert_eq(pointer.read_uint8(), b'a')
  assert_eq(pointer.add(2UL).read_uint8(), b'c')
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
test "byte fixed arrays round-trip through C as contiguous uint8_t storage" {
  let values : FixedArray[Byte] = [1, 2, 3, 4, 5, 6]
  let pointer = ByteArrayAsPointer::as_pointer(values)
  assert_eq(test_byte_array_round_trip(values, values.length()), 21U)
  assert_eq(values[0], 0)
  assert_eq(values[1], 127)
  assert_eq(values[2], 3)
  assert_eq(values[4], 5)
  assert_eq(values[5], 255)
  assert_eq(pointer.as_readonly().read_uint8(), 0)
  assert_eq(pointer.add(5UL).as_readonly().read_uint8(), 255)
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
test "C scalar aliases expose contiguous fixed-array storage" {
  let size_values : FixedArray[CSize] = [11UL, 22UL]
  let size_pointer = CSizeArrayAsPointer::as_pointer(size_values)
  assert_eq(size_pointer.as_readonly().read_size(), 11UL)
  assert_eq(size_pointer.add(1UL).as_readonly().read_size(), 22UL)

  let int8_values : FixedArray[CInt8] = [0xff]
  let int8_pointer = CInt8ArrayAsPointer::as_pointer(int8_values)
  assert_eq(int8_pointer.as_readonly().read_int8(), -1)

  let bool_values : FixedArray[CBool] = [1]
  let bool_pointer = CBoolArrayAsPointer::as_pointer(bool_values)
  assert_true(bool_pointer.as_readonly().read_bool())

  let char_values : FixedArray[CChar] = [65]
  let char_pointer = CCharArrayAsPointer::as_pointer(char_values)
  assert_eq(char_pointer.as_readonly().read_char(), 65)

  let signed_char_values : FixedArray[CSignedChar] = [0xff]
  let signed_char_pointer = CSignedCharArrayAsPointer::as_pointer(
    signed_char_values,
  )
  assert_eq(signed_char_pointer.as_readonly().read_signed_char(), -1)

  let long_values : FixedArray[CLong] = [42]
  let long_pointer = CLongArrayAsPointer::as_pointer(long_values)
  assert_eq(long_pointer.as_readonly().read_long(), 42L)

  let unsigned_long_values : FixedArray[CUnsignedLong] = [43]
  let unsigned_long_pointer = CUnsignedLongArrayAsPointer::as_pointer(
    unsigned_long_values,
  )
  assert_eq(unsigned_long_pointer.as_readonly().read_unsigned_long(), 43UL)

  let ptrdiff_values : FixedArray[CPtrDiff] = [-44L]
  let ptrdiff_pointer = CPtrDiffArrayAsPointer::as_pointer(ptrdiff_values)
  assert_eq(ptrdiff_pointer.as_readonly().read_ptrdiff(), -44L)

  let intptr_values : FixedArray[CIntPtr] = [-45L]
  let intptr_pointer = CIntPtrArrayAsPointer::as_pointer(intptr_values)
  assert_eq(intptr_pointer.as_readonly().read_intptr(), -45L)

  let uintptr_values : FixedArray[CUIntPtr] = [46UL]
  let uintptr_pointer = CUIntPtrArrayAsPointer::as_pointer(uintptr_values)
  assert_eq(uintptr_pointer.as_readonly().read_uintptr(), 46UL)
}

///|
test "pointer-sized integer layout and access" {
  let intptr : Pointer[CIntPtr] = test_bytes_pointer().unsafe_cast()
  intptr.write_intptr(-123L)
  assert_eq(intptr.as_readonly().read_intptr(), -123L)
  assert_eq(intptr.add(1UL).address() - intptr.address(), 8UL)

  let uintptr : Pointer[CUIntPtr] = test_bytes_pointer().unsafe_cast()
  uintptr.write_uintptr(456UL)
  assert_eq(uintptr.as_readonly().read_uintptr(), 456UL)
  assert_eq(uintptr.add(1UL).address() - uintptr.address(), 8UL)
}

///|
extern "c" fn test_cuint8_value() -> CUInt8 = "c_mbt_test_cuint8_value"

///|
extern "c" fn test_cint32_value() -> CInt32 = "c_mbt_test_cint32_value"

///|
extern "c" fn test_function_pointer_as_void_pointer(
  function : FuncRef[(Int) -> Int],
) -> Pointer[CVoid] = "c_mbt_test_function_pointer_as_void_pointer"

///|
extern "c" fn test_call_function_pointer_array(
  functions : Pointer[FuncRef[(Int) -> Int]],
  index : Int,
  value : Int,
) -> Int = "c_mbt_test_call_function_pointer_array"

///|
test "FuncRef::as_void_pointer preserves the function address" {
  let function : FuncRef[(Int) -> Int] = fn(value) { value + 1 }
  let pointer = FuncRefAsVoidPointer::as_void_pointer(function)
  assert_eq(
    pointer.address(),
    test_function_pointer_as_void_pointer(function).address(),
  )
  let restored : FuncRef[(Int) -> Int] = FuncRefPointer::unsafe_from_void_pointer(
    pointer,
  )
  assert_eq(restored(41), 42)
}

///|
test "all pointer kinds can be viewed as void pointers" {
  let pointer = test_int32_pointer()
  assert_eq(pointer.as_void_pointer().address(), pointer.address())
  let read_only = pointer.as_readonly()
  assert_eq(read_only.as_void_pointer().address(), read_only.address())
}

///|
test "FuncRef fixed arrays expose function-pointer storage" {
  let increment : FuncRef[(Int) -> Int] = fn(value) { value + 1 }
  let double : FuncRef[(Int) -> Int] = fn(value) { value * 2 }
  let functions : FixedArray[FuncRef[(Int) -> Int]] = [increment, double]
  let pointer = FuncRefArray::as_pointer(functions)
  assert_eq(test_call_function_pointer_array(pointer, 0, 41), 42)
  assert_eq(test_call_function_pointer_array(pointer, 1, 21), 42)
}

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
