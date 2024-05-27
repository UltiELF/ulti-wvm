// RUN: llvm-mc -arch=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX12 %s
// RUN: llvm-mc -arch=amdgcn -mcpu=gfx1200 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX12 %s

v_cmpx_class_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xfd,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_class_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xfd,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_class_f16_e64_dpp -|v255|, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x01,0xfd,0xd4,0xe9,0xfe,0x03,0x20,0xff,0x00,0x00,0x00]

v_cmpx_class_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xfe,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_class_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xfe,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_class_f32_e64_dpp -|v255|, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x01,0xfe,0xd4,0xe9,0xfe,0x03,0x20,0xff,0x00,0x00,0x00]

v_cmpx_eq_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x82,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x82,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_eq_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x82,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_eq_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x82,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_eq_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x92,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x92,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_eq_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x92,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_eq_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x92,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_eq_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb2,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb2,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb2,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_eq_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc2,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc2,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc2,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_eq_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xba,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xba,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xba,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_eq_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xca,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xca,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_eq_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xca,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ge_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x86,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x86,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_ge_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x86,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_ge_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x86,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_ge_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x96,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x96,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_ge_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x96,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_ge_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x96,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_ge_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb6,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb6,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb6,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ge_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc6,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc6,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc6,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ge_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xbe,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xbe,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xbe,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ge_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xce,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xce,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ge_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xce,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_gt_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x84,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x84,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_gt_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x84,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_gt_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x84,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_gt_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x94,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x94,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_gt_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x94,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_gt_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x94,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_gt_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb4,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb4,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb4,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_gt_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc4,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc4,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc4,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_gt_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xbc,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xbc,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xbc,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_gt_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xcc,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xcc,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_gt_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xcc,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_le_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x83,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x83,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_le_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x83,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_le_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x83,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_le_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x93,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x93,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_le_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x93,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_le_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x93,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_le_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb3,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb3,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb3,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_le_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc3,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc3,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc3,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_le_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xbb,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xbb,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xbb,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_le_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xcb,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xcb,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_le_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xcb,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_lg_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x85,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lg_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x85,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_lg_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x85,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_lg_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x85,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_lg_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x95,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lg_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x95,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_lg_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x95,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_lg_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x95,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_lt_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x81,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x81,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_lt_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x81,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_lt_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x81,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_lt_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x91,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x91,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_lt_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x91,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_lt_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x91,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_lt_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb1,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb1,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb1,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_lt_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc1,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc1,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc1,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_lt_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb9,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb9,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb9,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_lt_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc9,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc9,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_lt_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc9,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ne_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xb5,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_i16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xb5,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xb5,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ne_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xc5,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_i32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xc5,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xc5,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ne_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xbd,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_u16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xbd,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xbd,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_ne_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0xcd,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_u32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x00,0xcd,0xd4,0xea,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ne_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x00,0xcd,0xd4,0xe9,0xfe,0x03,0x00,0xff,0x00,0x00,0x00]

v_cmpx_neq_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x8d,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_neq_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x8d,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_neq_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x8d,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_neq_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x8d,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_neq_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x9d,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_neq_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x9d,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_neq_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x9d,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_neq_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x9d,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nge_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x89,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nge_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x89,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nge_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x89,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nge_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x89,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nge_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x99,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nge_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x99,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nge_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x99,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nge_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x99,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_ngt_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x8b,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ngt_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x8b,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_ngt_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x8b,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_ngt_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x8b,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_ngt_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x9b,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_ngt_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x9b,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_ngt_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x9b,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_ngt_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x9b,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nle_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x8c,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nle_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x8c,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nle_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x8c,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nle_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x8c,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nle_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x9c,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nle_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x9c,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nle_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x9c,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nle_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x9c,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nlg_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x8a,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nlg_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x8a,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nlg_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x8a,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nlg_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x8a,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nlg_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x9a,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nlg_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x9a,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nlg_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x9a,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nlg_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x9a,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nlt_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x8e,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nlt_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x8e,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nlt_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x8e,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nlt_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x8e,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_nlt_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x9e,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_nlt_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x9e,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_nlt_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x9e,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_nlt_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x9e,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_o_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x87,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_o_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x87,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_o_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x87,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_o_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x87,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_o_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x97,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_o_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x97,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_o_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x97,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_o_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x97,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_u_f16_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x88,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_u_f16_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x88,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_u_f16_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x88,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_u_f16_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x88,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]

v_cmpx_u_f32_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x00,0x98,0xd4,0xe9,0x04,0x02,0x00,0x01,0x77,0x39,0x05]

v_cmpx_u_f32_e64_dpp |v1|, -v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x7e,0x01,0x98,0xd4,0xe9,0x04,0x02,0x40,0x01,0x77,0x39,0x05]

v_cmpx_u_f32_e64_dpp -v1, |v2| dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x7e,0x02,0x98,0xd4,0xea,0x04,0x02,0x20,0x01,0x77,0x39,0x05]

v_cmpx_u_f32_e64_dpp -|v255|, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0x7e,0x83,0x98,0xd4,0xe9,0xfe,0x03,0x60,0xff,0x00,0x00,0x00]
