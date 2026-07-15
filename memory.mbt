///|
#borrow(pointer)
extern "c" fn read_pointer_raw(
  pointer : ReadOnlyPointer[CVoid],
) -> Pointer[CVoid] = "c_mbt_read_pointer"

///|
#borrow(pointer, value)
extern "c" fn write_pointer_raw(
  pointer : Pointer[CVoid],
  value : Pointer[CVoid],
) -> Unit = "c_mbt_write_pointer"

///|
/// Reads a mutable pointer through a pointer-to-pointer.
pub fn[T] ReadOnlyPointer::read_pointer(
  self : ReadOnlyPointer[Pointer[T]],
) -> Pointer[T] {
  pointer_from_raw(read_pointer_raw(self.unsafe_cast()))
}

///|
/// Writes a mutable pointer through a pointer-to-pointer.
pub fn[T] Pointer::write_pointer(
  self : Pointer[Pointer[T]],
  value : Pointer[T],
) -> Unit {
  write_pointer_raw(self.unsafe_cast(), pointer_to_raw(value))
}

///|
/// Reads a read-only pointer through a pointer-to-pointer.
pub fn[T] ReadOnlyPointer::read_readonly_pointer(
  self : ReadOnlyPointer[ReadOnlyPointer[T]],
) -> ReadOnlyPointer[T] {
  readonly_pointer_from_raw(read_pointer_raw(self.unsafe_cast()))
}

///|
/// Writes a read-only pointer through a pointer-to-pointer.
pub fn[T] Pointer::write_readonly_pointer(
  self : Pointer[ReadOnlyPointer[T]],
  value : ReadOnlyPointer[T],
) -> Unit {
  write_pointer_raw(self.unsafe_cast(), readonly_pointer_to_raw(value))
}

///|
#borrow(destination, source)
extern "c" fn copy_non_overlapping_raw(
  destination : Pointer[CVoid],
  source : ReadOnlyPointer[CVoid],
  byte_count : UInt64,
) -> Unit = "c_mbt_copy_non_overlapping"

///|
#borrow(destination, source)
extern "c" fn move_raw(
  destination : Pointer[CVoid],
  source : ReadOnlyPointer[CVoid],
  byte_count : UInt64,
) -> Unit = "c_mbt_move"

///|
#borrow(destination)
extern "c" fn fill_raw(
  destination : Pointer[CVoid],
  value : Byte,
  byte_count : UInt64,
) -> Unit = "c_mbt_fill"

///| Copies bytes from a non-overlapping source region.

///|
/// Both regions must be valid for `byte_count` bytes and must not overlap.
pub fn[T, U] Pointer::copy_non_overlapping_from(
  self : Pointer[T],
  source : ReadOnlyPointer[U],
  byte_count : UInt64,
) -> Unit {
  copy_non_overlapping_raw(
    pointer_to_raw(self),
    source.unsafe_cast(),
    byte_count,
  )
}

///|
/// Copies bytes from a possibly overlapping source region.
pub fn[T, U] Pointer::move_from(
  self : Pointer[T],
  source : ReadOnlyPointer[U],
  byte_count : UInt64,
) -> Unit {
  move_raw(pointer_to_raw(self), source.unsafe_cast(), byte_count)
}

///|
/// Fills `byte_count` bytes with `value`.
pub fn[T] Pointer::fill(
  self : Pointer[T],
  value : Byte,
  byte_count : UInt64,
) -> Unit {
  fill_raw(pointer_to_raw(self), value, byte_count)
}

///|
/// Fills `byte_count` bytes with zero.
pub fn[T] Pointer::zero(self : Pointer[T], byte_count : UInt64) -> Unit {
  fill_raw(pointer_to_raw(self), b'\x00', byte_count)
}

///|
#borrow(pointer)
extern "c" fn read_bool_raw(pointer : ReadOnlyPointer[CBool]) -> Bool = "c_mbt_read_bool"

///|
#borrow(pointer)
extern "c" fn read_char_raw(pointer : ReadOnlyPointer[CChar]) -> Int = "c_mbt_read_char"

///|
#borrow(pointer)
extern "c" fn read_signed_char_raw(
  pointer : ReadOnlyPointer[CSignedChar],
) -> Int = "c_mbt_read_signed_char"

///|
#borrow(pointer)
extern "c" fn read_unsigned_char_raw(
  pointer : ReadOnlyPointer[CUnsignedChar],
) -> Byte = "c_mbt_read_unsigned_char"

///|
#borrow(pointer)
extern "c" fn read_short_raw(pointer : ReadOnlyPointer[CShort]) -> Int = "c_mbt_read_short"

///|
#borrow(pointer)
extern "c" fn read_unsigned_short_raw(
  pointer : ReadOnlyPointer[CUnsignedShort],
) -> UInt = "c_mbt_read_unsigned_short"

///|
#borrow(pointer)
extern "c" fn read_int_raw(pointer : ReadOnlyPointer[CInt]) -> Int = "c_mbt_read_int"

///|
#borrow(pointer)
extern "c" fn read_unsigned_int_raw(
  pointer : ReadOnlyPointer[CUnsignedInt],
) -> UInt = "c_mbt_read_unsigned_int"

///|
#borrow(pointer)
extern "c" fn read_long_raw(pointer : ReadOnlyPointer[CLong]) -> Int64 = "c_mbt_read_long"

///|
#borrow(pointer)
extern "c" fn read_unsigned_long_raw(
  pointer : ReadOnlyPointer[CUnsignedLong],
) -> UInt64 = "c_mbt_read_unsigned_long"

///|
#borrow(pointer)
extern "c" fn read_long_long_raw(pointer : ReadOnlyPointer[CLongLong]) -> Int64 = "c_mbt_read_long_long"

///|
#borrow(pointer)
extern "c" fn read_unsigned_long_long_raw(
  pointer : ReadOnlyPointer[CUnsignedLongLong],
) -> UInt64 = "c_mbt_read_unsigned_long_long"

///|
#borrow(pointer)
extern "c" fn read_size_raw(pointer : ReadOnlyPointer[CSize]) -> UInt64 = "c_mbt_read_size"

///|
#borrow(pointer)
extern "c" fn read_ptrdiff_raw(pointer : ReadOnlyPointer[CPtrDiff]) -> Int64 = "c_mbt_read_ptrdiff"

///|
pub fn ReadOnlyPointer::read_bool(self : ReadOnlyPointer[CBool]) -> Bool {
  read_bool_raw(self)
}

///|
pub fn ReadOnlyPointer::read_char(self : ReadOnlyPointer[CChar]) -> Int {
  read_char_raw(self)
}

///|
pub fn ReadOnlyPointer::read_signed_char(
  self : ReadOnlyPointer[CSignedChar],
) -> Int {
  read_signed_char_raw(self)
}

///|
pub fn ReadOnlyPointer::read_unsigned_char(
  self : ReadOnlyPointer[CUnsignedChar],
) -> Byte {
  read_unsigned_char_raw(self)
}

///|
pub fn ReadOnlyPointer::read_short(self : ReadOnlyPointer[CShort]) -> Int {
  read_short_raw(self)
}

///|
pub fn ReadOnlyPointer::read_unsigned_short(
  self : ReadOnlyPointer[CUnsignedShort],
) -> UInt {
  read_unsigned_short_raw(self)
}

///|
pub fn ReadOnlyPointer::read_int(self : ReadOnlyPointer[CInt]) -> Int {
  read_int_raw(self)
}

///|
pub fn ReadOnlyPointer::read_unsigned_int(
  self : ReadOnlyPointer[CUnsignedInt],
) -> UInt {
  read_unsigned_int_raw(self)
}

///|
pub fn ReadOnlyPointer::read_long(self : ReadOnlyPointer[CLong]) -> Int64 {
  read_long_raw(self)
}

///|
pub fn ReadOnlyPointer::read_unsigned_long(
  self : ReadOnlyPointer[CUnsignedLong],
) -> UInt64 {
  read_unsigned_long_raw(self)
}

///|
pub fn ReadOnlyPointer::read_long_long(
  self : ReadOnlyPointer[CLongLong],
) -> Int64 {
  read_long_long_raw(self)
}

///|
pub fn ReadOnlyPointer::read_unsigned_long_long(
  self : ReadOnlyPointer[CUnsignedLongLong],
) -> UInt64 {
  read_unsigned_long_long_raw(self)
}

///|
pub fn ReadOnlyPointer::read_size(self : ReadOnlyPointer[CSize]) -> UInt64 {
  read_size_raw(self)
}

///|
pub fn ReadOnlyPointer::read_ptrdiff(self : ReadOnlyPointer[CPtrDiff]) -> Int64 {
  read_ptrdiff_raw(self)
}

///|
#borrow(pointer)
extern "c" fn write_bool_raw(pointer : Pointer[CBool], value : Bool) -> Unit = "c_mbt_write_bool"

///|
#borrow(pointer)
extern "c" fn write_char_raw(pointer : Pointer[CChar], value : Int) -> Unit = "c_mbt_write_char"

///|
#borrow(pointer)
extern "c" fn write_signed_char_raw(
  pointer : Pointer[CSignedChar],
  value : Int,
) -> Unit = "c_mbt_write_signed_char"

///|
#borrow(pointer)
extern "c" fn write_unsigned_char_raw(
  pointer : Pointer[CUnsignedChar],
  value : Byte,
) -> Unit = "c_mbt_write_unsigned_char"

///|
#borrow(pointer)
extern "c" fn write_short_raw(pointer : Pointer[CShort], value : Int) -> Unit = "c_mbt_write_short"

///|
#borrow(pointer)
extern "c" fn write_unsigned_short_raw(
  pointer : Pointer[CUnsignedShort],
  value : UInt,
) -> Unit = "c_mbt_write_unsigned_short"

///|
#borrow(pointer)
extern "c" fn write_int_raw(pointer : Pointer[CInt], value : Int) -> Unit = "c_mbt_write_int"

///|
#borrow(pointer)
extern "c" fn write_unsigned_int_raw(
  pointer : Pointer[CUnsignedInt],
  value : UInt,
) -> Unit = "c_mbt_write_unsigned_int"

///|
#borrow(pointer)
extern "c" fn write_long_raw(pointer : Pointer[CLong], value : Int64) -> Unit = "c_mbt_write_long"

///|
#borrow(pointer)
extern "c" fn write_unsigned_long_raw(
  pointer : Pointer[CUnsignedLong],
  value : UInt64,
) -> Unit = "c_mbt_write_unsigned_long"

///|
#borrow(pointer)
extern "c" fn write_long_long_raw(
  pointer : Pointer[CLongLong],
  value : Int64,
) -> Unit = "c_mbt_write_long_long"

///|
#borrow(pointer)
extern "c" fn write_unsigned_long_long_raw(
  pointer : Pointer[CUnsignedLongLong],
  value : UInt64,
) -> Unit = "c_mbt_write_unsigned_long_long"

///|
#borrow(pointer)
extern "c" fn write_size_raw(pointer : Pointer[CSize], value : UInt64) -> Unit = "c_mbt_write_size"

///|
#borrow(pointer)
extern "c" fn write_ptrdiff_raw(
  pointer : Pointer[CPtrDiff],
  value : Int64,
) -> Unit = "c_mbt_write_ptrdiff"

///|
pub fn Pointer::write_bool(self : Pointer[CBool], value : Bool) -> Unit {
  write_bool_raw(self, value)
}

///|
pub fn Pointer::write_char(self : Pointer[CChar], value : Int) -> Unit {
  write_char_raw(self, value)
}

///|
pub fn Pointer::write_signed_char(
  self : Pointer[CSignedChar],
  value : Int,
) -> Unit {
  write_signed_char_raw(self, value)
}

///|
pub fn Pointer::write_unsigned_char(
  self : Pointer[CUnsignedChar],
  value : Byte,
) -> Unit {
  write_unsigned_char_raw(self, value)
}

///|
pub fn Pointer::write_short(self : Pointer[CShort], value : Int) -> Unit {
  write_short_raw(self, value)
}

///|
pub fn Pointer::write_unsigned_short(
  self : Pointer[CUnsignedShort],
  value : UInt,
) -> Unit {
  write_unsigned_short_raw(self, value)
}

///|
pub fn Pointer::write_int(self : Pointer[CInt], value : Int) -> Unit {
  write_int_raw(self, value)
}

///|
pub fn Pointer::write_unsigned_int(
  self : Pointer[CUnsignedInt],
  value : UInt,
) -> Unit {
  write_unsigned_int_raw(self, value)
}

///|
pub fn Pointer::write_long(self : Pointer[CLong], value : Int64) -> Unit {
  write_long_raw(self, value)
}

///|
pub fn Pointer::write_unsigned_long(
  self : Pointer[CUnsignedLong],
  value : UInt64,
) -> Unit {
  write_unsigned_long_raw(self, value)
}

///|
pub fn Pointer::write_long_long(
  self : Pointer[CLongLong],
  value : Int64,
) -> Unit {
  write_long_long_raw(self, value)
}

///|
pub fn Pointer::write_unsigned_long_long(
  self : Pointer[CUnsignedLongLong],
  value : UInt64,
) -> Unit {
  write_unsigned_long_long_raw(self, value)
}

///|
pub fn Pointer::write_size(self : Pointer[CSize], value : UInt64) -> Unit {
  write_size_raw(self, value)
}

///|
pub fn Pointer::write_ptrdiff(self : Pointer[CPtrDiff], value : Int64) -> Unit {
  write_ptrdiff_raw(self, value)
}

///|
/// Reads an `int8_t` element at `index`.
pub fn ReadOnlyPointer::get_int8(
  self : ReadOnlyPointer[CInt8],
  index : Int64,
) -> Int {
  self.offset(index).read_int8()
}

///|
/// Reads a `uint8_t` element at `index`.
pub fn ReadOnlyPointer::get_uint8(
  self : ReadOnlyPointer[CUInt8],
  index : Int64,
) -> Byte {
  self.offset(index).read_uint8()
}

///|
/// Reads an `int16_t` element at `index`.
pub fn ReadOnlyPointer::get_int16(
  self : ReadOnlyPointer[CInt16],
  index : Int64,
) -> Int {
  self.offset(index).read_int16()
}

///|
/// Reads a `uint16_t` element at `index`.
pub fn ReadOnlyPointer::get_uint16(
  self : ReadOnlyPointer[CUInt16],
  index : Int64,
) -> UInt {
  self.offset(index).read_uint16()
}

///|
/// Reads an `int32_t` element at `index`.
pub fn ReadOnlyPointer::get_int32(
  self : ReadOnlyPointer[CInt32],
  index : Int64,
) -> Int {
  self.offset(index).read_int32()
}

///|
/// Reads a `uint32_t` element at `index`.
pub fn ReadOnlyPointer::get_uint32(
  self : ReadOnlyPointer[CUInt32],
  index : Int64,
) -> UInt {
  self.offset(index).read_uint32()
}

///|
/// Reads an `int64_t` element at `index`.
pub fn ReadOnlyPointer::get_int64(
  self : ReadOnlyPointer[CInt64],
  index : Int64,
) -> Int64 {
  self.offset(index).read_int64()
}

///|
/// Reads a `uint64_t` element at `index`.
pub fn ReadOnlyPointer::get_uint64(
  self : ReadOnlyPointer[CUInt64],
  index : Int64,
) -> UInt64 {
  self.offset(index).read_uint64()
}

///|
/// Reads a C `float` element at `index`.
pub fn ReadOnlyPointer::get_float(
  self : ReadOnlyPointer[CFloat],
  index : Int64,
) -> Float {
  self.offset(index).read_float()
}

///|
/// Reads a C `double` element at `index`.
pub fn ReadOnlyPointer::get_double(
  self : ReadOnlyPointer[CDouble],
  index : Int64,
) -> Double {
  self.offset(index).read_double()
}

///|
/// Reads a C `bool` element at `index`.
pub fn ReadOnlyPointer::get_bool(
  self : ReadOnlyPointer[CBool],
  index : Int64,
) -> Bool {
  self.offset(index).read_bool()
}

///|
/// Reads a C `char` element at `index`.
pub fn ReadOnlyPointer::get_char(
  self : ReadOnlyPointer[CChar],
  index : Int64,
) -> Int {
  self.offset(index).read_char()
}

///|
/// Reads a C `signed char` element at `index`.
pub fn ReadOnlyPointer::get_signed_char(
  self : ReadOnlyPointer[CSignedChar],
  index : Int64,
) -> Int {
  self.offset(index).read_signed_char()
}

///|
/// Reads a C `unsigned char` element at `index`.
pub fn ReadOnlyPointer::get_unsigned_char(
  self : ReadOnlyPointer[CUnsignedChar],
  index : Int64,
) -> Byte {
  self.offset(index).read_unsigned_char()
}

///|
/// Reads a C `short` element at `index`.
pub fn ReadOnlyPointer::get_short(
  self : ReadOnlyPointer[CShort],
  index : Int64,
) -> Int {
  self.offset(index).read_short()
}

///|
/// Reads a C `unsigned short` element at `index`.
pub fn ReadOnlyPointer::get_unsigned_short(
  self : ReadOnlyPointer[CUnsignedShort],
  index : Int64,
) -> UInt {
  self.offset(index).read_unsigned_short()
}

///|
/// Reads a C `int` element at `index`.
pub fn ReadOnlyPointer::get_int(
  self : ReadOnlyPointer[CInt],
  index : Int64,
) -> Int {
  self.offset(index).read_int()
}

///|
/// Reads a C `unsigned int` element at `index`.
pub fn ReadOnlyPointer::get_unsigned_int(
  self : ReadOnlyPointer[CUnsignedInt],
  index : Int64,
) -> UInt {
  self.offset(index).read_unsigned_int()
}

///|
/// Reads a C `long` element at `index`.
pub fn ReadOnlyPointer::get_long(
  self : ReadOnlyPointer[CLong],
  index : Int64,
) -> Int64 {
  self.offset(index).read_long()
}

///|
/// Reads a C `unsigned long` element at `index`.
pub fn ReadOnlyPointer::get_unsigned_long(
  self : ReadOnlyPointer[CUnsignedLong],
  index : Int64,
) -> UInt64 {
  self.offset(index).read_unsigned_long()
}

///|
/// Reads a C `long long` element at `index`.
pub fn ReadOnlyPointer::get_long_long(
  self : ReadOnlyPointer[CLongLong],
  index : Int64,
) -> Int64 {
  self.offset(index).read_long_long()
}

///|
/// Reads a C `unsigned long long` element at `index`.
pub fn ReadOnlyPointer::get_unsigned_long_long(
  self : ReadOnlyPointer[CUnsignedLongLong],
  index : Int64,
) -> UInt64 {
  self.offset(index).read_unsigned_long_long()
}

///|
/// Reads a C `size_t` element at `index`.
pub fn ReadOnlyPointer::get_size(
  self : ReadOnlyPointer[CSize],
  index : Int64,
) -> UInt64 {
  self.offset(index).read_size()
}

///|
/// Reads a C `ptrdiff_t` element at `index`.
pub fn ReadOnlyPointer::get_ptrdiff(
  self : ReadOnlyPointer[CPtrDiff],
  index : Int64,
) -> Int64 {
  self.offset(index).read_ptrdiff()
}

///|
/// Writes an `int8_t` element at `index`.
pub fn Pointer::set_int8(
  self : Pointer[CInt8],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_int8(value)
}

///|
/// Writes a `uint8_t` element at `index`.
pub fn Pointer::set_uint8(
  self : Pointer[CUInt8],
  index : Int64,
  value : Byte,
) -> Unit {
  self.offset(index).write_uint8(value)
}

///|
/// Writes an `int16_t` element at `index`.
pub fn Pointer::set_int16(
  self : Pointer[CInt16],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_int16(value)
}

///|
/// Writes a `uint16_t` element at `index`.
pub fn Pointer::set_uint16(
  self : Pointer[CUInt16],
  index : Int64,
  value : UInt,
) -> Unit {
  self.offset(index).write_uint16(value)
}

///|
/// Writes an `int32_t` element at `index`.
pub fn Pointer::set_int32(
  self : Pointer[CInt32],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_int32(value)
}

///|
/// Writes a `uint32_t` element at `index`.
pub fn Pointer::set_uint32(
  self : Pointer[CUInt32],
  index : Int64,
  value : UInt,
) -> Unit {
  self.offset(index).write_uint32(value)
}

///|
/// Writes an `int64_t` element at `index`.
pub fn Pointer::set_int64(
  self : Pointer[CInt64],
  index : Int64,
  value : Int64,
) -> Unit {
  self.offset(index).write_int64(value)
}

///|
/// Writes a `uint64_t` element at `index`.
pub fn Pointer::set_uint64(
  self : Pointer[CUInt64],
  index : Int64,
  value : UInt64,
) -> Unit {
  self.offset(index).write_uint64(value)
}

///|
/// Writes a C `float` element at `index`.
pub fn Pointer::set_float(
  self : Pointer[CFloat],
  index : Int64,
  value : Float,
) -> Unit {
  self.offset(index).write_float(value)
}

///|
/// Writes a C `double` element at `index`.
pub fn Pointer::set_double(
  self : Pointer[CDouble],
  index : Int64,
  value : Double,
) -> Unit {
  self.offset(index).write_double(value)
}

///|
/// Writes a C `bool` element at `index`.
pub fn Pointer::set_bool(
  self : Pointer[CBool],
  index : Int64,
  value : Bool,
) -> Unit {
  self.offset(index).write_bool(value)
}

///|
/// Writes a C `char` element at `index`.
pub fn Pointer::set_char(
  self : Pointer[CChar],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_char(value)
}

///|
/// Writes a C `signed char` element at `index`.
pub fn Pointer::set_signed_char(
  self : Pointer[CSignedChar],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_signed_char(value)
}

///|
/// Writes a C `unsigned char` element at `index`.
pub fn Pointer::set_unsigned_char(
  self : Pointer[CUnsignedChar],
  index : Int64,
  value : Byte,
) -> Unit {
  self.offset(index).write_unsigned_char(value)
}

///|
/// Writes a C `short` element at `index`.
pub fn Pointer::set_short(
  self : Pointer[CShort],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_short(value)
}

///|
/// Writes a C `unsigned short` element at `index`.
pub fn Pointer::set_unsigned_short(
  self : Pointer[CUnsignedShort],
  index : Int64,
  value : UInt,
) -> Unit {
  self.offset(index).write_unsigned_short(value)
}

///|
/// Writes a C `int` element at `index`.
pub fn Pointer::set_int(
  self : Pointer[CInt],
  index : Int64,
  value : Int,
) -> Unit {
  self.offset(index).write_int(value)
}

///|
/// Writes a C `unsigned int` element at `index`.
pub fn Pointer::set_unsigned_int(
  self : Pointer[CUnsignedInt],
  index : Int64,
  value : UInt,
) -> Unit {
  self.offset(index).write_unsigned_int(value)
}

///|
/// Writes a C `long` element at `index`.
pub fn Pointer::set_long(
  self : Pointer[CLong],
  index : Int64,
  value : Int64,
) -> Unit {
  self.offset(index).write_long(value)
}

///|
/// Writes a C `unsigned long` element at `index`.
pub fn Pointer::set_unsigned_long(
  self : Pointer[CUnsignedLong],
  index : Int64,
  value : UInt64,
) -> Unit {
  self.offset(index).write_unsigned_long(value)
}

///|
/// Writes a C `long long` element at `index`.
pub fn Pointer::set_long_long(
  self : Pointer[CLongLong],
  index : Int64,
  value : Int64,
) -> Unit {
  self.offset(index).write_long_long(value)
}

///|
/// Writes a C `unsigned long long` element at `index`.
pub fn Pointer::set_unsigned_long_long(
  self : Pointer[CUnsignedLongLong],
  index : Int64,
  value : UInt64,
) -> Unit {
  self.offset(index).write_unsigned_long_long(value)
}

///|
/// Writes a C `size_t` element at `index`.
pub fn Pointer::set_size(
  self : Pointer[CSize],
  index : Int64,
  value : UInt64,
) -> Unit {
  self.offset(index).write_size(value)
}

///|
/// Writes a C `ptrdiff_t` element at `index`.
pub fn Pointer::set_ptrdiff(
  self : Pointer[CPtrDiff],
  index : Int64,
  value : Int64,
) -> Unit {
  self.offset(index).write_ptrdiff(value)
}
