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
  values : Pointer[Byte],
  length : Int,
) -> UInt = "c_mbt_test_byte_array_round_trip"

///|
#borrow(destination, source)
extern "c" fn test_byte_array_bulk_transform(
  destination : Pointer[Byte],
  source : ReadOnlyPointer[Byte],
  length : Int,
) -> UInt = "c_mbt_test_byte_array_bulk_transform"

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
test "Bytes::with_pointer exposes scoped read-only storage" {
  let bytes = b"abc"
  let result = BytesAsPointer::with_pointer(bytes, pointer => {
    pointer.read_uint8().to_uint() + pointer.add(2UL).read_uint8().to_uint()
  })
  assert_eq(result, b'a'.to_uint() + b'c'.to_uint())
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
test "byte fixed arrays expose scoped mutable storage" {
  let values : FixedArray[Byte] = [1, 2, 3, 4]
  let result = ByteArrayAsPointer::with_pointer(values, pointer => {
    pointer.add(1UL).write_uint8(20)
    pointer.add(2UL).write_uint8(30)
    pointer.as_readonly().read_uint8().to_uint() +
    pointer.add(3UL).as_readonly().read_uint8().to_uint()
  })
  assert_eq(result, 5U)
  assert_eq(values, [1, 20, 30, 4])
}

///|
test "byte fixed arrays round-trip through C as contiguous uint8_t storage" {
  let values : FixedArray[Byte] = [1, 2, 3, 4, 5, 6]
  let result = ByteArrayAsPointer::with_pointer(values, pointer => {
    let checksum = test_byte_array_round_trip(pointer, values.length())
    (
      checksum,
      pointer.as_readonly().read_uint8(),
      pointer.add(5UL).as_readonly().read_uint8(),
    )
  })
  assert_eq(result.0, 21U)
  assert_eq(values[0], 0)
  assert_eq(values[1], 127)
  assert_eq(values[2], 3)
  assert_eq(values[4], 5)
  assert_eq(values[5], 255)
  assert_eq(result.1, 0)
  assert_eq(result.2, 255)
}

///|
test "byte fixed-array pointers support multi-byte C reads and writes" {
  let length = 4099
  let source = FixedArray::make(length, b'\x00')
  let destination = FixedArray::make(length + 2, b'\xcc')
  let mut expected_checksum = 0U
  for i in 0..<length {
    source[i] = (i * 37 + 11).to_byte()
    expected_checksum += source[i].to_uint()
  }
  let checksum = ByteArrayAsPointer::with_pointer(source, source_pointer => {
    ByteArrayAsPointer::with_pointer(destination, destination_pointer => {
      test_byte_array_bulk_transform(
        destination_pointer.add(1UL),
        source_pointer.as_readonly(),
        length,
      )
    })
  })
  assert_eq(checksum, expected_checksum)
  assert_eq(destination[0], b'\xcc')
  assert_eq(destination[length + 1], b'\xcc')
  for i in 0..<length {
    assert_eq(source[i], (i * 37 + 11).to_byte())
    assert_eq(destination[i + 1], (source[i].to_int() + i).to_byte())
  }
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
test "all scalar fixed-array conversions expose scoped storage" {
  let ints : FixedArray[Int] = [11]
  assert_eq(
    IntArrayAsPointer::with_pointer(ints, pointer => {
      pointer.as_readonly().read_int32()
    }),
    11,
  )
  let uints : FixedArray[UInt] = [12U]
  assert_eq(
    UIntArrayAsPointer::with_pointer(uints, pointer => {
      pointer.as_readonly().read_uint32()
    }),
    12U,
  )
  let int16s : FixedArray[Int16] = [13]
  assert_eq(
    Int16ArrayAsPointer::with_pointer(int16s, pointer => {
      pointer.as_readonly().read_int16()
    }),
    13,
  )
  let uint16s : FixedArray[UInt16] = [14]
  assert_eq(
    UInt16ArrayAsPointer::with_pointer(uint16s, pointer => {
      pointer.as_readonly().read_uint16()
    }),
    14,
  )
  let int64s : FixedArray[Int64] = [15L]
  assert_eq(
    Int64ArrayAsPointer::with_pointer(int64s, pointer => {
      pointer.as_readonly().read_int64()
    }),
    15L,
  )
  let uint64s : FixedArray[UInt64] = [16UL]
  assert_eq(
    UInt64ArrayAsPointer::with_pointer(uint64s, pointer => {
      pointer.as_readonly().read_uint64()
    }),
    16UL,
  )
  let floats : FixedArray[Float] = [17.0]
  assert_eq(
    FloatArrayAsPointer::with_pointer(floats, pointer => {
      pointer.as_readonly().read_float()
    }),
    17.0,
  )
  let doubles : FixedArray[Double] = [18.0]
  assert_eq(
    DoubleArrayAsPointer::with_pointer(doubles, pointer => {
      pointer.as_readonly().read_double()
    }),
    18.0,
  )

  let sizes : FixedArray[CSize] = [19UL]
  assert_eq(
    CSizeArrayAsPointer::with_pointer(sizes, pointer => {
      pointer.as_readonly().read_size()
    }),
    19UL,
  )
  let int8s : FixedArray[CInt8] = [20]
  assert_eq(
    CInt8ArrayAsPointer::with_pointer(int8s, pointer => {
      pointer.as_readonly().read_int8()
    }),
    20,
  )
  let bools : FixedArray[CBool] = [1]
  assert_true(
    CBoolArrayAsPointer::with_pointer(bools, pointer => {
      pointer.as_readonly().read_bool()
    }),
  )
  let chars : FixedArray[CChar] = [65]
  assert_eq(
    CCharArrayAsPointer::with_pointer(chars, pointer => {
      pointer.as_readonly().read_char()
    }),
    65,
  )
  let signed_chars : FixedArray[CSignedChar] = [21]
  assert_eq(
    CSignedCharArrayAsPointer::with_pointer(signed_chars, pointer => {
      pointer.as_readonly().read_signed_char()
    }),
    21,
  )
  let longs : FixedArray[CLong] = [22]
  assert_eq(
    CLongArrayAsPointer::with_pointer(longs, pointer => {
      pointer.as_readonly().read_long()
    }),
    22L,
  )
  let unsigned_longs : FixedArray[CUnsignedLong] = [23]
  assert_eq(
    CUnsignedLongArrayAsPointer::with_pointer(unsigned_longs, pointer => {
      pointer.as_readonly().read_unsigned_long()
    }),
    23UL,
  )
  let ptrdiffs : FixedArray[CPtrDiff] = [24L]
  assert_eq(
    CPtrDiffArrayAsPointer::with_pointer(ptrdiffs, pointer => {
      pointer.as_readonly().read_ptrdiff()
    }),
    24L,
  )
  let intptrs : FixedArray[CIntPtr] = [25L]
  assert_eq(
    CIntPtrArrayAsPointer::with_pointer(intptrs, pointer => {
      pointer.as_readonly().read_intptr()
    }),
    25L,
  )
  let uintptrs : FixedArray[CUIntPtr] = [26UL]
  assert_eq(
    CUIntPtrArrayAsPointer::with_pointer(uintptrs, pointer => {
      pointer.as_readonly().read_uintptr()
    }),
    26UL,
  )
}

///|
test "pointer fixed arrays expose T double-pointer storage" {
  let first = test_int32_pointer()
  let second = first.add(1UL)
  let pointers : FixedArray[Pointer[CInt32]] = [first, second]
  let addresses = PointerArray::with_pointer(pointers, pointer => {
    (
      pointer.as_readonly().read_pointer().address(),
      pointer.add(1UL).as_readonly().read_pointer().address(),
    )
  })
  assert_eq(addresses.0, first.address())
  assert_eq(addresses.1, second.address())
}

///|
test "read-only pointer fixed arrays expose const T double-pointer storage" {
  let first = test_int32_pointer().as_readonly()
  let second = test_int32_pointer().add(1UL).as_readonly()
  let pointers : FixedArray[ReadOnlyPointer[CInt32]] = [first, second]
  let addresses = ReadOnlyPointerArray::with_pointer(pointers, pointer => {
    (
      pointer.as_readonly().read_readonly_pointer().address(),
      pointer.add(1UL).as_readonly().read_readonly_pointer().address(),
    )
  })
  assert_eq(addresses.0, first.address())
  assert_eq(addresses.1, second.address())
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
  let results = FuncRefArray::with_pointer(functions, pointer => {
    (
      test_call_function_pointer_array(pointer, 0, 41),
      test_call_function_pointer_array(pointer, 1, 21),
    )
  })
  assert_eq(results, (42, 42))
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
