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
  let second = first.offset_bytes(4L)
  second.write_int32(42)
  assert_eq(first.as_readonly().offset_bytes(4L).read_int32(), 42)
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
  assert_eq(pointer.element_size(), 4L)
  assert_eq(pointer.offset(1L).address() - pointer.address(), 4UL)
  pointer.set_int32(0L, 10)
  pointer.set_int32(1L, 20)
  let read_only_pointer = pointer.as_readonly()
  assert_eq(read_only_pointer.get_int32(0L), 10)
  assert_eq(read_only_pointer.get_int32(1L), 20)
  assert_eq(CChar::size_of(), 1L)
  assert_eq(pointer.element_alignment(), CInt32::align_of())
  assert_eq(test_pointer_pointer().element_size(), CSize::size_of())
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
  bytes.set_unsigned_char(0L, b'\x01')
  bytes.set_unsigned_char(1L, b'\x02')
  bytes.set_unsigned_char(2L, b'\x03')
  bytes.set_unsigned_char(3L, b'\x04')
  bytes.offset(8L).copy_non_overlapping_from(bytes.as_readonly(), 4UL)
  assert_eq(bytes.as_readonly().get_unsigned_char(8L), b'\x01')
  assert_eq(bytes.as_readonly().get_unsigned_char(11L), b'\x04')
  bytes.offset(1L).move_from(bytes.as_readonly(), 4UL)
  assert_eq(bytes.as_readonly().get_unsigned_char(1L), b'\x01')
  assert_eq(bytes.as_readonly().get_unsigned_char(4L), b'\x04')
  bytes.offset(8L).zero(4UL)
  assert_eq(bytes.as_readonly().get_unsigned_char(8L), b'\x00')
  assert_eq(bytes.as_readonly().get_unsigned_char(11L), b'\x00')
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
