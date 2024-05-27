; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx90a -greedy-regclass-priority-trumps-globalness=1 -o - %s | FileCheck -check-prefixes=GFX90A,GLOBALNESS1 %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx90a -greedy-regclass-priority-trumps-globalness=0 -o - %s | FileCheck -check-prefixes=GFX90A,GLOBALNESS0 %s

declare void @wobble()

define internal fastcc void @widget() {
; GFX90A-LABEL: widget:
; GFX90A:       ; %bb.0: ; %bb
; GFX90A-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX90A-NEXT:    s_mov_b32 s16, s33
; GFX90A-NEXT:    s_mov_b32 s33, s32
; GFX90A-NEXT:    s_or_saveexec_b64 s[18:19], -1
; GFX90A-NEXT:    buffer_store_dword v40, off, s[0:3], s33 ; 4-byte Folded Spill
; GFX90A-NEXT:    s_mov_b64 exec, s[18:19]
; GFX90A-NEXT:    s_addk_i32 s32, 0x400
; GFX90A-NEXT:    v_writelane_b32 v40, s16, 2
; GFX90A-NEXT:    s_getpc_b64 s[16:17]
; GFX90A-NEXT:    s_add_u32 s16, s16, wobble@gotpcrel32@lo+4
; GFX90A-NEXT:    s_addc_u32 s17, s17, wobble@gotpcrel32@hi+12
; GFX90A-NEXT:    s_load_dwordx2 s[16:17], s[16:17], 0x0
; GFX90A-NEXT:    v_writelane_b32 v40, s30, 0
; GFX90A-NEXT:    v_writelane_b32 v40, s31, 1
; GFX90A-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NEXT:    s_swappc_b64 s[30:31], s[16:17]
bb:
  tail call void @wobble()
  unreachable
}

define amdgpu_kernel void @kernel(ptr addrspace(1) %arg1.global, i1 %tmp3.i.i, i32 %tmp5.i.i, i32 %tmp427.i, i1 %tmp438.i, double %tmp27.i, i1 %tmp48.i) {
; GLOBALNESS1-LABEL: kernel:
; GLOBALNESS1:       ; %bb.0: ; %bb
; GLOBALNESS1-NEXT:    s_mov_b64 s[38:39], s[6:7]
; GLOBALNESS1-NEXT:    s_load_dwordx4 s[72:75], s[6:7], 0x0
; GLOBALNESS1-NEXT:    s_nop 0
; GLOBALNESS1-NEXT:    s_load_dword s6, s[6:7], 0x14
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v41, v0
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v42, 0
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[0:1], 0, 0
; GLOBALNESS1-NEXT:    global_store_dword v[0:1], v42, off
; GLOBALNESS1-NEXT:    s_waitcnt lgkmcnt(0)
; GLOBALNESS1-NEXT:    global_load_dword v2, v42, s[72:73]
; GLOBALNESS1-NEXT:    s_mov_b64 s[36:37], s[4:5]
; GLOBALNESS1-NEXT:    s_load_dwordx2 s[4:5], s[38:39], 0x18
; GLOBALNESS1-NEXT:    s_load_dword s7, s[38:39], 0x20
; GLOBALNESS1-NEXT:    s_add_u32 flat_scratch_lo, s10, s15
; GLOBALNESS1-NEXT:    s_addc_u32 flat_scratch_hi, s11, 0
; GLOBALNESS1-NEXT:    s_add_u32 s0, s0, s15
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v0, 0
; GLOBALNESS1-NEXT:    s_addc_u32 s1, s1, 0
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v1, 0x40994400
; GLOBALNESS1-NEXT:    s_bitcmp1_b32 s74, 0
; GLOBALNESS1-NEXT:    s_waitcnt lgkmcnt(0)
; GLOBALNESS1-NEXT:    v_cmp_ngt_f64_e32 vcc, s[4:5], v[0:1]
; GLOBALNESS1-NEXT:    v_cmp_ngt_f64_e64 s[4:5], s[4:5], 0
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v1, 0, 1, s[4:5]
; GLOBALNESS1-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v3, 0, 1, s[4:5]
; GLOBALNESS1-NEXT:    s_xor_b64 s[4:5], s[4:5], -1
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GLOBALNESS1-NEXT:    s_bitcmp1_b32 s6, 0
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[40:41], 1, v0
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GLOBALNESS1-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GLOBALNESS1-NEXT:    s_xor_b64 s[4:5], s[4:5], -1
; GLOBALNESS1-NEXT:    s_bitcmp1_b32 s7, 0
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[46:47], 1, v0
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GLOBALNESS1-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GLOBALNESS1-NEXT:    s_getpc_b64 s[6:7]
; GLOBALNESS1-NEXT:    s_add_u32 s6, s6, wobble@gotpcrel32@lo+4
; GLOBALNESS1-NEXT:    s_addc_u32 s7, s7, wobble@gotpcrel32@hi+12
; GLOBALNESS1-NEXT:    s_xor_b64 s[4:5], s[4:5], -1
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[48:49], 1, v0
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GLOBALNESS1-NEXT:    s_load_dwordx2 s[72:73], s[6:7], 0x0
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[50:51], 1, v0
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[42:43], 1, v1
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[44:45], 1, v3
; GLOBALNESS1-NEXT:    s_mov_b32 s68, s14
; GLOBALNESS1-NEXT:    s_mov_b32 s69, s13
; GLOBALNESS1-NEXT:    s_mov_b32 s70, s12
; GLOBALNESS1-NEXT:    s_mov_b64 s[34:35], s[8:9]
; GLOBALNESS1-NEXT:    s_mov_b32 s32, 0
; GLOBALNESS1-NEXT:    ; implicit-def: $vgpr44_vgpr45
; GLOBALNESS1-NEXT:    s_waitcnt vmcnt(0)
; GLOBALNESS1-NEXT:    v_cmp_gt_i32_e32 vcc, 0, v2
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GLOBALNESS1-NEXT:    v_cmp_gt_i32_e32 vcc, 1, v2
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v1, 0, 1, vcc
; GLOBALNESS1-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v2
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v3, 0, 1, vcc
; GLOBALNESS1-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v2
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v2, 0, 1, vcc
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[52:53], 1, v0
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[54:55], 1, v1
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[56:57], 1, v3
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[58:59], 1, v2
; GLOBALNESS1-NEXT:    s_branch .LBB1_4
; GLOBALNESS1-NEXT:  .LBB1_1: ; %bb70.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[58:59]
; GLOBALNESS1-NEXT:    s_cbranch_vccz .LBB1_29
; GLOBALNESS1-NEXT:  .LBB1_2: ; %Flow15
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_or_b64 exec, exec, s[4:5]
; GLOBALNESS1-NEXT:    s_mov_b64 s[6:7], 0
; GLOBALNESS1-NEXT:    ; implicit-def: $sgpr4_sgpr5
; GLOBALNESS1-NEXT:  .LBB1_3: ; %Flow28
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[6:7]
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[44:45], v[0:1], v[0:1] op_sel:[0,1]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_30
; GLOBALNESS1-NEXT:  .LBB1_4: ; %bb5
; GLOBALNESS1-NEXT:    ; =>This Loop Header: Depth=1
; GLOBALNESS1-NEXT:    ; Child Loop BB1_16 Depth 2
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v0, 0x80
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v1, 0
; GLOBALNESS1-NEXT:    flat_load_dword v40, v[0:1]
; GLOBALNESS1-NEXT:    s_add_u32 s8, s38, 40
; GLOBALNESS1-NEXT:    buffer_store_dword v42, off, s[0:3], 0
; GLOBALNESS1-NEXT:    flat_load_dword v46, v[0:1]
; GLOBALNESS1-NEXT:    s_addc_u32 s9, s39, 0
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS1-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS1-NEXT:    s_mov_b32 s12, s70
; GLOBALNESS1-NEXT:    s_mov_b32 s13, s69
; GLOBALNESS1-NEXT:    s_mov_b32 s14, s68
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS1-NEXT:    s_waitcnt lgkmcnt(0)
; GLOBALNESS1-NEXT:    s_swappc_b64 s[30:31], s[72:73]
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[44:45]
; GLOBALNESS1-NEXT:    s_mov_b64 s[6:7], -1
; GLOBALNESS1-NEXT:    ; implicit-def: $sgpr4_sgpr5
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_9
; GLOBALNESS1-NEXT:  ; %bb.5: ; %NodeBlock
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_cmp_lt_i32 s75, 1
; GLOBALNESS1-NEXT:    s_cbranch_scc1 .LBB1_7
; GLOBALNESS1-NEXT:  ; %bb.6: ; %LeafBlock12
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_cmp_lg_u32 s75, 1
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], -1
; GLOBALNESS1-NEXT:    s_cselect_b64 s[6:7], -1, 0
; GLOBALNESS1-NEXT:    s_cbranch_execz .LBB1_8
; GLOBALNESS1-NEXT:    s_branch .LBB1_9
; GLOBALNESS1-NEXT:  .LBB1_7: ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_mov_b64 s[6:7], 0
; GLOBALNESS1-NEXT:    ; implicit-def: $sgpr4_sgpr5
; GLOBALNESS1-NEXT:  .LBB1_8: ; %LeafBlock
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_cmp_lg_u32 s75, 0
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], 0
; GLOBALNESS1-NEXT:    s_cselect_b64 s[6:7], -1, 0
; GLOBALNESS1-NEXT:  .LBB1_9: ; %Flow25
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[6:7]
; GLOBALNESS1-NEXT:    s_cbranch_vccz .LBB1_24
; GLOBALNESS1-NEXT:  ; %bb.10: ; %baz.exit.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS1-NEXT:    flat_load_dword v0, v[2:3]
; GLOBALNESS1-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GLOBALNESS1-NEXT:    v_cmp_gt_i32_e64 s[60:61], 0, v0
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v0, 0
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v1, 0x3ff00000
; GLOBALNESS1-NEXT:    s_and_saveexec_b64 s[76:77], s[60:61]
; GLOBALNESS1-NEXT:    s_cbranch_execz .LBB1_26
; GLOBALNESS1-NEXT:  ; %bb.11: ; %bb33.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    global_load_dwordx2 v[0:1], v[2:3], off
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[52:53]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_13
; GLOBALNESS1-NEXT:  ; %bb.12: ; %bb39.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS1-NEXT:    global_store_dwordx2 v[2:3], v[42:43], off
; GLOBALNESS1-NEXT:  .LBB1_13: ; %bb44.lr.ph.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v46
; GLOBALNESS1-NEXT:    v_cndmask_b32_e32 v2, 0, v40, vcc
; GLOBALNESS1-NEXT:    s_waitcnt vmcnt(0)
; GLOBALNESS1-NEXT:    v_cmp_nlt_f64_e32 vcc, 0, v[0:1]
; GLOBALNESS1-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GLOBALNESS1-NEXT:    v_cmp_eq_u32_e64 s[62:63], 0, v2
; GLOBALNESS1-NEXT:    v_cmp_ne_u32_e64 s[64:65], 1, v0
; GLOBALNESS1-NEXT:    s_branch .LBB1_16
; GLOBALNESS1-NEXT:  .LBB1_14: ; %Flow16
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_or_b64 exec, exec, s[4:5]
; GLOBALNESS1-NEXT:  .LBB1_15: ; %bb63.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[50:51]
; GLOBALNESS1-NEXT:    s_cbranch_vccz .LBB1_25
; GLOBALNESS1-NEXT:  .LBB1_16: ; %bb44.i
; GLOBALNESS1-NEXT:    ; Parent Loop BB1_4 Depth=1
; GLOBALNESS1-NEXT:    ; => This Inner Loop Header: Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[46:47]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_15
; GLOBALNESS1-NEXT:  ; %bb.17: ; %bb46.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[48:49]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_15
; GLOBALNESS1-NEXT:  ; %bb.18: ; %bb50.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[40:41]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_21
; GLOBALNESS1-NEXT:  ; %bb.19: ; %bb3.i.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[42:43]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_21
; GLOBALNESS1-NEXT:  ; %bb.20: ; %bb6.i.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[64:65]
; GLOBALNESS1-NEXT:  .LBB1_21: ; %spam.exit.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[54:55]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_15
; GLOBALNESS1-NEXT:  ; %bb.22: ; %bb55.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    s_add_u32 s66, s38, 40
; GLOBALNESS1-NEXT:    s_addc_u32 s67, s39, 0
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS1-NEXT:    s_mov_b64 s[8:9], s[66:67]
; GLOBALNESS1-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS1-NEXT:    s_mov_b32 s12, s70
; GLOBALNESS1-NEXT:    s_mov_b32 s13, s69
; GLOBALNESS1-NEXT:    s_mov_b32 s14, s68
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS1-NEXT:    s_swappc_b64 s[30:31], s[72:73]
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[46:47], 0, 0
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS1-NEXT:    s_mov_b64 s[8:9], s[66:67]
; GLOBALNESS1-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS1-NEXT:    s_mov_b32 s12, s70
; GLOBALNESS1-NEXT:    s_mov_b32 s13, s69
; GLOBALNESS1-NEXT:    s_mov_b32 s14, s68
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS1-NEXT:    global_store_dwordx2 v[46:47], v[44:45], off
; GLOBALNESS1-NEXT:    s_swappc_b64 s[30:31], s[72:73]
; GLOBALNESS1-NEXT:    s_and_saveexec_b64 s[4:5], s[62:63]
; GLOBALNESS1-NEXT:    s_cbranch_execz .LBB1_14
; GLOBALNESS1-NEXT:  ; %bb.23: ; %bb62.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS1-NEXT:    global_store_dwordx2 v[46:47], v[42:43], off
; GLOBALNESS1-NEXT:    s_branch .LBB1_14
; GLOBALNESS1-NEXT:  .LBB1_24: ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_mov_b64 s[6:7], -1
; GLOBALNESS1-NEXT:    ; implicit-def: $vgpr0_vgpr1
; GLOBALNESS1-NEXT:    s_branch .LBB1_3
; GLOBALNESS1-NEXT:  .LBB1_25: ; %Flow23
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[0:1], 0, 0
; GLOBALNESS1-NEXT:  .LBB1_26: ; %Flow24
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_or_b64 exec, exec, s[76:77]
; GLOBALNESS1-NEXT:    s_and_saveexec_b64 s[4:5], s[60:61]
; GLOBALNESS1-NEXT:    s_cbranch_execz .LBB1_2
; GLOBALNESS1-NEXT:  ; %bb.27: ; %bb67.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    s_and_b64 vcc, exec, s[56:57]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_1
; GLOBALNESS1-NEXT:  ; %bb.28: ; %bb69.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS1-NEXT:    global_store_dwordx2 v[2:3], v[42:43], off
; GLOBALNESS1-NEXT:    s_branch .LBB1_1
; GLOBALNESS1-NEXT:  .LBB1_29: ; %bb73.i
; GLOBALNESS1-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS1-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS1-NEXT:    global_store_dwordx2 v[2:3], v[42:43], off
; GLOBALNESS1-NEXT:    s_branch .LBB1_2
; GLOBALNESS1-NEXT:  .LBB1_30: ; %loop.exit.guard
; GLOBALNESS1-NEXT:    s_andn2_b64 vcc, exec, s[4:5]
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], -1
; GLOBALNESS1-NEXT:    s_cbranch_vccz .LBB1_32
; GLOBALNESS1-NEXT:  ; %bb.31: ; %bb7.i.i
; GLOBALNESS1-NEXT:    s_add_u32 s8, s38, 40
; GLOBALNESS1-NEXT:    s_addc_u32 s9, s39, 0
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS1-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS1-NEXT:    s_mov_b32 s12, s70
; GLOBALNESS1-NEXT:    s_mov_b32 s13, s69
; GLOBALNESS1-NEXT:    s_mov_b32 s14, s68
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS1-NEXT:    s_getpc_b64 s[6:7]
; GLOBALNESS1-NEXT:    s_add_u32 s6, s6, widget@rel32@lo+4
; GLOBALNESS1-NEXT:    s_addc_u32 s7, s7, widget@rel32@hi+12
; GLOBALNESS1-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], 0
; GLOBALNESS1-NEXT:  .LBB1_32: ; %Flow
; GLOBALNESS1-NEXT:    s_andn2_b64 vcc, exec, s[4:5]
; GLOBALNESS1-NEXT:    s_cbranch_vccnz .LBB1_34
; GLOBALNESS1-NEXT:  ; %bb.33: ; %bb11.i.i
; GLOBALNESS1-NEXT:    s_add_u32 s8, s38, 40
; GLOBALNESS1-NEXT:    s_addc_u32 s9, s39, 0
; GLOBALNESS1-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS1-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS1-NEXT:    s_mov_b32 s12, s70
; GLOBALNESS1-NEXT:    s_mov_b32 s13, s69
; GLOBALNESS1-NEXT:    s_mov_b32 s14, s68
; GLOBALNESS1-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS1-NEXT:    s_getpc_b64 s[6:7]
; GLOBALNESS1-NEXT:    s_add_u32 s6, s6, widget@rel32@lo+4
; GLOBALNESS1-NEXT:    s_addc_u32 s7, s7, widget@rel32@hi+12
; GLOBALNESS1-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GLOBALNESS1-NEXT:  .LBB1_34: ; %UnifiedUnreachableBlock
;
; GLOBALNESS0-LABEL: kernel:
; GLOBALNESS0:       ; %bb.0: ; %bb
; GLOBALNESS0-NEXT:    s_mov_b64 s[38:39], s[6:7]
; GLOBALNESS0-NEXT:    s_load_dwordx4 s[72:75], s[6:7], 0x0
; GLOBALNESS0-NEXT:    s_nop 0
; GLOBALNESS0-NEXT:    s_load_dword s6, s[6:7], 0x14
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v41, v0
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v42, 0
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[0:1], 0, 0
; GLOBALNESS0-NEXT:    global_store_dword v[0:1], v42, off
; GLOBALNESS0-NEXT:    s_waitcnt lgkmcnt(0)
; GLOBALNESS0-NEXT:    global_load_dword v2, v42, s[72:73]
; GLOBALNESS0-NEXT:    s_mov_b64 s[36:37], s[4:5]
; GLOBALNESS0-NEXT:    s_load_dwordx2 s[4:5], s[38:39], 0x18
; GLOBALNESS0-NEXT:    s_load_dword s7, s[38:39], 0x20
; GLOBALNESS0-NEXT:    s_add_u32 flat_scratch_lo, s10, s15
; GLOBALNESS0-NEXT:    s_addc_u32 flat_scratch_hi, s11, 0
; GLOBALNESS0-NEXT:    s_add_u32 s0, s0, s15
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v0, 0
; GLOBALNESS0-NEXT:    s_addc_u32 s1, s1, 0
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v1, 0x40994400
; GLOBALNESS0-NEXT:    s_bitcmp1_b32 s74, 0
; GLOBALNESS0-NEXT:    s_waitcnt lgkmcnt(0)
; GLOBALNESS0-NEXT:    v_cmp_ngt_f64_e32 vcc, s[4:5], v[0:1]
; GLOBALNESS0-NEXT:    v_cmp_ngt_f64_e64 s[4:5], s[4:5], 0
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v1, 0, 1, s[4:5]
; GLOBALNESS0-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v3, 0, 1, s[4:5]
; GLOBALNESS0-NEXT:    s_xor_b64 s[4:5], s[4:5], -1
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GLOBALNESS0-NEXT:    s_bitcmp1_b32 s6, 0
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[40:41], 1, v0
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GLOBALNESS0-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GLOBALNESS0-NEXT:    s_xor_b64 s[4:5], s[4:5], -1
; GLOBALNESS0-NEXT:    s_bitcmp1_b32 s7, 0
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[46:47], 1, v0
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GLOBALNESS0-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GLOBALNESS0-NEXT:    s_getpc_b64 s[6:7]
; GLOBALNESS0-NEXT:    s_add_u32 s6, s6, wobble@gotpcrel32@lo+4
; GLOBALNESS0-NEXT:    s_addc_u32 s7, s7, wobble@gotpcrel32@hi+12
; GLOBALNESS0-NEXT:    s_xor_b64 s[4:5], s[4:5], -1
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[48:49], 1, v0
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GLOBALNESS0-NEXT:    s_load_dwordx2 s[72:73], s[6:7], 0x0
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[50:51], 1, v0
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[42:43], 1, v1
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[44:45], 1, v3
; GLOBALNESS0-NEXT:    s_mov_b32 s66, s14
; GLOBALNESS0-NEXT:    s_mov_b32 s67, s13
; GLOBALNESS0-NEXT:    s_mov_b32 s68, s12
; GLOBALNESS0-NEXT:    s_mov_b64 s[34:35], s[8:9]
; GLOBALNESS0-NEXT:    s_mov_b32 s32, 0
; GLOBALNESS0-NEXT:    ; implicit-def: $vgpr44_vgpr45
; GLOBALNESS0-NEXT:    s_waitcnt vmcnt(0)
; GLOBALNESS0-NEXT:    v_cmp_gt_i32_e32 vcc, 0, v2
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GLOBALNESS0-NEXT:    v_cmp_gt_i32_e32 vcc, 1, v2
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v1, 0, 1, vcc
; GLOBALNESS0-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v2
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v3, 0, 1, vcc
; GLOBALNESS0-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v2
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v2, 0, 1, vcc
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[52:53], 1, v0
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[54:55], 1, v1
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[56:57], 1, v3
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[58:59], 1, v2
; GLOBALNESS0-NEXT:    s_branch .LBB1_4
; GLOBALNESS0-NEXT:  .LBB1_1: ; %bb70.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[58:59]
; GLOBALNESS0-NEXT:    s_cbranch_vccz .LBB1_29
; GLOBALNESS0-NEXT:  .LBB1_2: ; %Flow15
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_or_b64 exec, exec, s[4:5]
; GLOBALNESS0-NEXT:    s_mov_b64 s[6:7], 0
; GLOBALNESS0-NEXT:    ; implicit-def: $sgpr4_sgpr5
; GLOBALNESS0-NEXT:  .LBB1_3: ; %Flow28
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[6:7]
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[44:45], v[0:1], v[0:1] op_sel:[0,1]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_30
; GLOBALNESS0-NEXT:  .LBB1_4: ; %bb5
; GLOBALNESS0-NEXT:    ; =>This Loop Header: Depth=1
; GLOBALNESS0-NEXT:    ; Child Loop BB1_16 Depth 2
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v0, 0x80
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v1, 0
; GLOBALNESS0-NEXT:    flat_load_dword v40, v[0:1]
; GLOBALNESS0-NEXT:    s_add_u32 s8, s38, 40
; GLOBALNESS0-NEXT:    buffer_store_dword v42, off, s[0:3], 0
; GLOBALNESS0-NEXT:    flat_load_dword v46, v[0:1]
; GLOBALNESS0-NEXT:    s_addc_u32 s9, s39, 0
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS0-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS0-NEXT:    s_mov_b32 s12, s68
; GLOBALNESS0-NEXT:    s_mov_b32 s13, s67
; GLOBALNESS0-NEXT:    s_mov_b32 s14, s66
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS0-NEXT:    s_waitcnt lgkmcnt(0)
; GLOBALNESS0-NEXT:    s_swappc_b64 s[30:31], s[72:73]
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[44:45]
; GLOBALNESS0-NEXT:    s_mov_b64 s[6:7], -1
; GLOBALNESS0-NEXT:    ; implicit-def: $sgpr4_sgpr5
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_9
; GLOBALNESS0-NEXT:  ; %bb.5: ; %NodeBlock
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_cmp_lt_i32 s75, 1
; GLOBALNESS0-NEXT:    s_cbranch_scc1 .LBB1_7
; GLOBALNESS0-NEXT:  ; %bb.6: ; %LeafBlock12
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_cmp_lg_u32 s75, 1
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], -1
; GLOBALNESS0-NEXT:    s_cselect_b64 s[6:7], -1, 0
; GLOBALNESS0-NEXT:    s_cbranch_execz .LBB1_8
; GLOBALNESS0-NEXT:    s_branch .LBB1_9
; GLOBALNESS0-NEXT:  .LBB1_7: ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_mov_b64 s[6:7], 0
; GLOBALNESS0-NEXT:    ; implicit-def: $sgpr4_sgpr5
; GLOBALNESS0-NEXT:  .LBB1_8: ; %LeafBlock
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_cmp_lg_u32 s75, 0
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], 0
; GLOBALNESS0-NEXT:    s_cselect_b64 s[6:7], -1, 0
; GLOBALNESS0-NEXT:  .LBB1_9: ; %Flow25
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[6:7]
; GLOBALNESS0-NEXT:    s_cbranch_vccz .LBB1_24
; GLOBALNESS0-NEXT:  ; %bb.10: ; %baz.exit.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS0-NEXT:    flat_load_dword v0, v[2:3]
; GLOBALNESS0-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GLOBALNESS0-NEXT:    v_cmp_gt_i32_e64 s[60:61], 0, v0
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v0, 0
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v1, 0x3ff00000
; GLOBALNESS0-NEXT:    s_and_saveexec_b64 s[76:77], s[60:61]
; GLOBALNESS0-NEXT:    s_cbranch_execz .LBB1_26
; GLOBALNESS0-NEXT:  ; %bb.11: ; %bb33.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    global_load_dwordx2 v[0:1], v[2:3], off
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[52:53]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_13
; GLOBALNESS0-NEXT:  ; %bb.12: ; %bb39.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS0-NEXT:    global_store_dwordx2 v[2:3], v[42:43], off
; GLOBALNESS0-NEXT:  .LBB1_13: ; %bb44.lr.ph.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v46
; GLOBALNESS0-NEXT:    v_cndmask_b32_e32 v2, 0, v40, vcc
; GLOBALNESS0-NEXT:    s_waitcnt vmcnt(0)
; GLOBALNESS0-NEXT:    v_cmp_nlt_f64_e32 vcc, 0, v[0:1]
; GLOBALNESS0-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GLOBALNESS0-NEXT:    v_cmp_eq_u32_e64 s[62:63], 0, v2
; GLOBALNESS0-NEXT:    v_cmp_ne_u32_e64 s[64:65], 1, v0
; GLOBALNESS0-NEXT:    s_branch .LBB1_16
; GLOBALNESS0-NEXT:  .LBB1_14: ; %Flow16
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_or_b64 exec, exec, s[4:5]
; GLOBALNESS0-NEXT:  .LBB1_15: ; %bb63.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[50:51]
; GLOBALNESS0-NEXT:    s_cbranch_vccz .LBB1_25
; GLOBALNESS0-NEXT:  .LBB1_16: ; %bb44.i
; GLOBALNESS0-NEXT:    ; Parent Loop BB1_4 Depth=1
; GLOBALNESS0-NEXT:    ; => This Inner Loop Header: Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[46:47]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_15
; GLOBALNESS0-NEXT:  ; %bb.17: ; %bb46.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[48:49]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_15
; GLOBALNESS0-NEXT:  ; %bb.18: ; %bb50.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[40:41]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_21
; GLOBALNESS0-NEXT:  ; %bb.19: ; %bb3.i.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[42:43]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_21
; GLOBALNESS0-NEXT:  ; %bb.20: ; %bb6.i.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[64:65]
; GLOBALNESS0-NEXT:  .LBB1_21: ; %spam.exit.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[54:55]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_15
; GLOBALNESS0-NEXT:  ; %bb.22: ; %bb55.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    s_add_u32 s70, s38, 40
; GLOBALNESS0-NEXT:    s_addc_u32 s71, s39, 0
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS0-NEXT:    s_mov_b64 s[8:9], s[70:71]
; GLOBALNESS0-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS0-NEXT:    s_mov_b32 s12, s68
; GLOBALNESS0-NEXT:    s_mov_b32 s13, s67
; GLOBALNESS0-NEXT:    s_mov_b32 s14, s66
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS0-NEXT:    s_swappc_b64 s[30:31], s[72:73]
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[46:47], 0, 0
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS0-NEXT:    s_mov_b64 s[8:9], s[70:71]
; GLOBALNESS0-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS0-NEXT:    s_mov_b32 s12, s68
; GLOBALNESS0-NEXT:    s_mov_b32 s13, s67
; GLOBALNESS0-NEXT:    s_mov_b32 s14, s66
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS0-NEXT:    global_store_dwordx2 v[46:47], v[44:45], off
; GLOBALNESS0-NEXT:    s_swappc_b64 s[30:31], s[72:73]
; GLOBALNESS0-NEXT:    s_and_saveexec_b64 s[4:5], s[62:63]
; GLOBALNESS0-NEXT:    s_cbranch_execz .LBB1_14
; GLOBALNESS0-NEXT:  ; %bb.23: ; %bb62.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_16 Depth=2
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS0-NEXT:    global_store_dwordx2 v[46:47], v[42:43], off
; GLOBALNESS0-NEXT:    s_branch .LBB1_14
; GLOBALNESS0-NEXT:  .LBB1_24: ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_mov_b64 s[6:7], -1
; GLOBALNESS0-NEXT:    ; implicit-def: $vgpr0_vgpr1
; GLOBALNESS0-NEXT:    s_branch .LBB1_3
; GLOBALNESS0-NEXT:  .LBB1_25: ; %Flow23
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[0:1], 0, 0
; GLOBALNESS0-NEXT:  .LBB1_26: ; %Flow24
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_or_b64 exec, exec, s[76:77]
; GLOBALNESS0-NEXT:    s_and_saveexec_b64 s[4:5], s[60:61]
; GLOBALNESS0-NEXT:    s_cbranch_execz .LBB1_2
; GLOBALNESS0-NEXT:  ; %bb.27: ; %bb67.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    s_and_b64 vcc, exec, s[56:57]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_1
; GLOBALNESS0-NEXT:  ; %bb.28: ; %bb69.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS0-NEXT:    global_store_dwordx2 v[2:3], v[42:43], off
; GLOBALNESS0-NEXT:    s_branch .LBB1_1
; GLOBALNESS0-NEXT:  .LBB1_29: ; %bb73.i
; GLOBALNESS0-NEXT:    ; in Loop: Header=BB1_4 Depth=1
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v43, v42
; GLOBALNESS0-NEXT:    v_pk_mov_b32 v[2:3], 0, 0
; GLOBALNESS0-NEXT:    global_store_dwordx2 v[2:3], v[42:43], off
; GLOBALNESS0-NEXT:    s_branch .LBB1_2
; GLOBALNESS0-NEXT:  .LBB1_30: ; %loop.exit.guard
; GLOBALNESS0-NEXT:    s_andn2_b64 vcc, exec, s[4:5]
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], -1
; GLOBALNESS0-NEXT:    s_cbranch_vccz .LBB1_32
; GLOBALNESS0-NEXT:  ; %bb.31: ; %bb7.i.i
; GLOBALNESS0-NEXT:    s_add_u32 s8, s38, 40
; GLOBALNESS0-NEXT:    s_addc_u32 s9, s39, 0
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS0-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS0-NEXT:    s_mov_b32 s12, s68
; GLOBALNESS0-NEXT:    s_mov_b32 s13, s67
; GLOBALNESS0-NEXT:    s_mov_b32 s14, s66
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS0-NEXT:    s_getpc_b64 s[6:7]
; GLOBALNESS0-NEXT:    s_add_u32 s6, s6, widget@rel32@lo+4
; GLOBALNESS0-NEXT:    s_addc_u32 s7, s7, widget@rel32@hi+12
; GLOBALNESS0-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], 0
; GLOBALNESS0-NEXT:  .LBB1_32: ; %Flow
; GLOBALNESS0-NEXT:    s_andn2_b64 vcc, exec, s[4:5]
; GLOBALNESS0-NEXT:    s_cbranch_vccnz .LBB1_34
; GLOBALNESS0-NEXT:  ; %bb.33: ; %bb11.i.i
; GLOBALNESS0-NEXT:    s_add_u32 s8, s38, 40
; GLOBALNESS0-NEXT:    s_addc_u32 s9, s39, 0
; GLOBALNESS0-NEXT:    s_mov_b64 s[4:5], s[36:37]
; GLOBALNESS0-NEXT:    s_mov_b64 s[10:11], s[34:35]
; GLOBALNESS0-NEXT:    s_mov_b32 s12, s68
; GLOBALNESS0-NEXT:    s_mov_b32 s13, s67
; GLOBALNESS0-NEXT:    s_mov_b32 s14, s66
; GLOBALNESS0-NEXT:    v_mov_b32_e32 v31, v41
; GLOBALNESS0-NEXT:    s_getpc_b64 s[6:7]
; GLOBALNESS0-NEXT:    s_add_u32 s6, s6, widget@rel32@lo+4
; GLOBALNESS0-NEXT:    s_addc_u32 s7, s7, widget@rel32@hi+12
; GLOBALNESS0-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GLOBALNESS0-NEXT:  .LBB1_34: ; %UnifiedUnreachableBlock
bb:
  store i32 0, ptr addrspace(1) null, align 4
  %tmp4 = load i32, ptr addrspace(1) %arg1.global, align 4
  br label %bb5

bb5:                                              ; preds = %bb5.backedge, %bb
  %tmp4.i.sroa.0.0 = phi <9 x double> [ undef, %bb ], [ %tmp4.i.sroa.0.1, %bb5.backedge ]
  %tmp14.1.i = load i32, ptr inttoptr (i64 128 to ptr), align 128
  store i32 0, ptr addrspace(5) null, align 4
  %tmp14.2.i = load i32, ptr inttoptr (i64 128 to ptr), align 128
  %tmp15.2.i = icmp eq i32 %tmp14.2.i, 0
  %spec.select.2.i = select i1 %tmp15.2.i, i32 0, i32 %tmp14.1.i
  tail call void @wobble()
  br i1 %tmp3.i.i, label %bb4.i.i, label %baz.exit.i

bb4.i.i:                                          ; preds = %bb5
  switch i32 %tmp5.i.i, label %baz.exit.i [
    i32 0, label %bb7.i.i
    i32 1, label %bb11.i.i
  ]

bb7.i.i:                                          ; preds = %bb4.i.i
  tail call fastcc void @widget()
  unreachable

bb11.i.i:                                         ; preds = %bb4.i.i
  tail call fastcc void @widget()
  unreachable

baz.exit.i:                                       ; preds = %bb4.i.i, %bb5
  %tmp26.i = load i32, ptr null, align 4
  %tmp27.i4 = load double, ptr addrspace(1) null, align 8
  %tmp31.i = icmp slt i32 %tmp26.i, 0
  br i1 %tmp31.i, label %bb33.i, label %bb64.i

bb33.i:                                           ; preds = %baz.exit.i
  %tmp38.i = icmp slt i32 %tmp4, 0
  br i1 %tmp38.i, label %bb39.i, label %bb44.lr.ph.i

bb39.i:                                           ; preds = %bb33.i
  store double 0.000000e+00, ptr addrspace(1) null, align 8
  br label %bb44.lr.ph.i

bb44.lr.ph.i:                                     ; preds = %bb39.i, %bb33.i
  br label %bb44.i

bb44.i:                                           ; preds = %bb63.i, %bb44.lr.ph.i
  br i1 %tmp3.i.i, label %bb63.i, label %bb46.i

bb46.i:                                           ; preds = %bb44.i
  br i1 %tmp438.i, label %bb63.i, label %bb50.i

bb50.i:                                           ; preds = %bb46.i
  switch i32 0, label %spam.exit.i [
    i32 0, label %bb1.i.i
  ]

bb1.i.i:                                          ; preds = %bb50.i
  %tmp2.i.i = fcmp ogt double %tmp27.i, 1.617000e+03
  br i1 %tmp2.i.i, label %spam.exit.i, label %bb3.i.i

bb3.i.i:                                          ; preds = %bb1.i.i
  %tmp4.i.i = fcmp ogt double %tmp27.i, 0.000000e+00
  br i1 %tmp4.i.i, label %spam.exit.i, label %bb6.i.i

bb6.i.i:                                          ; preds = %bb3.i.i
  %tmp7.i.i = fcmp ogt double %tmp27.i4, 0.000000e+00
  br i1 %tmp7.i.i, label %spam.exit.i, label %bb8.i.i

bb8.i.i:                                          ; preds = %bb6.i.i
  tail call void null()
  br label %spam.exit.i

spam.exit.i:                                      ; preds = %bb8.i.i, %bb6.i.i, %bb3.i.i, %bb1.i.i, %bb50.i
  %tmp22.i = icmp sgt i32 %tmp4, 0
  br i1 %tmp22.i, label %bb63.i, label %bb55.i

bb55.i:                                           ; preds = %spam.exit.i
  tail call void @wobble()
  %tmp0 = extractelement <9 x double> %tmp4.i.sroa.0.0, i32 0
  store double %tmp0, ptr addrspace(1) null, align 8
  tail call void @wobble()
  %tmp61.i = icmp eq i32 %spec.select.2.i, 0
  br i1 %tmp61.i, label %bb62.i, label %bb63.i

bb62.i:                                           ; preds = %bb55.i
  store double 0.000000e+00, ptr addrspace(1) null, align 8
  br label %bb63.i

bb63.i:                                           ; preds = %bb62.i, %bb55.i, %spam.exit.i, %bb46.i, %bb44.i
  br i1 %tmp48.i, label %bb44.i, label %bb64.i

bb64.i:                                           ; preds = %bb63.i, %baz.exit.i
  %tmp4.i.sroa.0.1 = phi <9 x double> [ <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %baz.exit.i ], [ zeroinitializer, %bb63.i ]
  br i1 %tmp31.i, label %bb67.i, label %bb5.backedge

bb5.backedge:                                     ; preds = %bb73.i, %bb70.i, %bb64.i
  br label %bb5

bb67.i:                                           ; preds = %bb64.i
  %tmp68.i = icmp eq i32 %tmp4, 1
  br i1 %tmp68.i, label %bb69.i, label %bb70.i

bb69.i:                                           ; preds = %bb67.i
  store double 0.000000e+00, ptr addrspace(1) null, align 8
  br label %bb70.i

bb70.i:                                           ; preds = %bb69.i, %bb67.i
  %tmp3.i.i2 = icmp eq i32 %tmp4, 0
  br i1 %tmp3.i.i2, label %bb73.i, label %bb5.backedge

bb73.i:                                           ; preds = %bb70.i
  store double 0.000000e+00, ptr addrspace(1) null, align 8
  br label %bb5.backedge
}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdgpu_code_object_version", i32 500}
