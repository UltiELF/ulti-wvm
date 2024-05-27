; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amdhsa -verify-machineinstrs -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck -check-prefix=GCN %s
; RUN: opt -S -si-annotate-control-flow -mtriple=amdgcn-amdhsa -verify-machineinstrs -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck -check-prefix=SI-OPT %s

define hidden void @widget() {
; GCN-LABEL: widget:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s16, s33
; GCN-NEXT:    s_mov_b32 s33, s32
; GCN-NEXT:    s_or_saveexec_b64 s[18:19], -1
; GCN-NEXT:    buffer_store_dword v41, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[18:19]
; GCN-NEXT:    v_writelane_b32 v41, s16, 16
; GCN-NEXT:    s_addk_i32 s32, 0x400
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], s33 ; 4-byte Folded Spill
; GCN-NEXT:    v_writelane_b32 v41, s30, 0
; GCN-NEXT:    v_writelane_b32 v41, s31, 1
; GCN-NEXT:    v_writelane_b32 v41, s34, 2
; GCN-NEXT:    v_writelane_b32 v41, s35, 3
; GCN-NEXT:    v_writelane_b32 v41, s36, 4
; GCN-NEXT:    v_writelane_b32 v41, s37, 5
; GCN-NEXT:    v_writelane_b32 v41, s38, 6
; GCN-NEXT:    v_writelane_b32 v41, s39, 7
; GCN-NEXT:    v_writelane_b32 v41, s40, 8
; GCN-NEXT:    v_writelane_b32 v41, s41, 9
; GCN-NEXT:    v_writelane_b32 v41, s42, 10
; GCN-NEXT:    v_writelane_b32 v41, s43, 11
; GCN-NEXT:    v_writelane_b32 v41, s44, 12
; GCN-NEXT:    v_writelane_b32 v41, s45, 13
; GCN-NEXT:    v_writelane_b32 v41, s46, 14
; GCN-NEXT:    v_writelane_b32 v41, s47, 15
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    flat_load_dword v0, v[0:1]
; GCN-NEXT:    s_mov_b64 s[20:21], -1
; GCN-NEXT:    s_mov_b64 s[16:17], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_gt_i32_e32 vcc, 21, v0
; GCN-NEXT:    s_mov_b64 s[46:47], 0
; GCN-NEXT:    s_mov_b64 s[18:19], 0
; GCN-NEXT:    s_cbranch_vccz .LBB0_9
; GCN-NEXT:  ; %bb.1: ; %Flow
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[20:21]
; GCN-NEXT:    s_cbranch_vccz .LBB0_10
; GCN-NEXT:  .LBB0_2: ; %Flow1
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[18:19]
; GCN-NEXT:    s_cbranch_vccnz .LBB0_4
; GCN-NEXT:  .LBB0_3: ; %bb9
; GCN-NEXT:    s_getpc_b64 s[16:17]
; GCN-NEXT:    s_add_u32 s16, s16, wibble@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s17, s17, wibble@rel32@hi+12
; GCN-NEXT:    s_mov_b64 s[34:35], s[4:5]
; GCN-NEXT:    s_mov_b64 s[36:37], s[6:7]
; GCN-NEXT:    s_mov_b64 s[38:39], s[8:9]
; GCN-NEXT:    s_mov_b64 s[40:41], s[10:11]
; GCN-NEXT:    s_mov_b32 s42, s12
; GCN-NEXT:    s_mov_b32 s43, s13
; GCN-NEXT:    s_mov_b32 s44, s14
; GCN-NEXT:    s_mov_b32 s45, s15
; GCN-NEXT:    v_mov_b32_e32 v40, v31
; GCN-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; GCN-NEXT:    v_mov_b32_e32 v31, v40
; GCN-NEXT:    s_mov_b32 s12, s42
; GCN-NEXT:    s_mov_b32 s13, s43
; GCN-NEXT:    s_mov_b32 s14, s44
; GCN-NEXT:    s_mov_b32 s15, s45
; GCN-NEXT:    s_mov_b64 s[4:5], s[34:35]
; GCN-NEXT:    s_mov_b64 s[8:9], s[38:39]
; GCN-NEXT:    s_mov_b64 s[10:11], s[40:41]
; GCN-NEXT:    s_mov_b64 s[6:7], s[36:37]
; GCN-NEXT:    v_cmp_nlt_f32_e32 vcc, 0, v0
; GCN-NEXT:    s_mov_b64 s[16:17], 0
; GCN-NEXT:    s_andn2_b64 s[18:19], s[46:47], exec
; GCN-NEXT:    s_and_b64 s[20:21], vcc, exec
; GCN-NEXT:    s_or_b64 s[46:47], s[18:19], s[20:21]
; GCN-NEXT:  .LBB0_4: ; %Flow2
; GCN-NEXT:    s_and_saveexec_b64 s[18:19], s[46:47]
; GCN-NEXT:    s_xor_b64 s[18:19], exec, s[18:19]
; GCN-NEXT:    s_cbranch_execz .LBB0_6
; GCN-NEXT:  ; %bb.5: ; %bb12
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    flat_store_dword v[0:1], v2
; GCN-NEXT:  .LBB0_6: ; %Flow3
; GCN-NEXT:    s_or_b64 exec, exec, s[18:19]
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[16:17]
; GCN-NEXT:    s_cbranch_vccnz .LBB0_8
; GCN-NEXT:  ; %bb.7: ; %bb7
; GCN-NEXT:    s_getpc_b64 s[16:17]
; GCN-NEXT:    s_add_u32 s16, s16, wibble@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s17, s17, wibble@rel32@hi+12
; GCN-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; GCN-NEXT:  .LBB0_8: ; %UnifiedReturnBlock
; GCN-NEXT:    v_readlane_b32 s47, v41, 15
; GCN-NEXT:    v_readlane_b32 s46, v41, 14
; GCN-NEXT:    v_readlane_b32 s45, v41, 13
; GCN-NEXT:    v_readlane_b32 s44, v41, 12
; GCN-NEXT:    v_readlane_b32 s43, v41, 11
; GCN-NEXT:    v_readlane_b32 s42, v41, 10
; GCN-NEXT:    v_readlane_b32 s41, v41, 9
; GCN-NEXT:    v_readlane_b32 s40, v41, 8
; GCN-NEXT:    v_readlane_b32 s39, v41, 7
; GCN-NEXT:    v_readlane_b32 s38, v41, 6
; GCN-NEXT:    v_readlane_b32 s37, v41, 5
; GCN-NEXT:    v_readlane_b32 s36, v41, 4
; GCN-NEXT:    v_readlane_b32 s35, v41, 3
; GCN-NEXT:    v_readlane_b32 s34, v41, 2
; GCN-NEXT:    v_readlane_b32 s31, v41, 1
; GCN-NEXT:    v_readlane_b32 s30, v41, 0
; GCN-NEXT:    buffer_load_dword v40, off, s[0:3], s33 ; 4-byte Folded Reload
; GCN-NEXT:    v_readlane_b32 s4, v41, 16
; GCN-NEXT:    s_or_saveexec_b64 s[6:7], -1
; GCN-NEXT:    buffer_load_dword v41, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[6:7]
; GCN-NEXT:    s_addk_i32 s32, 0xfc00
; GCN-NEXT:    s_mov_b32 s33, s4
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
; GCN-NEXT:  .LBB0_9: ; %bb2
; GCN-NEXT:    v_cmp_eq_u32_e64 s[46:47], 21, v0
; GCN-NEXT:    v_cmp_ne_u32_e64 s[18:19], 21, v0
; GCN-NEXT:    s_mov_b64 vcc, exec
; GCN-NEXT:    s_cbranch_execnz .LBB0_2
; GCN-NEXT:  .LBB0_10: ; %bb4
; GCN-NEXT:    s_mov_b64 s[16:17], -1
; GCN-NEXT:    v_cmp_ne_u32_e64 s[18:19], 9, v0
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[18:19]
; GCN-NEXT:    s_cbranch_vccz .LBB0_3
; GCN-NEXT:    s_branch .LBB0_4
; SI-OPT-LABEL: @widget(
; SI-OPT-NEXT:  bb:
; SI-OPT-NEXT:    [[TMP:%.*]] = load i32, ptr addrspace(1) null, align 16
; SI-OPT-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[TMP]], 21
; SI-OPT-NEXT:    br i1 [[TMP1]], label [[BB4:%.*]], label [[BB2:%.*]]
; SI-OPT:       bb2:
; SI-OPT-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[TMP]], 21
; SI-OPT-NEXT:    br i1 [[TMP3]], label [[BB12:%.*]], label [[BB9:%.*]]
; SI-OPT:       bb4:
; SI-OPT-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP]], 9
; SI-OPT-NEXT:    br i1 [[TMP5]], label [[BB7:%.*]], label [[BB9]]
; SI-OPT:       bb6:
; SI-OPT-NEXT:    ret void
; SI-OPT:       bb7:
; SI-OPT-NEXT:    [[TMP8:%.*]] = call float @wibble()
; SI-OPT-NEXT:    ret void
; SI-OPT:       bb9:
; SI-OPT-NEXT:    [[TMP10:%.*]] = call float @wibble()
; SI-OPT-NEXT:    [[TMP11:%.*]] = fcmp nsz ogt float [[TMP10]], 0.000000e+00
; SI-OPT-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP11]])
; SI-OPT-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; SI-OPT-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; SI-OPT-NEXT:    br i1 [[TMP1]], label [[BB6:%.*]], label [[BB9_BB12_CRIT_EDGE:%.*]]
; SI-OPT:       bb9.bb12_crit_edge:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; SI-OPT-NEXT:    br label [[BB12]]
; SI-OPT:       bb12:
; SI-OPT-NEXT:    store float 0.000000e+00, ptr addrspace(1) null, align 8
; SI-OPT-NEXT:    ret void
bb:
  %tmp = load i32, ptr addrspace(1) null, align 16
  %tmp1 = icmp slt i32 %tmp, 21
  br i1 %tmp1, label %bb4, label %bb2

bb2:                                              ; preds = %bb
  %tmp3 = icmp eq i32 %tmp, 21
  br i1 %tmp3, label %bb12, label %bb9

bb4:                                              ; preds = %bb
  %tmp5 = icmp eq i32 %tmp, 9
  br i1 %tmp5, label %bb7, label %bb9

bb6:                                              ; preds = %bb9
  ret void

bb7:                                              ; preds = %bb4
  %tmp8 = call float @wibble()
  ret void

bb9:                                              ; preds = %bb4, %bb2
  %tmp10 = call float @wibble()
  %tmp11 = fcmp nsz ogt float %tmp10, 0.000000e+00
  br i1 %tmp11, label %bb6, label %bb12

bb12:                                             ; preds = %bb9, %bb2
  store float 0.000000e+00, ptr addrspace(1) null, align 8
  ret void
}

declare hidden float @wibble() local_unnamed_addr


define hidden void @blam() {
; SI-OPT-LABEL: @blam(
; SI-OPT-NEXT:  bb:
; SI-OPT-NEXT:    [[TMP:%.*]] = load float, ptr null, align 16
; SI-OPT-NEXT:    br label [[BB2:%.*]]
; SI-OPT:       bb1:
; SI-OPT-NEXT:    br label [[BB2]]
; SI-OPT:       bb2:
; SI-OPT-NEXT:    [[TID:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; SI-OPT-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr addrspace(1) null, i32 [[TID]]
; SI-OPT-NEXT:    [[TMP3:%.*]] = load i32, ptr addrspace(1) [[GEP]], align 16
; SI-OPT-NEXT:    store float 0.000000e+00, ptr addrspace(5) null, align 8
; SI-OPT-NEXT:    br label [[BB4:%.*]]
; SI-OPT:       bb4:
; SI-OPT-NEXT:    [[TMP5:%.*]] = icmp slt i32 [[TMP3]], 3
; SI-OPT-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP5]])
; SI-OPT-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; SI-OPT-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; SI-OPT-NEXT:    br i1 [[TMP1]], label [[BB8:%.*]], label [[BB6:%.*]]
; SI-OPT:       bb6:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; SI-OPT-NEXT:    [[TMP7:%.*]] = icmp eq i32 [[TMP3]], 3
; SI-OPT-NEXT:    br i1 [[TMP7]], label [[BB11:%.*]], label [[BB1:%.*]]
; SI-OPT:       bb8:
; SI-OPT-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP3]], 1
; SI-OPT-NEXT:    [[TMP3:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP9]])
; SI-OPT-NEXT:    [[TMP4:%.*]] = extractvalue { i1, i64 } [[TMP3]], 0
; SI-OPT-NEXT:    [[TMP5:%.*]] = extractvalue { i1, i64 } [[TMP3]], 1
; SI-OPT-NEXT:    br i1 [[TMP4]], label [[BB10:%.*]], label [[BB8_BB1_CRIT_EDGE:%.*]]
; SI-OPT:       bb8.bb1_crit_edge:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP5]])
; SI-OPT-NEXT:    br label [[BB1]]
; SI-OPT:       bb10:
; SI-OPT-NEXT:    store float 0x7FF8000000000000, ptr addrspace(5) null, align 16
; SI-OPT-NEXT:    br label [[BB18:%.*]]
; SI-OPT:       bb11:
; SI-OPT-NEXT:    [[TMP12:%.*]] = call float @spam()
; SI-OPT-NEXT:    [[TMP13:%.*]] = fcmp nsz oeq float [[TMP12]], 0.000000e+00
; SI-OPT-NEXT:    [[TMP6:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP13]])
; SI-OPT-NEXT:    [[TMP7:%.*]] = extractvalue { i1, i64 } [[TMP6]], 0
; SI-OPT-NEXT:    [[TMP8:%.*]] = extractvalue { i1, i64 } [[TMP6]], 1
; SI-OPT-NEXT:    br i1 [[TMP7]], label [[BB2]], label [[BB14:%.*]]
; SI-OPT:       bb14:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP8]])
; SI-OPT-NEXT:    [[TMP15:%.*]] = fcmp nsz oeq float [[TMP]], 0.000000e+00
; SI-OPT-NEXT:    [[TMP9:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP15]])
; SI-OPT-NEXT:    [[TMP10:%.*]] = extractvalue { i1, i64 } [[TMP9]], 0
; SI-OPT-NEXT:    [[TMP11:%.*]] = extractvalue { i1, i64 } [[TMP9]], 1
; SI-OPT-NEXT:    br i1 [[TMP10]], label [[BB17:%.*]], label [[BB16:%.*]]
; SI-OPT:       bb16:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP11]])
; SI-OPT-NEXT:    store float 0x7FF8000000000000, ptr addrspace(5) null, align 16
; SI-OPT-NEXT:    br label [[BB17]]
; SI-OPT:       bb17:
; SI-OPT-NEXT:    store float [[TMP]], ptr addrspace(5) null, align 16
; SI-OPT-NEXT:    br label [[BB18]]
; SI-OPT:       bb18:
; SI-OPT-NEXT:    store float 0x7FF8000000000000, ptr addrspace(5) null, align 4
; SI-OPT-NEXT:    br label [[BB2]]
;
; GCN-LABEL: blam:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s16, s33
; GCN-NEXT:    s_mov_b32 s33, s32
; GCN-NEXT:    s_or_saveexec_b64 s[18:19], -1
; GCN-NEXT:    buffer_store_dword v45, off, s[0:3], s33 offset:20 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[18:19]
; GCN-NEXT:    v_writelane_b32 v45, s16, 28
; GCN-NEXT:    s_addk_i32 s32, 0x800
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], s33 offset:16 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v41, off, s[0:3], s33 offset:12 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v42, off, s[0:3], s33 offset:8 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v43, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v44, off, s[0:3], s33 ; 4-byte Folded Spill
; GCN-NEXT:    v_writelane_b32 v45, s30, 0
; GCN-NEXT:    v_writelane_b32 v45, s31, 1
; GCN-NEXT:    v_writelane_b32 v45, s34, 2
; GCN-NEXT:    v_writelane_b32 v45, s35, 3
; GCN-NEXT:    v_writelane_b32 v45, s36, 4
; GCN-NEXT:    v_writelane_b32 v45, s37, 5
; GCN-NEXT:    v_writelane_b32 v45, s38, 6
; GCN-NEXT:    v_writelane_b32 v45, s39, 7
; GCN-NEXT:    v_writelane_b32 v45, s40, 8
; GCN-NEXT:    v_writelane_b32 v45, s41, 9
; GCN-NEXT:    v_writelane_b32 v45, s42, 10
; GCN-NEXT:    v_writelane_b32 v45, s43, 11
; GCN-NEXT:    v_writelane_b32 v45, s44, 12
; GCN-NEXT:    v_writelane_b32 v45, s45, 13
; GCN-NEXT:    v_writelane_b32 v45, s46, 14
; GCN-NEXT:    v_writelane_b32 v45, s47, 15
; GCN-NEXT:    v_writelane_b32 v45, s48, 16
; GCN-NEXT:    v_writelane_b32 v45, s49, 17
; GCN-NEXT:    v_writelane_b32 v45, s50, 18
; GCN-NEXT:    v_writelane_b32 v45, s51, 19
; GCN-NEXT:    v_writelane_b32 v45, s52, 20
; GCN-NEXT:    v_writelane_b32 v45, s53, 21
; GCN-NEXT:    v_writelane_b32 v45, s54, 22
; GCN-NEXT:    v_writelane_b32 v45, s55, 23
; GCN-NEXT:    v_writelane_b32 v45, s56, 24
; GCN-NEXT:    v_writelane_b32 v45, s57, 25
; GCN-NEXT:    v_writelane_b32 v45, s58, 26
; GCN-NEXT:    v_writelane_b32 v45, s59, 27
; GCN-NEXT:    s_mov_b64 s[34:35], s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v40, v31
; GCN-NEXT:    s_mov_b32 s46, s15
; GCN-NEXT:    s_mov_b32 s47, s14
; GCN-NEXT:    s_mov_b32 s48, s13
; GCN-NEXT:    s_mov_b32 s49, s12
; GCN-NEXT:    s_mov_b64 s[36:37], s[10:11]
; GCN-NEXT:    s_mov_b64 s[38:39], s[8:9]
; GCN-NEXT:    s_mov_b64 s[40:41], s[4:5]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    v_and_b32_e32 v2, 0x3ff, v40
; GCN-NEXT:    v_mov_b32_e32 v42, 0
; GCN-NEXT:    flat_load_dword v43, v[0:1]
; GCN-NEXT:    s_mov_b64 s[50:51], 0
; GCN-NEXT:    s_getpc_b64 s[52:53]
; GCN-NEXT:    s_add_u32 s52, s52, spam@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s53, s53, spam@rel32@hi+12
; GCN-NEXT:    v_lshlrev_b32_e32 v41, 2, v2
; GCN-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_cmp_eq_f32_e64 s[54:55], 0, v43
; GCN-NEXT:    v_cmp_neq_f32_e64 s[42:43], 0, v43
; GCN-NEXT:    v_mov_b32_e32 v44, 0x7fc00000
; GCN-NEXT:    s_branch .LBB1_2
; GCN-NEXT:  .LBB1_1: ; %Flow7
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    s_and_b64 s[4:5], exec, s[4:5]
; GCN-NEXT:    s_or_b64 s[50:51], s[4:5], s[50:51]
; GCN-NEXT:    s_andn2_b64 exec, exec, s[50:51]
; GCN-NEXT:    s_cbranch_execz .LBB1_18
; GCN-NEXT:  .LBB1_2: ; %bb2
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    flat_load_dword v0, v[41:42]
; GCN-NEXT:    buffer_store_dword v42, off, s[0:3], 0
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:    s_waitcnt vmcnt(1)
; GCN-NEXT:    v_cmp_lt_i32_e32 vcc, 2, v0
; GCN-NEXT:    s_mov_b64 s[4:5], -1
; GCN-NEXT:    s_and_saveexec_b64 s[8:9], vcc
; GCN-NEXT:    s_xor_b64 s[56:57], exec, s[8:9]
; GCN-NEXT:    s_cbranch_execz .LBB1_12
; GCN-NEXT:  ; %bb.3: ; %bb6
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    v_cmp_eq_u32_e64 s[44:45], 3, v0
; GCN-NEXT:    s_and_saveexec_b64 s[58:59], s[44:45]
; GCN-NEXT:    s_cbranch_execz .LBB1_11
; GCN-NEXT:  ; %bb.4: ; %bb11
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_mov_b64 s[4:5], s[40:41]
; GCN-NEXT:    s_mov_b64 s[6:7], s[34:35]
; GCN-NEXT:    s_mov_b64 s[8:9], s[38:39]
; GCN-NEXT:    s_mov_b64 s[10:11], s[36:37]
; GCN-NEXT:    s_mov_b32 s12, s49
; GCN-NEXT:    s_mov_b32 s13, s48
; GCN-NEXT:    s_mov_b32 s14, s47
; GCN-NEXT:    s_mov_b32 s15, s46
; GCN-NEXT:    v_mov_b32_e32 v31, v40
; GCN-NEXT:    s_swappc_b64 s[30:31], s[52:53]
; GCN-NEXT:    v_cmp_neq_f32_e32 vcc, 0, v0
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB1_10
; GCN-NEXT:  ; %bb.5: ; %bb14
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_mov_b64 s[8:9], s[54:55]
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], s[42:43]
; GCN-NEXT:    s_cbranch_execz .LBB1_7
; GCN-NEXT:  ; %bb.6: ; %bb16
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    buffer_store_dword v44, off, s[0:3], 0
; GCN-NEXT:    s_or_b64 s[8:9], s[54:55], exec
; GCN-NEXT:  .LBB1_7: ; %Flow3
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[6:7]
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:    s_and_saveexec_b64 s[10:11], s[8:9]
; GCN-NEXT:    s_xor_b64 s[8:9], exec, s[10:11]
; GCN-NEXT:    s_cbranch_execz .LBB1_9
; GCN-NEXT:  ; %bb.8: ; %bb17
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    buffer_store_dword v43, off, s[0:3], 0
; GCN-NEXT:  .LBB1_9: ; %Flow4
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    s_and_b64 s[6:7], s[6:7], exec
; GCN-NEXT:  .LBB1_10: ; %Flow2
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_andn2_b64 s[4:5], s[44:45], exec
; GCN-NEXT:    s_and_b64 s[8:9], vcc, exec
; GCN-NEXT:    s_or_b64 s[44:45], s[4:5], s[8:9]
; GCN-NEXT:    s_and_b64 s[6:7], s[6:7], exec
; GCN-NEXT:  .LBB1_11: ; %Flow1
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[58:59]
; GCN-NEXT:    s_orn2_b64 s[4:5], s[44:45], exec
; GCN-NEXT:    s_and_b64 s[6:7], s[6:7], exec
; GCN-NEXT:    ; implicit-def: $vgpr0
; GCN-NEXT:  .LBB1_12: ; %Flow
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_andn2_saveexec_b64 s[8:9], s[56:57]
; GCN-NEXT:    s_cbranch_execz .LBB1_16
; GCN-NEXT:  ; %bb.13: ; %bb8
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    s_mov_b64 s[10:11], s[6:7]
; GCN-NEXT:    s_and_saveexec_b64 s[12:13], vcc
; GCN-NEXT:    s_cbranch_execz .LBB1_15
; GCN-NEXT:  ; %bb.14: ; %bb10
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    buffer_store_dword v44, off, s[0:3], 0
; GCN-NEXT:    s_or_b64 s[10:11], s[6:7], exec
; GCN-NEXT:  .LBB1_15: ; %Flow6
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[12:13]
; GCN-NEXT:    s_andn2_b64 s[4:5], s[4:5], exec
; GCN-NEXT:    s_and_b64 s[12:13], vcc, exec
; GCN-NEXT:    s_andn2_b64 s[6:7], s[6:7], exec
; GCN-NEXT:    s_and_b64 s[10:11], s[10:11], exec
; GCN-NEXT:    s_or_b64 s[4:5], s[4:5], s[12:13]
; GCN-NEXT:    s_or_b64 s[6:7], s[6:7], s[10:11]
; GCN-NEXT:  .LBB1_16: ; %Flow5
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    s_and_saveexec_b64 s[8:9], s[6:7]
; GCN-NEXT:    s_cbranch_execz .LBB1_1
; GCN-NEXT:  ; %bb.17: ; %bb18
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    buffer_store_dword v44, off, s[0:3], 0
; GCN-NEXT:    s_andn2_b64 s[4:5], s[4:5], exec
; GCN-NEXT:    s_branch .LBB1_1
; GCN-NEXT:  .LBB1_18: ; %DummyReturnBlock
; GCN-NEXT:    s_or_b64 exec, exec, s[50:51]
; GCN-NEXT:    v_readlane_b32 s59, v45, 27
; GCN-NEXT:    v_readlane_b32 s58, v45, 26
; GCN-NEXT:    v_readlane_b32 s57, v45, 25
; GCN-NEXT:    v_readlane_b32 s56, v45, 24
; GCN-NEXT:    v_readlane_b32 s55, v45, 23
; GCN-NEXT:    v_readlane_b32 s54, v45, 22
; GCN-NEXT:    v_readlane_b32 s53, v45, 21
; GCN-NEXT:    v_readlane_b32 s52, v45, 20
; GCN-NEXT:    v_readlane_b32 s51, v45, 19
; GCN-NEXT:    v_readlane_b32 s50, v45, 18
; GCN-NEXT:    v_readlane_b32 s49, v45, 17
; GCN-NEXT:    v_readlane_b32 s48, v45, 16
; GCN-NEXT:    v_readlane_b32 s47, v45, 15
; GCN-NEXT:    v_readlane_b32 s46, v45, 14
; GCN-NEXT:    v_readlane_b32 s45, v45, 13
; GCN-NEXT:    v_readlane_b32 s44, v45, 12
; GCN-NEXT:    v_readlane_b32 s43, v45, 11
; GCN-NEXT:    v_readlane_b32 s42, v45, 10
; GCN-NEXT:    v_readlane_b32 s41, v45, 9
; GCN-NEXT:    v_readlane_b32 s40, v45, 8
; GCN-NEXT:    v_readlane_b32 s39, v45, 7
; GCN-NEXT:    v_readlane_b32 s38, v45, 6
; GCN-NEXT:    v_readlane_b32 s37, v45, 5
; GCN-NEXT:    v_readlane_b32 s36, v45, 4
; GCN-NEXT:    v_readlane_b32 s35, v45, 3
; GCN-NEXT:    v_readlane_b32 s34, v45, 2
; GCN-NEXT:    v_readlane_b32 s31, v45, 1
; GCN-NEXT:    v_readlane_b32 s30, v45, 0
; GCN-NEXT:    buffer_load_dword v44, off, s[0:3], s33 ; 4-byte Folded Reload
; GCN-NEXT:    buffer_load_dword v43, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; GCN-NEXT:    buffer_load_dword v42, off, s[0:3], s33 offset:8 ; 4-byte Folded Reload
; GCN-NEXT:    buffer_load_dword v41, off, s[0:3], s33 offset:12 ; 4-byte Folded Reload
; GCN-NEXT:    buffer_load_dword v40, off, s[0:3], s33 offset:16 ; 4-byte Folded Reload
; GCN-NEXT:    v_readlane_b32 s4, v45, 28
; GCN-NEXT:    s_or_saveexec_b64 s[6:7], -1
; GCN-NEXT:    buffer_load_dword v45, off, s[0:3], s33 offset:20 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[6:7]
; GCN-NEXT:    s_addk_i32 s32, 0xf800
; GCN-NEXT:    s_mov_b32 s33, s4
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
bb:
  %tmp = load float, ptr null, align 16
  br label %bb2

bb1:                                              ; preds = %bb8, %bb6
  br label %bb2

bb2:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep  = getelementptr inbounds i32, ptr addrspace(1) null, i32 %tid
  %tmp3 = load i32, ptr addrspace(1) %gep, align 16
  store float 0.000000e+00, ptr addrspace(5) null, align 8
  br label %bb4

bb4:                                              ; preds = %bb2
  %tmp5 = icmp slt i32 %tmp3, 3
  br i1 %tmp5, label %bb8, label %bb6

bb6:                                              ; preds = %bb4
  %tmp7 = icmp eq i32 %tmp3, 3
  br i1 %tmp7, label %bb11, label %bb1

bb8:                                              ; preds = %bb4
  %tmp9 = icmp eq i32 %tmp3, 1
  br i1 %tmp9, label %bb10, label %bb1

bb10:                                             ; preds = %bb8
  store float 0x7FF8000000000000, ptr addrspace(5) null, align 16
  br label %bb18

bb11:                                             ; preds = %bb6
  %tmp12 = call float @spam()
  %tmp13 = fcmp nsz oeq float %tmp12, 0.000000e+00
  br i1 %tmp13, label %bb2, label %bb14

bb14:                                             ; preds = %bb11
  %tmp15 = fcmp nsz oeq float %tmp, 0.000000e+00
  br i1 %tmp15, label %bb17, label %bb16

bb16:                                             ; preds = %bb14
  store float 0x7FF8000000000000, ptr addrspace(5) null, align 16
  br label %bb17

bb17:                                             ; preds = %bb16, %bb14
  store float %tmp, ptr addrspace(5) null, align 16
  br label %bb18

bb18:                                             ; preds = %bb17, %bb10
  store float 0x7FF8000000000000, ptr addrspace(5) null, align 4
  br label %bb2
}

declare i32 @llvm.amdgcn.workitem.id.x()

declare hidden float @spam()

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdgpu_code_object_version", i32 500}
