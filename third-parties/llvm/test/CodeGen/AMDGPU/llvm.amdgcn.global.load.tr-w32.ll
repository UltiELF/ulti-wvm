; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel=0 -march=amdgcn -mcpu=gfx1200 -verify-machineinstrs -mattr=+wavefrontsize32,-wavefrontsize64 < %s | FileCheck -check-prefixes=GFX12-SDAG-W32 %s
; RUN: llc -global-isel=1 -march=amdgcn -mcpu=gfx1200 -verify-machineinstrs -mattr=+wavefrontsize32,-wavefrontsize64 < %s | FileCheck -check-prefixes=GFX12-GISEL-W32 %s

declare <2 x i32> @llvm.amdgcn.global.load.tr.v2i32.p1(ptr addrspace(1))
declare <8 x i16> @llvm.amdgcn.global.load.tr.v8i16.p1(ptr addrspace(1))
declare <8 x half> @llvm.amdgcn.global.load.tr.v8f16.p1(ptr addrspace(1))
declare <8 x bfloat> @llvm.amdgcn.global.load.tr.v8bf16.p1(ptr addrspace(1))

define amdgpu_kernel void @global_load_tr_b64(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-SDAG-W32-LABEL: global_load_tr_b64:
; GFX12-SDAG-W32:       ; %bb.0: ; %entry
; GFX12-SDAG-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-SDAG-W32-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-SDAG-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_load_tr_b64 v[0:1], v2, s[0:1] offset:32
; GFX12-SDAG-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_store_b64 v2, v[0:1], s[2:3]
; GFX12-SDAG-W32-NEXT:    s_nop 0
; GFX12-SDAG-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-SDAG-W32-NEXT:    s_endpgm
;
; GFX12-GISEL-W32-LABEL: global_load_tr_b64:
; GFX12-GISEL-W32:       ; %bb.0: ; %entry
; GFX12-GISEL-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-GISEL-W32-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-GISEL-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_load_tr_b64 v[0:1], v2, s[0:1] offset:32
; GFX12-GISEL-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_store_b64 v2, v[0:1], s[2:3]
; GFX12-GISEL-W32-NEXT:    s_nop 0
; GFX12-GISEL-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-GISEL-W32-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <2 x i32> @llvm.amdgcn.global.load.tr.v2i32.p1(ptr addrspace(1) %gep)
  store <2 x i32> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_kernel void @global_load_tr_b128_i16(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-SDAG-W32-LABEL: global_load_tr_b128_i16:
; GFX12-SDAG-W32:       ; %bb.0: ; %entry
; GFX12-SDAG-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-SDAG-W32-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-SDAG-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_load_tr_b128 v[0:3], v4, s[0:1] offset:32
; GFX12-SDAG-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_store_b128 v4, v[0:3], s[2:3]
; GFX12-SDAG-W32-NEXT:    s_nop 0
; GFX12-SDAG-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-SDAG-W32-NEXT:    s_endpgm
;
; GFX12-GISEL-W32-LABEL: global_load_tr_b128_i16:
; GFX12-GISEL-W32:       ; %bb.0: ; %entry
; GFX12-GISEL-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-GISEL-W32-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-GISEL-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_load_tr_b128 v[0:3], v4, s[0:1] offset:32
; GFX12-GISEL-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_store_b128 v4, v[0:3], s[2:3]
; GFX12-GISEL-W32-NEXT:    s_nop 0
; GFX12-GISEL-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-GISEL-W32-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <8 x i16> @llvm.amdgcn.global.load.tr.v8i16.p1(ptr addrspace(1) %gep)
  store <8 x i16> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_kernel void @global_load_tr_b128_half(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-SDAG-W32-LABEL: global_load_tr_b128_half:
; GFX12-SDAG-W32:       ; %bb.0: ; %entry
; GFX12-SDAG-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-SDAG-W32-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-SDAG-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_load_tr_b128 v[0:3], v4, s[0:1] offset:32
; GFX12-SDAG-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_store_b128 v4, v[0:3], s[2:3]
; GFX12-SDAG-W32-NEXT:    s_nop 0
; GFX12-SDAG-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-SDAG-W32-NEXT:    s_endpgm
;
; GFX12-GISEL-W32-LABEL: global_load_tr_b128_half:
; GFX12-GISEL-W32:       ; %bb.0: ; %entry
; GFX12-GISEL-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-GISEL-W32-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-GISEL-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_load_tr_b128 v[0:3], v4, s[0:1] offset:32
; GFX12-GISEL-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_store_b128 v4, v[0:3], s[2:3]
; GFX12-GISEL-W32-NEXT:    s_nop 0
; GFX12-GISEL-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-GISEL-W32-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <8 x half> @llvm.amdgcn.global.load.tr.v8f16.p1(ptr addrspace(1) %gep)
  store <8 x half> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_kernel void @global_load_tr_b128_bfloat(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-SDAG-W32-LABEL: global_load_tr_b128_bfloat:
; GFX12-SDAG-W32:       ; %bb.0: ; %entry
; GFX12-SDAG-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-SDAG-W32-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-SDAG-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_load_tr_b128 v[0:3], v4, s[0:1] offset:32
; GFX12-SDAG-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-W32-NEXT:    global_store_b128 v4, v[0:3], s[2:3]
; GFX12-SDAG-W32-NEXT:    s_nop 0
; GFX12-SDAG-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-SDAG-W32-NEXT:    s_endpgm
;
; GFX12-GISEL-W32-LABEL: global_load_tr_b128_bfloat:
; GFX12-GISEL-W32:       ; %bb.0: ; %entry
; GFX12-GISEL-W32-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-GISEL-W32-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-GISEL-W32-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_load_tr_b128 v[0:3], v4, s[0:1] offset:32
; GFX12-GISEL-W32-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-W32-NEXT:    global_store_b128 v4, v[0:3], s[2:3]
; GFX12-GISEL-W32-NEXT:    s_nop 0
; GFX12-GISEL-W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-GISEL-W32-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <8 x bfloat> @llvm.amdgcn.global.load.tr.v8bf16.p1(ptr addrspace(1) %gep)
  store <8 x bfloat> %val, ptr addrspace(1) %use
  ret void
}
