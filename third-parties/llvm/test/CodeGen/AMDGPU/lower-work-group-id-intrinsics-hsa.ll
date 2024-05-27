; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-hsa -mcpu=gfx900 -mattr=-architected-sgprs -global-isel=0 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX9,GFX9-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-hsa -mcpu=gfx900 -mattr=-architected-sgprs -global-isel=1 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX9,GFX9-GISEL %s
; RUN: llc -mtriple=amdgcn-amd-hsa -mcpu=gfx900 -mattr=+architected-sgprs -global-isel=0 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX9ARCH,GFX9ARCH-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-hsa -mcpu=gfx900 -mattr=+architected-sgprs -global-isel=1 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX9ARCH,GFX9ARCH-GISEL %s
; RUN: llc -mtriple=amdgcn-amd-amdpal -mcpu=gfx1200 -global-isel=0 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX12,GFX12-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-amdpal -mcpu=gfx1200 -global-isel=1 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX12,GFX12-GISEL %s

define amdgpu_kernel void @workgroup_ids_kernel() {
; GFX9-LABEL: workgroup_ids_kernel:
; GFX9:       ; %bb.0: ; %.entry
; GFX9-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-NEXT:    v_mov_b32_e32 v1, s1
; GFX9-NEXT:    v_mov_b32_e32 v2, s2
; GFX9-NEXT:    buffer_store_dwordx3 v[0:2], off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; GFX9ARCH-SDAG-LABEL: workgroup_ids_kernel:
; GFX9ARCH-SDAG:       ; %bb.0: ; %.entry
; GFX9ARCH-SDAG-NEXT:    s_lshr_b32 s0, ttmp7, 16
; GFX9ARCH-SDAG-NEXT:    s_and_b32 s1, ttmp7, 0xffff
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v0, ttmp9
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX9ARCH-SDAG-NEXT:    buffer_store_dwordx3 v[0:2], off, s[0:3], 0
; GFX9ARCH-SDAG-NEXT:    s_endpgm
;
; GFX9ARCH-GISEL-LABEL: workgroup_ids_kernel:
; GFX9ARCH-GISEL:       ; %bb.0: ; %.entry
; GFX9ARCH-GISEL-NEXT:    s_mov_b32 s0, ttmp9
; GFX9ARCH-GISEL-NEXT:    s_and_b32 s1, ttmp7, 0xffff
; GFX9ARCH-GISEL-NEXT:    s_lshr_b32 s2, ttmp7, 16
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v2, s2
; GFX9ARCH-GISEL-NEXT:    buffer_store_dwordx3 v[0:2], off, s[0:3], 0
; GFX9ARCH-GISEL-NEXT:    s_endpgm
;
; GFX12-SDAG-LABEL: workgroup_ids_kernel:
; GFX12-SDAG:       ; %bb.0: ; %.entry
; GFX12-SDAG-NEXT:    s_and_b32 s0, ttmp7, 0xffff
; GFX12-SDAG-NEXT:    s_lshr_b32 s1, ttmp7, 16
; GFX12-SDAG-NEXT:    v_dual_mov_b32 v0, ttmp9 :: v_dual_mov_b32 v1, s0
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v2, s1
; GFX12-SDAG-NEXT:    buffer_store_b96 v[0:2], off, s[0:3], null
; GFX12-SDAG-NEXT:    s_nop 0
; GFX12-SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-SDAG-NEXT:    s_endpgm
;
; GFX12-GISEL-LABEL: workgroup_ids_kernel:
; GFX12-GISEL:       ; %bb.0: ; %.entry
; GFX12-GISEL-NEXT:    s_mov_b32 s0, ttmp9
; GFX12-GISEL-NEXT:    s_and_b32 s1, ttmp7, 0xffff
; GFX12-GISEL-NEXT:    s_lshr_b32 s2, ttmp7, 16
; GFX12-GISEL-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v2, s2
; GFX12-GISEL-NEXT:    buffer_store_b96 v[0:2], off, s[0:3], null
; GFX12-GISEL-NEXT:    s_nop 0
; GFX12-GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-GISEL-NEXT:    s_endpgm
.entry:
  %idx = call i32 @llvm.amdgcn.workgroup.id.x()
  %idy = call i32 @llvm.amdgcn.workgroup.id.y()
  %idz = call i32 @llvm.amdgcn.workgroup.id.z()
  %ielemx = insertelement <3 x i32> undef, i32 %idx, i64 0
  %ielemy = insertelement <3 x i32> %ielemx, i32 %idy, i64 1
  %ielemz = insertelement <3 x i32> %ielemy, i32 %idz, i64 2
  call void @llvm.amdgcn.raw.ptr.buffer.store.v3i32(<3 x i32> %ielemz, ptr addrspace(8) undef, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_kernel void @caller() {
; GFX9-SDAG-LABEL: caller:
; GFX9-SDAG:       ; %bb.0:
; GFX9-SDAG-NEXT:    s_mov_b32 s36, SCRATCH_RSRC_DWORD0
; GFX9-SDAG-NEXT:    s_mov_b32 s37, SCRATCH_RSRC_DWORD1
; GFX9-SDAG-NEXT:    s_mov_b32 s38, -1
; GFX9-SDAG-NEXT:    s_mov_b32 s39, 0xe00000
; GFX9-SDAG-NEXT:    s_add_u32 s36, s36, s7
; GFX9-SDAG-NEXT:    s_addc_u32 s37, s37, 0
; GFX9-SDAG-NEXT:    s_add_u32 s8, s2, 36
; GFX9-SDAG-NEXT:    s_addc_u32 s9, s3, 0
; GFX9-SDAG-NEXT:    s_getpc_b64 s[2:3]
; GFX9-SDAG-NEXT:    s_add_u32 s2, s2, callee@gotpcrel32@lo+4
; GFX9-SDAG-NEXT:    s_addc_u32 s3, s3, callee@gotpcrel32@hi+12
; GFX9-SDAG-NEXT:    s_load_dwordx2 s[14:15], s[2:3], 0x0
; GFX9-SDAG-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GFX9-SDAG-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GFX9-SDAG-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GFX9-SDAG-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GFX9-SDAG-NEXT:    s_mov_b64 s[0:1], s[36:37]
; GFX9-SDAG-NEXT:    v_or3_b32 v31, v0, v1, v2
; GFX9-SDAG-NEXT:    s_mov_b32 s12, s6
; GFX9-SDAG-NEXT:    s_mov_b64 s[2:3], s[38:39]
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, s6
; GFX9-SDAG-NEXT:    s_mov_b32 s32, 0
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_swappc_b64 s[30:31], s[14:15]
; GFX9-SDAG-NEXT:    s_endpgm
;
; GFX9-GISEL-LABEL: caller:
; GFX9-GISEL:       ; %bb.0:
; GFX9-GISEL-NEXT:    s_mov_b32 s36, SCRATCH_RSRC_DWORD0
; GFX9-GISEL-NEXT:    s_mov_b32 s37, SCRATCH_RSRC_DWORD1
; GFX9-GISEL-NEXT:    s_mov_b32 s38, -1
; GFX9-GISEL-NEXT:    s_mov_b32 s39, 0xe00000
; GFX9-GISEL-NEXT:    s_add_u32 s36, s36, s7
; GFX9-GISEL-NEXT:    s_addc_u32 s37, s37, 0
; GFX9-GISEL-NEXT:    s_add_u32 s8, s2, 36
; GFX9-GISEL-NEXT:    s_addc_u32 s9, s3, 0
; GFX9-GISEL-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GFX9-GISEL-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GFX9-GISEL-NEXT:    s_getpc_b64 s[0:1]
; GFX9-GISEL-NEXT:    s_add_u32 s0, s0, callee@gotpcrel32@lo+4
; GFX9-GISEL-NEXT:    s_addc_u32 s1, s1, callee@gotpcrel32@hi+12
; GFX9-GISEL-NEXT:    s_load_dwordx2 s[14:15], s[0:1], 0x0
; GFX9-GISEL-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GFX9-GISEL-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GFX9-GISEL-NEXT:    s_mov_b64 s[0:1], s[36:37]
; GFX9-GISEL-NEXT:    v_or3_b32 v31, v0, v1, v2
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, s6
; GFX9-GISEL-NEXT:    s_mov_b64 s[2:3], s[38:39]
; GFX9-GISEL-NEXT:    s_mov_b32 s12, s6
; GFX9-GISEL-NEXT:    s_mov_b32 s32, 0
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_swappc_b64 s[30:31], s[14:15]
; GFX9-GISEL-NEXT:    s_endpgm
;
; GFX9ARCH-SDAG-LABEL: caller:
; GFX9ARCH-SDAG:       ; %bb.0:
; GFX9ARCH-SDAG-NEXT:    s_mov_b32 s36, SCRATCH_RSRC_DWORD0
; GFX9ARCH-SDAG-NEXT:    s_mov_b32 s37, SCRATCH_RSRC_DWORD1
; GFX9ARCH-SDAG-NEXT:    s_mov_b32 s38, -1
; GFX9ARCH-SDAG-NEXT:    s_mov_b32 s39, 0xe00000
; GFX9ARCH-SDAG-NEXT:    s_add_u32 s36, s36, s6
; GFX9ARCH-SDAG-NEXT:    s_addc_u32 s37, s37, 0
; GFX9ARCH-SDAG-NEXT:    s_add_u32 s8, s2, 36
; GFX9ARCH-SDAG-NEXT:    s_addc_u32 s9, s3, 0
; GFX9ARCH-SDAG-NEXT:    s_getpc_b64 s[2:3]
; GFX9ARCH-SDAG-NEXT:    s_add_u32 s2, s2, callee@gotpcrel32@lo+4
; GFX9ARCH-SDAG-NEXT:    s_addc_u32 s3, s3, callee@gotpcrel32@hi+12
; GFX9ARCH-SDAG-NEXT:    s_load_dwordx2 s[6:7], s[2:3], 0x0
; GFX9ARCH-SDAG-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GFX9ARCH-SDAG-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GFX9ARCH-SDAG-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GFX9ARCH-SDAG-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GFX9ARCH-SDAG-NEXT:    s_mov_b64 s[0:1], s[36:37]
; GFX9ARCH-SDAG-NEXT:    v_or3_b32 v31, v0, v1, v2
; GFX9ARCH-SDAG-NEXT:    s_mov_b64 s[2:3], s[38:39]
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v0, ttmp9
; GFX9ARCH-SDAG-NEXT:    s_mov_b32 s32, 0
; GFX9ARCH-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9ARCH-SDAG-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GFX9ARCH-SDAG-NEXT:    s_endpgm
;
; GFX9ARCH-GISEL-LABEL: caller:
; GFX9ARCH-GISEL:       ; %bb.0:
; GFX9ARCH-GISEL-NEXT:    s_mov_b32 s36, SCRATCH_RSRC_DWORD0
; GFX9ARCH-GISEL-NEXT:    s_mov_b32 s37, SCRATCH_RSRC_DWORD1
; GFX9ARCH-GISEL-NEXT:    s_mov_b32 s38, -1
; GFX9ARCH-GISEL-NEXT:    s_mov_b32 s39, 0xe00000
; GFX9ARCH-GISEL-NEXT:    s_add_u32 s36, s36, s6
; GFX9ARCH-GISEL-NEXT:    s_addc_u32 s37, s37, 0
; GFX9ARCH-GISEL-NEXT:    s_add_u32 s8, s2, 36
; GFX9ARCH-GISEL-NEXT:    s_addc_u32 s9, s3, 0
; GFX9ARCH-GISEL-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GFX9ARCH-GISEL-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GFX9ARCH-GISEL-NEXT:    s_getpc_b64 s[0:1]
; GFX9ARCH-GISEL-NEXT:    s_add_u32 s0, s0, callee@gotpcrel32@lo+4
; GFX9ARCH-GISEL-NEXT:    s_addc_u32 s1, s1, callee@gotpcrel32@hi+12
; GFX9ARCH-GISEL-NEXT:    s_load_dwordx2 s[6:7], s[0:1], 0x0
; GFX9ARCH-GISEL-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GFX9ARCH-GISEL-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GFX9ARCH-GISEL-NEXT:    s_mov_b64 s[0:1], s[36:37]
; GFX9ARCH-GISEL-NEXT:    v_or3_b32 v31, v0, v1, v2
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v0, ttmp9
; GFX9ARCH-GISEL-NEXT:    s_mov_b64 s[2:3], s[38:39]
; GFX9ARCH-GISEL-NEXT:    s_mov_b32 s32, 0
; GFX9ARCH-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9ARCH-GISEL-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GFX9ARCH-GISEL-NEXT:    s_endpgm
;
; GFX12-SDAG-LABEL: caller:
; GFX12-SDAG:       ; %bb.0:
; GFX12-SDAG-NEXT:    v_dual_mov_b32 v31, v0 :: v_dual_mov_b32 v0, ttmp9
; GFX12-SDAG-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GFX12-SDAG-NEXT:    s_mov_b32 s7, callee@abs32@hi
; GFX12-SDAG-NEXT:    s_mov_b32 s6, callee@abs32@lo
; GFX12-SDAG-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GFX12-SDAG-NEXT:    s_mov_b64 s[8:9], s[2:3]
; GFX12-SDAG-NEXT:    s_mov_b32 s32, 0
; GFX12-SDAG-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GFX12-SDAG-NEXT:    s_endpgm
;
; GFX12-GISEL-LABEL: caller:
; GFX12-GISEL:       ; %bb.0:
; GFX12-GISEL-NEXT:    v_dual_mov_b32 v31, v0 :: v_dual_mov_b32 v0, ttmp9
; GFX12-GISEL-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GFX12-GISEL-NEXT:    s_mov_b32 s6, callee@abs32@lo
; GFX12-GISEL-NEXT:    s_mov_b32 s7, callee@abs32@hi
; GFX12-GISEL-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GFX12-GISEL-NEXT:    s_mov_b64 s[8:9], s[2:3]
; GFX12-GISEL-NEXT:    s_mov_b32 s32, 0
; GFX12-GISEL-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GFX12-GISEL-NEXT:    s_endpgm
  %idx = call i32 @llvm.amdgcn.workgroup.id.x()
  call void @callee(i32 %idx) #0
  ret void
}

declare void @callee(i32) #0

define void @workgroup_ids_device_func(ptr addrspace(1) %outx, ptr addrspace(1) %outy, ptr addrspace(1) %outz) {
; GFX9-LABEL: workgroup_ids_device_func:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v6, s12
; GFX9-NEXT:    global_store_dword v[0:1], v6, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, s13
; GFX9-NEXT:    global_store_dword v[2:3], v0, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, s14
; GFX9-NEXT:    global_store_dword v[4:5], v0, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ARCH-SDAG-LABEL: workgroup_ids_device_func:
; GFX9ARCH-SDAG:       ; %bb.0:
; GFX9ARCH-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v6, ttmp9
; GFX9ARCH-SDAG-NEXT:    s_and_b32 s4, ttmp7, 0xffff
; GFX9ARCH-SDAG-NEXT:    global_store_dword v[0:1], v6, off
; GFX9ARCH-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v0, s4
; GFX9ARCH-SDAG-NEXT:    s_lshr_b32 s4, ttmp7, 16
; GFX9ARCH-SDAG-NEXT:    global_store_dword v[2:3], v0, off
; GFX9ARCH-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9ARCH-SDAG-NEXT:    v_mov_b32_e32 v0, s4
; GFX9ARCH-SDAG-NEXT:    global_store_dword v[4:5], v0, off
; GFX9ARCH-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9ARCH-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ARCH-GISEL-LABEL: workgroup_ids_device_func:
; GFX9ARCH-GISEL:       ; %bb.0:
; GFX9ARCH-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v6, ttmp9
; GFX9ARCH-GISEL-NEXT:    s_and_b32 s4, ttmp7, 0xffff
; GFX9ARCH-GISEL-NEXT:    s_lshr_b32 s5, ttmp7, 16
; GFX9ARCH-GISEL-NEXT:    global_store_dword v[0:1], v6, off
; GFX9ARCH-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v0, s4
; GFX9ARCH-GISEL-NEXT:    global_store_dword v[2:3], v0, off
; GFX9ARCH-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9ARCH-GISEL-NEXT:    v_mov_b32_e32 v0, s5
; GFX9ARCH-GISEL-NEXT:    global_store_dword v[4:5], v0, off
; GFX9ARCH-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9ARCH-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: workgroup_ids_device_func:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_and_b32 s0, ttmp7, 0xffff
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
; GFX12-NEXT:    v_dual_mov_b32 v6, ttmp9 :: v_dual_mov_b32 v7, s0
; GFX12-NEXT:    s_lshr_b32 s1, ttmp7, 16
; GFX12-NEXT:    v_mov_b32_e32 v8, s1
; GFX12-NEXT:    global_store_b32 v[0:1], v6, off scope:SCOPE_SYS
; GFX12-NEXT:    s_wait_storecnt 0x0
; GFX12-NEXT:    global_store_b32 v[2:3], v7, off scope:SCOPE_SYS
; GFX12-NEXT:    s_wait_storecnt 0x0
; GFX12-NEXT:    global_store_b32 v[4:5], v8, off scope:SCOPE_SYS
; GFX12-NEXT:    s_wait_storecnt 0x0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %id.x = call i32 @llvm.amdgcn.workgroup.id.x()
  %id.y = call i32 @llvm.amdgcn.workgroup.id.y()
  %id.z = call i32 @llvm.amdgcn.workgroup.id.z()
  store volatile i32 %id.x, ptr addrspace(1) %outx
  store volatile i32 %id.y, ptr addrspace(1) %outy
  store volatile i32 %id.z, ptr addrspace(1) %outz
  ret void
}

declare i32 @llvm.amdgcn.workgroup.id.x()
declare i32 @llvm.amdgcn.workgroup.id.y()
declare i32 @llvm.amdgcn.workgroup.id.z()
declare void @llvm.amdgcn.raw.ptr.buffer.store.v3i32(<3 x i32>, ptr addrspace(8), i32, i32, i32 immarg)

attributes #0 = { nounwind "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" }
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; GFX9ARCH: {{.*}}
