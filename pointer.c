#include <moonbit.h>

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_bool(void) { return sizeof(bool); }
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_char(void) { return sizeof(char); }
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_short(void) { return sizeof(short); }
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_int(void) { return sizeof(int); }
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_long(void) { return sizeof(long); }
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_long_long(void) {
  return sizeof(long long);
}
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_size(void) { return sizeof(size_t); }
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_ptrdiff(void) {
  return sizeof(ptrdiff_t);
}
MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_pointer(void) { return sizeof(void *); }

MOONBIT_FFI_EXPORT int64_t c_mbt_alignof(int32_t type_id) {
  switch (type_id) {
  case 1: return _Alignof(int8_t);
  case 2: return _Alignof(uint8_t);
  case 3: return _Alignof(int16_t);
  case 4: return _Alignof(uint16_t);
  case 5: return _Alignof(int32_t);
  case 6: return _Alignof(uint32_t);
  case 7: return _Alignof(int64_t);
  case 8: return _Alignof(uint64_t);
  case 9: return _Alignof(float);
  case 10: return _Alignof(double);
  case 11: return _Alignof(bool);
  case 12: return _Alignof(char);
  case 13: return _Alignof(signed char);
  case 14: return _Alignof(unsigned char);
  case 15: return _Alignof(short);
  case 16: return _Alignof(unsigned short);
  case 17: return _Alignof(int);
  case 18: return _Alignof(unsigned int);
  case 19: return _Alignof(long);
  case 20: return _Alignof(unsigned long);
  case 21: return _Alignof(long long);
  case 22: return _Alignof(unsigned long long);
  case 23: return _Alignof(size_t);
  case 24: return _Alignof(ptrdiff_t);
  case 25: return _Alignof(void *);
  default: return 1;
  }
}

MOONBIT_FFI_EXPORT void *c_mbt_pointer_null(void) { return NULL; }

MOONBIT_FFI_EXPORT int32_t c_mbt_pointer_is_null(const void *pointer) {
  return pointer == NULL;
}

MOONBIT_FFI_EXPORT uint64_t c_mbt_pointer_address(const void *pointer) {
  return (uint64_t)(uintptr_t)pointer;
}

MOONBIT_FFI_EXPORT void *c_mbt_pointer_from_address(uint64_t address) {
  return (void *)(uintptr_t)address;
}

MOONBIT_FFI_EXPORT void *c_mbt_pointer_offset_bytes(void *pointer,
                                                    int64_t offset) {
  return (void *)((uint8_t *)pointer + offset);
}

MOONBIT_FFI_EXPORT void *c_mbt_pointer_add_bytes(void *pointer,
                                                 uint64_t count) {
  return (void *)((uint8_t *)pointer + count);
}

MOONBIT_FFI_EXPORT void *c_mbt_pointer_sub_bytes(void *pointer,
                                                 uint64_t count) {
  return (void *)((uint8_t *)pointer - count);
}

MOONBIT_FFI_EXPORT int32_t c_mbt_read_int8(const int8_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT uint8_t c_mbt_read_uint8(const uint8_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT int32_t c_mbt_read_int16(const int16_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT uint32_t c_mbt_read_uint16(const uint16_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT int32_t c_mbt_read_int32(const int32_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT uint32_t c_mbt_read_uint32(const uint32_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT int64_t c_mbt_read_int64(const int64_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT uint64_t c_mbt_read_uint64(const uint64_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT float c_mbt_read_float(const float *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT double c_mbt_read_double(const double *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT void c_mbt_write_int8(int8_t *pointer, int32_t value) {
  *pointer = (int8_t)value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_uint8(uint8_t *pointer, uint8_t value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_int16(int16_t *pointer, int32_t value) {
  *pointer = (int16_t)value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_uint16(uint16_t *pointer, uint32_t value) {
  *pointer = (uint16_t)value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_int32(int32_t *pointer, int32_t value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_uint32(uint32_t *pointer, uint32_t value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_int64(int64_t *pointer, int64_t value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_uint64(uint64_t *pointer, uint64_t value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_float(float *pointer, float value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_double(double *pointer, double value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void *c_mbt_read_pointer(void *const *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT void c_mbt_write_pointer(void **pointer, void *value) {
  *pointer = value;
}

MOONBIT_FFI_EXPORT void c_mbt_copy_non_overlapping(void *destination,
                                                   const void *source,
                                                   uint64_t byte_count) {
  memcpy(destination, source, (size_t)byte_count);
}

MOONBIT_FFI_EXPORT void c_mbt_move(void *destination, const void *source,
                                   uint64_t byte_count) {
  memmove(destination, source, (size_t)byte_count);
}

MOONBIT_FFI_EXPORT void c_mbt_fill(void *destination, uint8_t value,
                                   uint64_t byte_count) {
  memset(destination, value, (size_t)byte_count);
}

MOONBIT_FFI_EXPORT int32_t c_mbt_read_bool(const bool *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int32_t c_mbt_read_char(const char *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int32_t c_mbt_read_signed_char(const signed char *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint8_t
c_mbt_read_unsigned_char(const unsigned char *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int32_t c_mbt_read_short(const short *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint32_t
c_mbt_read_unsigned_short(const unsigned short *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int32_t c_mbt_read_int(const int *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint32_t
c_mbt_read_unsigned_int(const unsigned int *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int64_t c_mbt_read_long(const long *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint64_t
c_mbt_read_unsigned_long(const unsigned long *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int64_t c_mbt_read_long_long(const long long *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint64_t
c_mbt_read_unsigned_long_long(const unsigned long long *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint64_t c_mbt_read_size(const size_t *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT int64_t c_mbt_read_ptrdiff(const ptrdiff_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT void c_mbt_write_bool(bool *pointer, int32_t value) {
  *pointer = value != 0;
}
MOONBIT_FFI_EXPORT void c_mbt_write_char(char *pointer, int32_t value) {
  *pointer = (char)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_signed_char(signed char *pointer,
                                                int32_t value) {
  *pointer = (signed char)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_unsigned_char(unsigned char *pointer,
                                                  uint8_t value) {
  *pointer = value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_short(short *pointer, int32_t value) {
  *pointer = (short)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_unsigned_short(unsigned short *pointer,
                                                   uint32_t value) {
  *pointer = (unsigned short)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_int(int *pointer, int32_t value) {
  *pointer = value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_unsigned_int(unsigned int *pointer,
                                                 uint32_t value) {
  *pointer = value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_long(long *pointer, int64_t value) {
  *pointer = (long)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_unsigned_long(unsigned long *pointer,
                                                  uint64_t value) {
  *pointer = (unsigned long)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_long_long(long long *pointer,
                                              int64_t value) {
  *pointer = value;
}
MOONBIT_FFI_EXPORT void
c_mbt_write_unsigned_long_long(unsigned long long *pointer, uint64_t value) {
  *pointer = value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_size(size_t *pointer, uint64_t value) {
  *pointer = (size_t)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_ptrdiff(ptrdiff_t *pointer, int64_t value) {
  *pointer = (ptrdiff_t)value;
}

static int32_t c_mbt_test_int32_values[2];
static double c_mbt_test_double_value;
static void *c_mbt_test_pointer_value;
static _Alignas(max_align_t) unsigned char c_mbt_test_bytes[16];

MOONBIT_FFI_EXPORT int32_t *c_mbt_test_int32_pointer(void) {
  return c_mbt_test_int32_values;
}

MOONBIT_FFI_EXPORT double *c_mbt_test_double_pointer(void) {
  return &c_mbt_test_double_value;
}

MOONBIT_FFI_EXPORT void **c_mbt_test_pointer_pointer(void) {
  return &c_mbt_test_pointer_value;
}

MOONBIT_FFI_EXPORT unsigned char *c_mbt_test_bytes_pointer(void) {
  return c_mbt_test_bytes;
}
