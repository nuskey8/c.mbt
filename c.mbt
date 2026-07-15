///|
/// Marker for `void`.
pub type CVoid

///|
/// Marker for `int8_t`.
pub type CInt8

///|
/// Marker for `uint8_t`.
pub type CUInt8

///|
/// Marker for `int16_t`.
pub type CInt16

///|
/// Marker for `uint16_t`.
pub type CUInt16

///|
/// Marker for `int32_t`.
pub type CInt32

///|
/// Marker for `uint32_t`.
pub type CUInt32

///|
/// Marker for `int64_t`.
pub type CInt64

///|
/// Marker for `uint64_t`.
pub type CUInt64

///|
/// Marker for C `float`.
pub type CFloat

///|
/// Marker for C `double`.
pub type CDouble

///|
/// A non-owning mutable C pointer.
/// 
/// `T` is a phantom pointee type. This type does not keep the pointed-to memory
/// alive and does not free it. Dereferencing a null, dangling, misaligned, or
/// incorrectly typed pointer is undefined behavior.
#external
pub type Pointer[T]

///|
/// A non-owning read-only C pointer.
///
/// Read-only applies through this value; it does not imply that the underlying
/// allocation is immutable.
#external
pub type ReadOnlyPointer[T]

///|
extern "c" fn pointer_null_raw() -> Pointer[CVoid] = "c_mbt_pointer_null"

///|
#borrow(pointer)
extern "c" fn pointer_is_null_raw(pointer : Pointer[CVoid]) -> Bool = "c_mbt_pointer_is_null"

///|
#borrow(pointer)
extern "c" fn pointer_address_raw(pointer : Pointer[CVoid]) -> UInt64 = "c_mbt_pointer_address"

///|
extern "c" fn pointer_from_address_raw(address : UInt64) -> Pointer[CVoid] = "c_mbt_pointer_from_address"

///|
#borrow(pointer)
extern "c" fn pointer_offset_bytes_raw(
  pointer : Pointer[CVoid],
  offset : Int64,
) -> Pointer[CVoid] = "c_mbt_pointer_offset_bytes"

///|
#borrow(pointer)
extern "c" fn pointer_add_bytes_raw(
  pointer : Pointer[CVoid],
  count : UInt64,
) -> Pointer[CVoid] = "c_mbt_pointer_add_bytes"

///|
#borrow(pointer)
extern "c" fn pointer_sub_bytes_raw(
  pointer : Pointer[CVoid],
  count : UInt64,
) -> Pointer[CVoid] = "c_mbt_pointer_sub_bytes"

///|
fn[T] pointer_from_raw(pointer : Pointer[CVoid]) -> Pointer[T] = "%identity"

///|
fn[T] pointer_to_raw(pointer : Pointer[T]) -> Pointer[CVoid] = "%identity"

///|
fn[T] readonly_pointer_from_raw(pointer : Pointer[CVoid]) -> ReadOnlyPointer[T] = "%identity"

///|
fn[T] readonly_pointer_to_raw(pointer : ReadOnlyPointer[T]) -> Pointer[CVoid] = "%identity"

///|
/// Returns a null mutable pointer.
pub fn[T] Pointer::null() -> Pointer[T] {
  pointer_from_raw(pointer_null_raw())
}

///|
/// Returns a null read-only pointer.
pub fn[T] ReadOnlyPointer::null() -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(pointer_null_raw())
}

///|
/// Returns whether this pointer is null.
pub fn[T] Pointer::is_null(self : Pointer[T]) -> Bool {
  pointer_is_null_raw(pointer_to_raw(self))
}

///|
/// Returns whether this pointer is null.
pub fn[T] ReadOnlyPointer::is_null(self : ReadOnlyPointer[T]) -> Bool {
  pointer_is_null_raw(readonly_pointer_to_raw(self))
}

///|
/// Returns the numeric address represented by this pointer.
pub fn[T] Pointer::address(self : Pointer[T]) -> UInt64 {
  pointer_address_raw(pointer_to_raw(self))
}

///|
/// Returns the numeric address represented by this pointer.
pub fn[T] ReadOnlyPointer::address(self : ReadOnlyPointer[T]) -> UInt64 {
  pointer_address_raw(readonly_pointer_to_raw(self))
}

///| Constructs a mutable pointer from a numeric address.

///|
/// The caller must ensure the address is valid for every later operation.
pub fn[T] Pointer::unsafe_from_address(address : UInt64) -> Pointer[T] {
  pointer_from_raw(pointer_from_address_raw(address))
}

///| Constructs a read-only pointer from a numeric address.

///|
/// The caller must ensure the address is valid for every later operation.
pub fn[T] ReadOnlyPointer::unsafe_from_address(
  address : UInt64,
) -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(pointer_from_address_raw(address))
}

///|
/// Creates a read-only view of this pointer.
pub fn[T] Pointer::as_readonly(self : Pointer[T]) -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(pointer_to_raw(self))
}

///|
/// Reinterprets the pointee type without changing the address.
pub fn[T, U] Pointer::unsafe_cast(self : Pointer[T]) -> Pointer[U] {
  pointer_from_raw(pointer_to_raw(self))
}

///|
/// Reinterprets the pointee type without changing the address.
pub fn[T, U] ReadOnlyPointer::unsafe_cast(
  self : ReadOnlyPointer[T],
) -> ReadOnlyPointer[U] {
  readonly_pointer_from_raw(readonly_pointer_to_raw(self))
}

///|
#borrow(pointer)
extern "c" fn read_int8_raw(pointer : ReadOnlyPointer[CInt8]) -> Int = "c_mbt_read_int8"

///|
#borrow(pointer)
extern "c" fn read_uint8_raw(pointer : ReadOnlyPointer[CUInt8]) -> Byte = "c_mbt_read_uint8"

///|
#borrow(pointer)
extern "c" fn read_int16_raw(pointer : ReadOnlyPointer[CInt16]) -> Int = "c_mbt_read_int16"

///|
#borrow(pointer)
extern "c" fn read_uint16_raw(pointer : ReadOnlyPointer[CUInt16]) -> UInt = "c_mbt_read_uint16"

///|
#borrow(pointer)
extern "c" fn read_int32_raw(pointer : ReadOnlyPointer[CInt32]) -> Int = "c_mbt_read_int32"

///|
#borrow(pointer)
extern "c" fn read_uint32_raw(pointer : ReadOnlyPointer[CUInt32]) -> UInt = "c_mbt_read_uint32"

///|
#borrow(pointer)
extern "c" fn read_int64_raw(pointer : ReadOnlyPointer[CInt64]) -> Int64 = "c_mbt_read_int64"

///|
#borrow(pointer)
extern "c" fn read_uint64_raw(pointer : ReadOnlyPointer[CUInt64]) -> UInt64 = "c_mbt_read_uint64"

///|
#borrow(pointer)
extern "c" fn read_float_raw(pointer : ReadOnlyPointer[CFloat]) -> Float = "c_mbt_read_float"

///|
#borrow(pointer)
extern "c" fn read_double_raw(pointer : ReadOnlyPointer[CDouble]) -> Double = "c_mbt_read_double"

///|
/// Reads an `int8_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_int8(self : ReadOnlyPointer[CInt8]) -> Int {
  read_int8_raw(self)
}

///|
/// Reads a `uint8_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_uint8(self : ReadOnlyPointer[CUInt8]) -> Byte {
  read_uint8_raw(self)
}

///|
/// Reads an `int16_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_int16(self : ReadOnlyPointer[CInt16]) -> Int {
  read_int16_raw(self)
}

///|
/// Reads a `uint16_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_uint16(self : ReadOnlyPointer[CUInt16]) -> UInt {
  read_uint16_raw(self)
}

///|
/// Reads an `int32_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_int32(self : ReadOnlyPointer[CInt32]) -> Int {
  read_int32_raw(self)
}

///|
/// Reads a `uint32_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_uint32(self : ReadOnlyPointer[CUInt32]) -> UInt {
  read_uint32_raw(self)
}

///|
/// Reads an `int64_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_int64(self : ReadOnlyPointer[CInt64]) -> Int64 {
  read_int64_raw(self)
}

///|
/// Reads a `uint64_t`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_uint64(self : ReadOnlyPointer[CUInt64]) -> UInt64 {
  read_uint64_raw(self)
}

///|
/// Reads a C `float`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_float(self : ReadOnlyPointer[CFloat]) -> Float {
  read_float_raw(self)
}

///|
/// Reads a C `double`. The pointer must be valid and correctly aligned.
pub fn ReadOnlyPointer::read_double(self : ReadOnlyPointer[CDouble]) -> Double {
  read_double_raw(self)
}

///|
#borrow(pointer)
extern "c" fn write_int8_raw(pointer : Pointer[CInt8], value : Int) -> Unit = "c_mbt_write_int8"

///|
#borrow(pointer)
extern "c" fn write_uint8_raw(pointer : Pointer[CUInt8], value : Byte) -> Unit = "c_mbt_write_uint8"

///|
#borrow(pointer)
extern "c" fn write_int16_raw(pointer : Pointer[CInt16], value : Int) -> Unit = "c_mbt_write_int16"

///|
#borrow(pointer)
extern "c" fn write_uint16_raw(
  pointer : Pointer[CUInt16],
  value : UInt,
) -> Unit = "c_mbt_write_uint16"

///|
#borrow(pointer)
extern "c" fn write_int32_raw(pointer : Pointer[CInt32], value : Int) -> Unit = "c_mbt_write_int32"

///|
#borrow(pointer)
extern "c" fn write_uint32_raw(
  pointer : Pointer[CUInt32],
  value : UInt,
) -> Unit = "c_mbt_write_uint32"

///|
#borrow(pointer)
extern "c" fn write_int64_raw(pointer : Pointer[CInt64], value : Int64) -> Unit = "c_mbt_write_int64"

///|
#borrow(pointer)
extern "c" fn write_uint64_raw(
  pointer : Pointer[CUInt64],
  value : UInt64,
) -> Unit = "c_mbt_write_uint64"

///|
#borrow(pointer)
extern "c" fn write_float_raw(pointer : Pointer[CFloat], value : Float) -> Unit = "c_mbt_write_float"

///|
#borrow(pointer)
extern "c" fn write_double_raw(
  pointer : Pointer[CDouble],
  value : Double,
) -> Unit = "c_mbt_write_double"

///|
/// Writes an `int8_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_int8(self : Pointer[CInt8], value : Int) -> Unit {
  write_int8_raw(self, value)
}

///|
/// Writes a `uint8_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_uint8(self : Pointer[CUInt8], value : Byte) -> Unit {
  write_uint8_raw(self, value)
}

///|
/// Writes an `int16_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_int16(self : Pointer[CInt16], value : Int) -> Unit {
  write_int16_raw(self, value)
}

///|
/// Writes a `uint16_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_uint16(self : Pointer[CUInt16], value : UInt) -> Unit {
  write_uint16_raw(self, value)
}

///|
/// Writes an `int32_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_int32(self : Pointer[CInt32], value : Int) -> Unit {
  write_int32_raw(self, value)
}

///|
/// Writes a `uint32_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_uint32(self : Pointer[CUInt32], value : UInt) -> Unit {
  write_uint32_raw(self, value)
}

///|
/// Writes an `int64_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_int64(self : Pointer[CInt64], value : Int64) -> Unit {
  write_int64_raw(self, value)
}

///|
/// Writes a `uint64_t`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_uint64(self : Pointer[CUInt64], value : UInt64) -> Unit {
  write_uint64_raw(self, value)
}

///|
/// Writes a C `float`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_float(self : Pointer[CFloat], value : Float) -> Unit {
  write_float_raw(self, value)
}

///|
/// Writes a C `double`. The pointer must be valid and correctly aligned.
pub fn Pointer::write_double(self : Pointer[CDouble], value : Double) -> Unit {
  write_double_raw(self, value)
}
