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
extern "c" fn read_short_raw(pointer : ReadOnlyPointer[CShort]) -> Int16 = "c_mbt_read_short"

///|
#borrow(pointer)
extern "c" fn read_unsigned_short_raw(
  pointer : ReadOnlyPointer[CUnsignedShort],
) -> UInt16 = "c_mbt_read_unsigned_short"

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
pub fn ReadOnlyPointer::read_short(self : ReadOnlyPointer[CShort]) -> Int16 {
  read_short_raw(self)
}

///|
pub fn ReadOnlyPointer::read_unsigned_short(
  self : ReadOnlyPointer[CUnsignedShort],
) -> UInt16 {
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
extern "c" fn write_short_raw(pointer : Pointer[CShort], value : Int16) -> Unit = "c_mbt_write_short"

///|
#borrow(pointer)
extern "c" fn write_unsigned_short_raw(
  pointer : Pointer[CUnsignedShort],
  value : UInt16,
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
pub fn Pointer::write_short(self : Pointer[CShort], value : Int16) -> Unit {
  write_short_raw(self, value)
}

///|
pub fn Pointer::write_unsigned_short(
  self : Pointer[CUnsignedShort],
  value : UInt16,
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
