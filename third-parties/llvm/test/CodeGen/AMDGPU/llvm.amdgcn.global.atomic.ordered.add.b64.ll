; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX12-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX12-GISEL %s

declare i64 @llvm.amdgcn.global.atomic.ordered.add.b64(ptr addrspace(1), i64)

define amdgpu_kernel void @global_atomic_ordered_add_b64_no_rtn(ptr addrspace(1) %addr, i64 %in) {
; GFX12-SDAG-LABEL: global_atomic_ordered_add_b64_no_rtn:
; GFX12-SDAG:       ; %bb.0: ; %entry
; GFX12-SDAG-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-SDAG-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-NEXT:    v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s3
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v0, s2
; GFX12-SDAG-NEXT:    global_atomic_ordered_add_b64 v[0:1], v2, v[0:1], s[0:1] offset:-32 th:TH_ATOMIC_RETURN
; GFX12-SDAG-NEXT:    s_endpgm
;
; GFX12-GISEL-LABEL: global_atomic_ordered_add_b64_no_rtn:
; GFX12-GISEL:       ; %bb.0: ; %entry
; GFX12-GISEL-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-GISEL-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-NEXT:    v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
; GFX12-GISEL-NEXT:    global_atomic_ordered_add_b64 v[0:1], v2, v[0:1], s[0:1] offset:-32 th:TH_ATOMIC_RETURN
; GFX12-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 -4
  %unused = call i64 @llvm.amdgcn.global.atomic.ordered.add.b64(ptr addrspace(1) %gep, i64 %in)
  ret void
}

define amdgpu_kernel void @global_atomic_ordered_add_b64_rtn(ptr addrspace(1) %addr, i64 %in, ptr addrspace(1) %use) {
; GFX12-SDAG-LABEL: global_atomic_ordered_add_b64_rtn:
; GFX12-SDAG:       ; %bb.0: ; %entry
; GFX12-SDAG-NEXT:    s_load_b128 s[4:7], s[0:1], 0x24
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-SDAG-NEXT:    s_load_b64 s[0:1], s[0:1], 0x34
; GFX12-SDAG-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-NEXT:    v_dual_mov_b32 v1, s7 :: v_dual_mov_b32 v0, s6
; GFX12-SDAG-NEXT:    global_atomic_ordered_add_b64 v[0:1], v2, v[0:1], s[4:5] offset:32 th:TH_ATOMIC_RETURN
; GFX12-SDAG-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-NEXT:    global_store_b64 v2, v[0:1], s[0:1]
; GFX12-SDAG-NEXT:    s_nop 0
; GFX12-SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-SDAG-NEXT:    s_endpgm
;
; GFX12-GISEL-LABEL: global_atomic_ordered_add_b64_rtn:
; GFX12-GISEL:       ; %bb.0: ; %entry
; GFX12-GISEL-NEXT:    s_clause 0x1
; GFX12-GISEL-NEXT:    s_load_b128 s[4:7], s[0:1], 0x24
; GFX12-GISEL-NEXT:    s_load_b64 s[0:1], s[0:1], 0x34
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-GISEL-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-NEXT:    v_dual_mov_b32 v0, s6 :: v_dual_mov_b32 v1, s7
; GFX12-GISEL-NEXT:    global_atomic_ordered_add_b64 v[0:1], v2, v[0:1], s[4:5] offset:32 th:TH_ATOMIC_RETURN
; GFX12-GISEL-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-NEXT:    global_store_b64 v2, v[0:1], s[0:1]
; GFX12-GISEL-NEXT:    s_nop 0
; GFX12-GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call i64 @llvm.amdgcn.global.atomic.ordered.add.b64(ptr addrspace(1) %gep, i64 %in)
  store i64 %val, ptr addrspace(1) %use
  ret void
}
