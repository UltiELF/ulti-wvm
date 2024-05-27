// RUN: llvm-mc -arch=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX12 %s
// RUN: llvm-mc -arch=amdgcn -mcpu=gfx1200 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX12 %s

v_dot2_f32_f16 v0, v1, v2, v3 neg_lo:[0,0,0] neg_hi:[0,0,0] quad_perm:[2,2,3,1] bound_ctrl:0 fi:1
// GFX12: v_dot2_f32_f16_e64_dpp v0, v1, v2, v3 quad_perm:[2,2,3,1] row_mask:0xf bank_mask:0xf fi:1 ; encoding: [0x00,0x00,0x13,0xcc,0xfa,0x04,0x0e,0x04,0x01,0x7a,0x04,0xff]

v_dot2_f32_f16 v0, v1, v2, v3 neg_lo:[1,1,0] neg_hi:[1,0,1] quad_perm:[3,2,1,0] bank_mask:0xe
// GFX12: v_dot2_f32_f16_e64_dpp v0, v1, v2, v3 neg_lo:[1,1,0] neg_hi:[1,0,1] quad_perm:[3,2,1,0] row_mask:0xf bank_mask:0xe ; encoding: [0x00,0x05,0x13,0xcc,0xfa,0x04,0x0e,0x64,0x01,0x1b,0x00,0xfe]

v_fma_mix_f32 v0, v1, v2, v3 op_sel:[0,0,0] row_ror:7 bank_mask:0x1 bound_ctrl:0
// GFX12: v_fma_mix_f32_e64_dpp v0, v1, v2, v3 row_ror:7 row_mask:0xf bank_mask:0x1 ; encoding: [0x00,0x00,0x20,0xcc,0xfa,0x04,0x0e,0x04,0x01,0x27,0x01,0xf1]

v_fma_mixhi_f16 v0, v1, v2, v3 op_sel_hi:[1,1,1] clamp quad_perm:[0,2,3,1] row_mask:0x0
// GFX12: v_fma_mixhi_f16_e64_dpp v0, v1, v2, v3 op_sel_hi:[1,1,1] clamp quad_perm:[0,2,3,1] row_mask:0x0 bank_mask:0xf ; encoding: [0x00,0xc0,0x22,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x78,0x00,0x0f]

v_dot4_f32_fp8_bf8 v0, v1, v2, v3 quad_perm:[3,2,1,0]
// GFX12: v_dot4_f32_fp8_bf8_e64_dpp v0, v1, v2, v3 quad_perm:[3,2,1,0] row_mask:0xf bank_mask:0xf ; encoding: [0x00,0x40,0x24,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x1b,0x00,0xff]

v_dot4_f32_fp8_bf8 v0, v1, v2, v3 row_shr:15 row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1
// GFX12: v_dot4_f32_fp8_bf8_e64_dpp v0, v1, v2, v3 row_shr:15 row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1 ; encoding: [0x00,0x40,0x24,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x1f,0x0d,0x11]

v_dot4_f32_bf8_fp8 v0, v1, v2, v3 row_shl:15
// GFX12: v_dot4_f32_bf8_fp8_e64_dpp v0, v1, v2, v3 row_shl:15 row_mask:0xf bank_mask:0xf ; encoding: [0x00,0x40,0x25,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x0f,0x01,0xff]

v_dot4_f32_bf8_fp8 v0, v1, v2, v3 row_ror:15 row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1
// GFX12: v_dot4_f32_bf8_fp8_e64_dpp v0, v1, v2, v3 row_ror:15 row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1 ; encoding: [0x00,0x40,0x25,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x2f,0x0d,0x11]

v_dot4_f32_fp8_fp8 v0, v1, v2, v3 row_mirror
// GFX12: v_dot4_f32_fp8_fp8_e64_dpp v0, v1, v2, v3 row_mirror row_mask:0xf bank_mask:0xf ; encoding: [0x00,0x40,0x26,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x40,0x01,0xff]

v_dot4_f32_fp8_fp8 v0, v1, v2, v3 row_half_mirror row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1
// GFX12: v_dot4_f32_fp8_fp8_e64_dpp v0, v1, v2, v3 row_half_mirror row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1 ; encoding: [0x00,0x40,0x26,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x41,0x0d,0x11]

v_dot4_f32_bf8_bf8 v0, v1, v2, v3 row_share:15
// GFX12: v_dot4_f32_bf8_bf8_e64_dpp v0, v1, v2, v3 row_share:15 row_mask:0xf bank_mask:0xf ; encoding: [0x00,0x40,0x27,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x5f,0x01,0xff]

v_dot4_f32_bf8_bf8 v0, v1, v2, v3 row_xmask:15 row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1
// GFX12: v_dot4_f32_bf8_bf8_e64_dpp v0, v1, v2, v3 row_xmask:15 row_mask:0x1 bank_mask:0x1 bound_ctrl:1 fi:1 ; encoding: [0x00,0x40,0x27,0xcc,0xfa,0x04,0x0e,0x1c,0x01,0x6f,0x0d,0x11]
