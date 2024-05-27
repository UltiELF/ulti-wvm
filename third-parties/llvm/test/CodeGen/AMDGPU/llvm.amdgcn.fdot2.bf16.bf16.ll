; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=GFX11,SDAG-GFX11
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=GFX11,GISEL-GFX11

declare i16 @llvm.amdgcn.fdot2.bf16.bf16(<2 x i16> %a, <2 x i16> %b, i16 %c)

define amdgpu_kernel void @test_llvm_amdgcn_fdot2_bf16_bf16(
; GFX11-LABEL: test_llvm_amdgcn_fdot2_bf16_bf16:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_u16 v1, v0, s[6:7]
; GFX11-NEXT:    s_load_b32 s2, s[2:3], 0x0
; GFX11-NEXT:    s_load_b32 s3, s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_dot2_bf16_bf16 v1, s2, s3, v1
; GFX11-NEXT:    global_store_b16 v0, v1, s[0:1]
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
    ptr addrspace(1) %r,
    ptr addrspace(1) %a,
    ptr addrspace(1) %b,
    ptr addrspace(1) %c) {
entry:
  %a.val = load <2 x i16>, ptr addrspace(1) %a
  %b.val = load <2 x i16>, ptr addrspace(1) %b
  %c.val = load i16, ptr addrspace(1) %c
  %r.val = call i16 @llvm.amdgcn.fdot2.bf16.bf16(<2 x i16> %a.val, <2 x i16> %b.val, i16 %c.val)
  store i16 %r.val, ptr addrspace(1) %r
  ret void
}

define amdgpu_kernel void @test_llvm_amdgcn_fdot2_bf16_bf16_dpp(
; SDAG-GFX11-LABEL: test_llvm_amdgcn_fdot2_bf16_bf16_dpp:
; SDAG-GFX11:       ; %bb.0: ; %entry
; SDAG-GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; SDAG-GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; SDAG-GFX11-NEXT:    scratch_load_b32 v0, off, s2
; SDAG-GFX11-NEXT:    scratch_load_u16 v1, off, s3
; SDAG-GFX11-NEXT:    scratch_load_b32 v2, off, s1
; SDAG-GFX11-NEXT:    s_waitcnt vmcnt(0)
; SDAG-GFX11-NEXT:    v_dot2_bf16_bf16_e64_dpp v0, v2, v0, v1 quad_perm:[1,0,0,0] row_mask:0xf bank_mask:0xf bound_ctrl:1
; SDAG-GFX11-NEXT:    scratch_store_b16 off, v0, s0
; SDAG-GFX11-NEXT:    s_endpgm
;
; GISEL-GFX11-LABEL: test_llvm_amdgcn_fdot2_bf16_bf16_dpp:
; GISEL-GFX11:       ; %bb.0: ; %entry
; GISEL-GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GISEL-GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-GFX11-NEXT:    scratch_load_b32 v0, off, s1
; GISEL-GFX11-NEXT:    scratch_load_b32 v1, off, s2
; GISEL-GFX11-NEXT:    scratch_load_u16 v2, off, s3
; GISEL-GFX11-NEXT:    s_waitcnt vmcnt(0)
; GISEL-GFX11-NEXT:    v_dot2_bf16_bf16_e64_dpp v0, v0, v1, v2 quad_perm:[1,0,0,0] row_mask:0xf bank_mask:0xf bound_ctrl:1
; GISEL-GFX11-NEXT:    scratch_store_b16 off, v0, s0
; GISEL-GFX11-NEXT:    s_endpgm
    ptr addrspace(5) %r,
    ptr addrspace(5) %a,
    ptr addrspace(5) %b,
    ptr addrspace(5) %c) {
entry:
  %a.val = load <2 x i16>, ptr addrspace(5) %a
  %b.val = load <2 x i16>, ptr addrspace(5) %b
  %c.val = load i16, ptr addrspace(5) %c
  %a.val.i32 = bitcast <2 x i16> %a.val to i32
  %dpp = call i32 @llvm.amdgcn.update.dpp.i32(i32 %a.val.i32, i32 %a.val.i32, i32 1, i32 15, i32 15, i1 1)
  %a.val.dpp.v2i16 = bitcast i32 %dpp to <2 x i16>
  %r.val = call i16 @llvm.amdgcn.fdot2.bf16.bf16(<2 x i16> %a.val.dpp.v2i16, <2 x i16> %b.val, i16 %c.val)
  store i16 %r.val, ptr addrspace(5) %r
  ret void
}

; Make sure we do not violate constant bus restriction with 3 scalar inputs and simingly inlinable literal.

define amdgpu_ps void @test_llvm_amdgcn_fdot2_bf16_bf16_sis(
; GFX11-LABEL: test_llvm_amdgcn_fdot2_bf16_bf16_sis:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    v_mov_b32_e32 v2, s1
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_dot2_bf16_bf16 v2, s0, 0x10001, v2
; GFX11-NEXT:    global_store_b16 v[0:1], v2, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
    ptr addrspace(1) %r,
    <2 x i16> inreg %a,
    i16 inreg %c) {
entry:
  %r.val = call i16 @llvm.amdgcn.fdot2.bf16.bf16(<2 x i16> %a, <2 x i16> <i16 1, i16 1>, i16 %c)
  store i16 %r.val, ptr addrspace(1) %r
  ret void
}

declare i32 @llvm.amdgcn.update.dpp.i32(i32, i32, i32, i32, i32, i1)
