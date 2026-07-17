#include <moonbit.h>

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

MOONBIT_FFI_EXPORT uint8_t c_mbt_test_cuint8_value(void) { return 0xff; }
MOONBIT_FFI_EXPORT int32_t c_mbt_test_cint32_value(void) { return 123; }

MOONBIT_FFI_EXPORT const uint8_t *
c_mbt_bytes_as_pointer(moonbit_bytes_t bytes) {
  return bytes;
}

#define C_MBT_DEFINE_ARRAY_POINTER(name, type)                               \
  MOONBIT_FFI_EXPORT void *name(type *array) { return (void *)array; }

C_MBT_DEFINE_ARRAY_POINTER(c_mbt_int_array_as_pointer, int32_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_uint_array_as_pointer, uint32_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_byte_array_as_pointer, uint8_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_int16_array_as_pointer, int16_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_uint16_array_as_pointer, uint16_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_pointer_array_as_pointer, void *)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_readonly_pointer_array_as_pointer, void *)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_int64_array_as_pointer, int64_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_uint64_array_as_pointer, uint64_t)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_float_array_as_pointer, float)
C_MBT_DEFINE_ARRAY_POINTER(c_mbt_double_array_as_pointer, double)

#undef C_MBT_DEFINE_ARRAY_POINTER

typedef int32_t (*c_mbt_test_function_pointer)(int32_t);

MOONBIT_FFI_EXPORT uint32_t
c_mbt_test_byte_array_round_trip(uint8_t *values, int32_t length) {
  uint32_t sum = 0;
  for (int32_t i = 0; i < length; ++i) {
    sum += values[i];
  }
  if (length >= 3) {
    values[0] = 0;
    values[1] = 127;
    values[length - 1] = 255;
  }
  return sum;
}

MOONBIT_FFI_EXPORT uint32_t
c_mbt_test_byte_array_bulk_transform(void *destination, const void *source,
                                     int32_t length) {
  uint8_t *destination_bytes = destination;
  const uint8_t *source_bytes = source;
  uint32_t sum = 0;
  for (int32_t i = 0; i < length; ++i) {
    sum += source_bytes[i];
    destination_bytes[i] = (uint8_t)(source_bytes[i] + (uint8_t)i);
  }
  return sum;
}

MOONBIT_FFI_EXPORT void *c_mbt_test_function_pointer_as_void_pointer(
    c_mbt_test_function_pointer function) {
  return (void *)function;
}

MOONBIT_FFI_EXPORT int32_t c_mbt_test_call_function_pointer_array(
    c_mbt_test_function_pointer *functions, int32_t index, int32_t value) {
  return functions[index](value);
}

MOONBIT_FFI_EXPORT int64_t c_mbt_sizeof_pointer(void) { return sizeof(void *); }

MOONBIT_FFI_EXPORT int64_t c_mbt_alignof(int32_t type_id) {
  switch (type_id) {
  case 1: return _Alignof(int8_t);
  case 3: return _Alignof(int16_t);
  case 4: return _Alignof(uint16_t);
  case 5: return _Alignof(int32_t);
  case 6: return _Alignof(uint32_t);
  case 7: return _Alignof(int64_t);
  case 8: return _Alignof(uint64_t);
  case 9: return _Alignof(float);
  case 10: return _Alignof(double);
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

MOONBIT_FFI_EXPORT int16_t c_mbt_read_int16(const int16_t *pointer) {
  return *pointer;
}

MOONBIT_FFI_EXPORT uint16_t c_mbt_read_uint16(const uint16_t *pointer) {
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

MOONBIT_FFI_EXPORT void c_mbt_write_int16(int16_t *pointer, int16_t value) {
  *pointer = (int16_t)value;
}

MOONBIT_FFI_EXPORT void c_mbt_write_uint16(uint16_t *pointer, uint16_t value) {
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
MOONBIT_FFI_EXPORT int16_t c_mbt_read_short(const short *pointer) {
  return *pointer;
}
MOONBIT_FFI_EXPORT uint16_t
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
MOONBIT_FFI_EXPORT int64_t c_mbt_read_intptr(const intptr_t *pointer) {
  return (int64_t)*pointer;
}
MOONBIT_FFI_EXPORT uint64_t c_mbt_read_uintptr(const uintptr_t *pointer) {
  return (uint64_t)*pointer;
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
MOONBIT_FFI_EXPORT void c_mbt_write_short(short *pointer, int16_t value) {
  *pointer = (short)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_unsigned_short(unsigned short *pointer,
                                                    uint16_t value) {
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
MOONBIT_FFI_EXPORT void c_mbt_write_intptr(intptr_t *pointer, int64_t value) {
  *pointer = (intptr_t)value;
}
MOONBIT_FFI_EXPORT void c_mbt_write_uintptr(uintptr_t *pointer,
                                            uint64_t value) {
  *pointer = (uintptr_t)value;
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
