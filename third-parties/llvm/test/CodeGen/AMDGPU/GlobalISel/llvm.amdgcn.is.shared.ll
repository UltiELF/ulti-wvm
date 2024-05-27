; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=CI %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GFX9 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GFX10 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GFX11 %s

; TODO: Merge with DAG test

define amdgpu_kernel void @is_local_vgpr(ptr addrspace(1) %ptr.ptr) {
; CI-LABEL: is_local_vgpr:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    s_load_dword s2, s[4:5], 0x33
; CI-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_add_i32_e32 v0, vcc, v0, v2
; CI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-NEXT:    flat_load_dwordx2 v[0:1], v[0:1] glc
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_cmp_eq_u32_e32 vcc, s2, v1
; CI-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; CI-NEXT:    flat_store_dword v[0:1], v0
; CI-NEXT:    s_endpgm
;
; GFX9-LABEL: is_local_vgpr:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v0, s[0:1] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_mov_b64 s[0:1], src_shared_base
; GFX9-NEXT:    v_cmp_eq_u32_e32 vcc, s1, v1
; GFX9-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GFX9-NEXT:    global_store_dword v[0:1], v0, off
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: is_local_vgpr:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dwordx2 v[0:1], v0, s[0:1] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-NEXT:    s_mov_b64 s[0:1], src_shared_base
; GFX10-NEXT:    v_cmp_eq_u32_e32 vcc_lo, s1, v1
; GFX10-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc_lo
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: is_local_vgpr:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b64 s[0:1], s[0:1], 0x0
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b64 v[0:1], v0, s[0:1] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    s_mov_b64 s[0:1], src_shared_base
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_cmp_eq_u32_e32 vcc_lo, s1, v1
; GFX11-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc_lo
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %id = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr inbounds ptr, ptr addrspace(1) %ptr.ptr, i32 %id
  %ptr = load volatile ptr, ptr addrspace(1) %gep
  %val = call i1 @llvm.amdgcn.is.shared(ptr %ptr)
  %ext = zext i1 %val to i32
  store i32 %ext, ptr addrspace(1) undef
  ret void
}

define amdgpu_kernel void @is_local_sgpr(ptr %ptr) {
; CI-LABEL: is_local_sgpr:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_load_dword s0, s[4:5], 0x33
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_cmp_lg_u32 s1, s0
; CI-NEXT:    s_cbranch_scc1 .LBB1_2
; CI-NEXT:  ; %bb.1: ; %bb0
; CI-NEXT:    v_mov_b32_e32 v0, 0
; CI-NEXT:    flat_store_dword v[0:1], v0
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:  .LBB1_2: ; %bb1
; CI-NEXT:    s_endpgm
;
; GFX9-LABEL: is_local_sgpr:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    s_mov_b64 s[2:3], src_shared_base
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_cmp_lg_u32 s1, s3
; GFX9-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX9-NEXT:  ; %bb.1: ; %bb0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    global_store_dword v[0:1], v0, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:  .LBB1_2: ; %bb1
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: is_local_sgpr:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-NEXT:    s_mov_b64 s[2:3], src_shared_base
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_cmp_lg_u32 s1, s3
; GFX10-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX10-NEXT:  ; %bb.1: ; %bb0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:  .LBB1_2: ; %bb1
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: is_local_sgpr:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b64 s[0:1], s[0:1], 0x0
; GFX11-NEXT:    s_mov_b64 s[2:3], src_shared_base
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_cmp_lg_u32 s1, s3
; GFX11-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX11-NEXT:  ; %bb.1: ; %bb0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off dlc
; GFX11-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX11-NEXT:  .LBB1_2: ; %bb1
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %val = call i1 @llvm.amdgcn.is.shared(ptr %ptr)
  br i1 %val, label %bb0, label %bb1

bb0:
  store volatile i32 0, ptr addrspace(1) undef
  br label %bb1

bb1:
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #0
declare i1 @llvm.amdgcn.is.shared(ptr nocapture) #0

attributes #0 = { nounwind readnone speculatable }

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdgpu_code_object_version", i32 500}
