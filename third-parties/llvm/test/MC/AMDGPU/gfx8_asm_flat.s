// RUN: llvm-mc -triple=amdgcn -mcpu=tonga -show-encoding %s | FileCheck %s

flat_load_ubyte v5, v[1:2]
// CHECK: [0x00,0x00,0x40,0xdc,0x01,0x00,0x00,0x05]

flat_load_ubyte v255, v[1:2]
// CHECK: [0x00,0x00,0x40,0xdc,0x01,0x00,0x00,0xff]

flat_load_ubyte v5, v[254:255]
// CHECK: [0x00,0x00,0x40,0xdc,0xfe,0x00,0x00,0x05]

flat_load_ubyte v5, v[1:2] glc
// CHECK: [0x00,0x00,0x41,0xdc,0x01,0x00,0x00,0x05]

flat_load_ubyte v5, v[1:2] slc
// CHECK: [0x00,0x00,0x42,0xdc,0x01,0x00,0x00,0x05]

flat_load_sbyte v5, v[1:2]
// CHECK: [0x00,0x00,0x44,0xdc,0x01,0x00,0x00,0x05]

flat_load_sbyte v255, v[1:2]
// CHECK: [0x00,0x00,0x44,0xdc,0x01,0x00,0x00,0xff]

flat_load_sbyte v5, v[254:255]
// CHECK: [0x00,0x00,0x44,0xdc,0xfe,0x00,0x00,0x05]

flat_load_sbyte v5, v[1:2] glc
// CHECK: [0x00,0x00,0x45,0xdc,0x01,0x00,0x00,0x05]

flat_load_sbyte v5, v[1:2] slc
// CHECK: [0x00,0x00,0x46,0xdc,0x01,0x00,0x00,0x05]

flat_load_ushort v5, v[1:2]
// CHECK: [0x00,0x00,0x48,0xdc,0x01,0x00,0x00,0x05]

flat_load_ushort v255, v[1:2]
// CHECK: [0x00,0x00,0x48,0xdc,0x01,0x00,0x00,0xff]

flat_load_ushort v5, v[254:255]
// CHECK: [0x00,0x00,0x48,0xdc,0xfe,0x00,0x00,0x05]

flat_load_ushort v5, v[1:2] glc
// CHECK: [0x00,0x00,0x49,0xdc,0x01,0x00,0x00,0x05]

flat_load_ushort v5, v[1:2] slc
// CHECK: [0x00,0x00,0x4a,0xdc,0x01,0x00,0x00,0x05]

flat_load_sshort v5, v[1:2]
// CHECK: [0x00,0x00,0x4c,0xdc,0x01,0x00,0x00,0x05]

flat_load_sshort v255, v[1:2]
// CHECK: [0x00,0x00,0x4c,0xdc,0x01,0x00,0x00,0xff]

flat_load_sshort v5, v[254:255]
// CHECK: [0x00,0x00,0x4c,0xdc,0xfe,0x00,0x00,0x05]

flat_load_sshort v5, v[1:2] glc
// CHECK: [0x00,0x00,0x4d,0xdc,0x01,0x00,0x00,0x05]

flat_load_sshort v5, v[1:2] slc
// CHECK: [0x00,0x00,0x4e,0xdc,0x01,0x00,0x00,0x05]

flat_load_dword v5, v[1:2]
// CHECK: [0x00,0x00,0x50,0xdc,0x01,0x00,0x00,0x05]

flat_load_dword v255, v[1:2]
// CHECK: [0x00,0x00,0x50,0xdc,0x01,0x00,0x00,0xff]

flat_load_dword v5, v[254:255]
// CHECK: [0x00,0x00,0x50,0xdc,0xfe,0x00,0x00,0x05]

flat_load_dword v5, v[1:2] glc
// CHECK: [0x00,0x00,0x51,0xdc,0x01,0x00,0x00,0x05]

flat_load_dword v5, v[1:2] slc
// CHECK: [0x00,0x00,0x52,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx2 v[5:6], v[1:2]
// CHECK: [0x00,0x00,0x54,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx2 v[254:255], v[1:2]
// CHECK: [0x00,0x00,0x54,0xdc,0x01,0x00,0x00,0xfe]

flat_load_dwordx2 v[5:6], v[254:255]
// CHECK: [0x00,0x00,0x54,0xdc,0xfe,0x00,0x00,0x05]

flat_load_dwordx2 v[5:6], v[1:2] glc
// CHECK: [0x00,0x00,0x55,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx2 v[5:6], v[1:2] slc
// CHECK: [0x00,0x00,0x56,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx3 v[5:7], v[1:2]
// CHECK: [0x00,0x00,0x58,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx3 v[253:255], v[1:2]
// CHECK: [0x00,0x00,0x58,0xdc,0x01,0x00,0x00,0xfd]

flat_load_dwordx3 v[5:7], v[254:255]
// CHECK: [0x00,0x00,0x58,0xdc,0xfe,0x00,0x00,0x05]

flat_load_dwordx3 v[5:7], v[1:2] glc
// CHECK: [0x00,0x00,0x59,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx3 v[5:7], v[1:2] slc
// CHECK: [0x00,0x00,0x5a,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx4 v[5:8], v[1:2]
// CHECK: [0x00,0x00,0x5c,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx4 v[252:255], v[1:2]
// CHECK: [0x00,0x00,0x5c,0xdc,0x01,0x00,0x00,0xfc]

flat_load_dwordx4 v[5:8], v[254:255]
// CHECK: [0x00,0x00,0x5c,0xdc,0xfe,0x00,0x00,0x05]

flat_load_dwordx4 v[5:8], v[1:2] glc
// CHECK: [0x00,0x00,0x5d,0xdc,0x01,0x00,0x00,0x05]

flat_load_dwordx4 v[5:8], v[1:2] slc
// CHECK: [0x00,0x00,0x5e,0xdc,0x01,0x00,0x00,0x05]

flat_store_byte v[1:2], v2
// CHECK: [0x00,0x00,0x60,0xdc,0x01,0x02,0x00,0x00]

flat_store_byte v[254:255], v2
// CHECK: [0x00,0x00,0x60,0xdc,0xfe,0x02,0x00,0x00]

flat_store_byte v[1:2], v255
// CHECK: [0x00,0x00,0x60,0xdc,0x01,0xff,0x00,0x00]

flat_store_byte v[1:2], v2 glc
// CHECK: [0x00,0x00,0x61,0xdc,0x01,0x02,0x00,0x00]

flat_store_byte v[1:2], v2 slc
// CHECK: [0x00,0x00,0x62,0xdc,0x01,0x02,0x00,0x00]

flat_store_short v[1:2], v2
// CHECK: [0x00,0x00,0x68,0xdc,0x01,0x02,0x00,0x00]

flat_store_short v[254:255], v2
// CHECK: [0x00,0x00,0x68,0xdc,0xfe,0x02,0x00,0x00]

flat_store_short v[1:2], v255
// CHECK: [0x00,0x00,0x68,0xdc,0x01,0xff,0x00,0x00]

flat_store_short v[1:2], v2 glc
// CHECK: [0x00,0x00,0x69,0xdc,0x01,0x02,0x00,0x00]

flat_store_short v[1:2], v2 slc
// CHECK: [0x00,0x00,0x6a,0xdc,0x01,0x02,0x00,0x00]

flat_store_dword v[1:2], v2
// CHECK: [0x00,0x00,0x70,0xdc,0x01,0x02,0x00,0x00]

flat_store_dword v[254:255], v2
// CHECK: [0x00,0x00,0x70,0xdc,0xfe,0x02,0x00,0x00]

flat_store_dword v[1:2], v255
// CHECK: [0x00,0x00,0x70,0xdc,0x01,0xff,0x00,0x00]

flat_store_dword v[1:2], v2 glc
// CHECK: [0x00,0x00,0x71,0xdc,0x01,0x02,0x00,0x00]

flat_store_dword v[1:2], v2 slc
// CHECK: [0x00,0x00,0x72,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x74,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x74,0xdc,0xfe,0x02,0x00,0x00]

flat_store_dwordx2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x74,0xdc,0x01,0xfe,0x00,0x00]

flat_store_dwordx2 v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x75,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x76,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx3 v[1:2], v[2:4]
// CHECK: [0x00,0x00,0x78,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx3 v[254:255], v[2:4]
// CHECK: [0x00,0x00,0x78,0xdc,0xfe,0x02,0x00,0x00]

flat_store_dwordx3 v[1:2], v[253:255]
// CHECK: [0x00,0x00,0x78,0xdc,0x01,0xfd,0x00,0x00]

flat_store_dwordx3 v[1:2], v[2:4] glc
// CHECK: [0x00,0x00,0x79,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx3 v[1:2], v[2:4] slc
// CHECK: [0x00,0x00,0x7a,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx4 v[1:2], v[2:5]
// CHECK: [0x00,0x00,0x7c,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx4 v[254:255], v[2:5]
// CHECK: [0x00,0x00,0x7c,0xdc,0xfe,0x02,0x00,0x00]

flat_store_dwordx4 v[1:2], v[252:255]
// CHECK: [0x00,0x00,0x7c,0xdc,0x01,0xfc,0x00,0x00]

flat_store_dwordx4 v[1:2], v[2:5] glc
// CHECK: [0x00,0x00,0x7d,0xdc,0x01,0x02,0x00,0x00]

flat_store_dwordx4 v[1:2], v[2:5] slc
// CHECK: [0x00,0x00,0x7e,0xdc,0x01,0x02,0x00,0x00]

flat_atomic_swap v[1:2], v2
// CHECK: [0x00,0x00,0x00,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_swap v[254:255], v2
// CHECK: [0x00,0x00,0x00,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_swap v[1:2], v255
// CHECK: [0x00,0x00,0x00,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_swap v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x01,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_swap v[1:2], v2 slc
// CHECK: [0x00,0x00,0x02,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_cmpswap v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x04,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_cmpswap v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x04,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_cmpswap v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x04,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_cmpswap v0, v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x05,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_cmpswap v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x06,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_add v[1:2], v2
// CHECK: [0x00,0x00,0x08,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_add v[254:255], v2
// CHECK: [0x00,0x00,0x08,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_add v[1:2], v255
// CHECK: [0x00,0x00,0x08,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_add v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x09,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_add v[1:2], v2 slc
// CHECK: [0x00,0x00,0x0a,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_sub v[1:2], v2
// CHECK: [0x00,0x00,0x0c,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_sub v[254:255], v2
// CHECK: [0x00,0x00,0x0c,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_sub v[1:2], v255
// CHECK: [0x00,0x00,0x0c,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_sub v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x0d,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_sub v[1:2], v2 slc
// CHECK: [0x00,0x00,0x0e,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smin v[1:2], v2
// CHECK: [0x00,0x00,0x10,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smin v[254:255], v2
// CHECK: [0x00,0x00,0x10,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_smin v[1:2], v255
// CHECK: [0x00,0x00,0x10,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_smin v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x11,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smin v[1:2], v2 slc
// CHECK: [0x00,0x00,0x12,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umin v[1:2], v2
// CHECK: [0x00,0x00,0x14,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umin v[254:255], v2
// CHECK: [0x00,0x00,0x14,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_umin v[1:2], v255
// CHECK: [0x00,0x00,0x14,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_umin v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x15,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umin v[1:2], v2 slc
// CHECK: [0x00,0x00,0x16,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smax v[1:2], v2
// CHECK: [0x00,0x00,0x18,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smax v[254:255], v2
// CHECK: [0x00,0x00,0x18,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_smax v[1:2], v255
// CHECK: [0x00,0x00,0x18,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_smax v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x19,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smax v[1:2], v2 slc
// CHECK: [0x00,0x00,0x1a,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umax v[1:2], v2
// CHECK: [0x00,0x00,0x1c,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umax v[254:255], v2
// CHECK: [0x00,0x00,0x1c,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_umax v[1:2], v255
// CHECK: [0x00,0x00,0x1c,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_umax v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x1d,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umax v[1:2], v2 slc
// CHECK: [0x00,0x00,0x1e,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_and v[1:2], v2
// CHECK: [0x00,0x00,0x20,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_and v[254:255], v2
// CHECK: [0x00,0x00,0x20,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_and v[1:2], v255
// CHECK: [0x00,0x00,0x20,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_and v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x21,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_and v[1:2], v2 slc
// CHECK: [0x00,0x00,0x22,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_or v[1:2], v2
// CHECK: [0x00,0x00,0x24,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_or v[254:255], v2
// CHECK: [0x00,0x00,0x24,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_or v[1:2], v255
// CHECK: [0x00,0x00,0x24,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_or v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x25,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_or v[1:2], v2 slc
// CHECK: [0x00,0x00,0x26,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_xor v[1:2], v2
// CHECK: [0x00,0x00,0x28,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_xor v[254:255], v2
// CHECK: [0x00,0x00,0x28,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_xor v[1:2], v255
// CHECK: [0x00,0x00,0x28,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_xor v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x29,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_xor v[1:2], v2 slc
// CHECK: [0x00,0x00,0x2a,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_inc v[1:2], v2
// CHECK: [0x00,0x00,0x2c,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_inc v[254:255], v2
// CHECK: [0x00,0x00,0x2c,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_inc v[1:2], v255
// CHECK: [0x00,0x00,0x2c,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_inc v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x2d,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_inc v[1:2], v2 slc
// CHECK: [0x00,0x00,0x2e,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_dec v[1:2], v2
// CHECK: [0x00,0x00,0x30,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_dec v[254:255], v2
// CHECK: [0x00,0x00,0x30,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_dec v[1:2], v255
// CHECK: [0x00,0x00,0x30,0xdd,0x01,0xff,0x00,0x00]

flat_atomic_dec v0, v[1:2], v2 glc
// CHECK: [0x00,0x00,0x31,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_dec v[1:2], v2 slc
// CHECK: [0x00,0x00,0x32,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_swap_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x80,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_swap_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x80,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_swap_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x80,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_swap_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x81,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_swap_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x82,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_cmpswap_x2 v[1:2], v[2:5]
// CHECK: [0x00,0x00,0x84,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_cmpswap_x2 v[254:255], v[2:5]
// CHECK: [0x00,0x00,0x84,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_cmpswap_x2 v[1:2], v[252:255]
// CHECK: [0x00,0x00,0x84,0xdd,0x01,0xfc,0x00,0x00]

flat_atomic_cmpswap_x2 v[0:1], v[1:2], v[2:5] glc
// CHECK: [0x00,0x00,0x85,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_cmpswap_x2 v[1:2], v[2:5] slc
// CHECK: [0x00,0x00,0x86,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_add_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x88,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_add_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x88,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_add_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x88,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_add_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x89,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_add_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x8a,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_sub_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x8c,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_sub_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x8c,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_sub_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x8c,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_sub_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x8d,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_sub_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x8e,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smin_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x90,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smin_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x90,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_smin_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x90,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_smin_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x91,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smin_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x92,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umin_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x94,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umin_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x94,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_umin_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x94,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_umin_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x95,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umin_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x96,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smax_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x98,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smax_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x98,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_smax_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x98,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_smax_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x99,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_smax_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x9a,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umax_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0x9c,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umax_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0x9c,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_umax_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0x9c,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_umax_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0x9d,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_umax_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0x9e,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_and_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0xa0,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_and_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0xa0,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_and_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0xa0,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_and_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0xa1,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_and_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0xa2,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_or_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0xa4,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_or_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0xa4,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_or_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0xa4,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_or_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0xa5,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_or_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0xa6,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_xor_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0xa8,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_xor_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0xa8,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_xor_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0xa8,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_xor_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0xa9,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_xor_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0xaa,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_inc_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0xac,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_inc_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0xac,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_inc_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0xac,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_inc_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0xad,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_inc_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0xae,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_dec_x2 v[1:2], v[2:3]
// CHECK: [0x00,0x00,0xb0,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_dec_x2 v[254:255], v[2:3]
// CHECK: [0x00,0x00,0xb0,0xdd,0xfe,0x02,0x00,0x00]

flat_atomic_dec_x2 v[1:2], v[254:255]
// CHECK: [0x00,0x00,0xb0,0xdd,0x01,0xfe,0x00,0x00]

flat_atomic_dec_x2 v[0:1], v[1:2], v[2:3] glc
// CHECK: [0x00,0x00,0xb1,0xdd,0x01,0x02,0x00,0x00]

flat_atomic_dec_x2 v[1:2], v[2:3] slc
// CHECK: [0x00,0x00,0xb2,0xdd,0x01,0x02,0x00,0x00]
