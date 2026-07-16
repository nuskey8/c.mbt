///|
/// Conversion from a C-compatible function reference to a void pointer.
pub(open) trait FuncRefAsVoidPointer {
  /// Reinterprets this function reference as a void pointer.
  ///
  /// This operation assumes the native ABI represents function pointers and
  /// data pointers identically. ISO C does not guarantee that conversion to
  /// `void*` is portable to every architecture.
  fn as_void_pointer(Self) -> Pointer[CVoid]
}

///|
pub impl[F] FuncRefAsVoidPointer for FuncRef[F] with fn as_void_pointer(self) = "%identity"

///|
/// Unsafe conversions from native void pointers to function references.
pub type FuncRefPointer

///|
/// Reinterprets a native void pointer as a callable function reference.
///
/// The pointer must be non-null, point to a function with exactly signature
/// `F`, and use an ABI where data and function pointers are interchangeable.
pub fn[F] FuncRefPointer::unsafe_from_void_pointer(
  pointer : Pointer[CVoid],
) -> FuncRef[F] = "%identity"

///|
/// Operations on fixed arrays of C-compatible function references.
pub type FuncRefArray

///|
/// Borrows the contiguous storage of a function-reference array.
pub fn[F] FuncRefArray::as_pointer(
  value : FixedArray[FuncRef[F]],
) -> Pointer[FuncRef[F]] = "%identity"

///|
pub impl[F] SizeOf for FuncRef[F] with fn size_of() {
  sizeof_pointer_raw()
}

///|
pub impl[F] AlignOf for FuncRef[F] with fn align_of() {
  alignof_raw(25)
}
