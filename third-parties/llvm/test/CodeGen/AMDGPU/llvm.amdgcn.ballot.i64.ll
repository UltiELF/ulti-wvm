; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx900 < %s | FileCheck %s

declare i64 @llvm.amdgcn.ballot.i64(i1)
declare i64 @llvm.ctpop.i64(i64)

; Test ballot(0)

define amdgpu_cs i64 @constant_false() {
; CHECK-LABEL: constant_false:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_mov_b32 s0, 0
; CHECK-NEXT:    s_mov_b32 s1, 0
; CHECK-NEXT:    ; return to shader part epilog
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 0)
  ret i64 %ballot
}

; Test ballot(1)

define amdgpu_cs i64 @constant_true() {
; CHECK-LABEL: constant_true:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_mov_b32 s0, exec_lo
; CHECK-NEXT:    s_mov_b32 s1, exec_hi
; CHECK-NEXT:    ; return to shader part epilog
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 1)
  ret i64 %ballot
}

; Test ballot of a non-comparison operation

define amdgpu_cs i64 @non_compare(i32 %x) {
; CHECK-LABEL: non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s[0:1], 0, v0
; CHECK-NEXT:    ; return to shader part epilog
  %trunc = trunc i32 %x to i1
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %trunc)
  ret i64 %ballot
}

; Test ballot of comparisons

define amdgpu_cs i64 @compare_ints(i32 %x, i32 %y) {
; CHECK-LABEL: compare_ints:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_eq_u32_e64 s[0:1], v0, v1
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = icmp eq i32 %x, %y
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %cmp)
  ret i64 %ballot
}

define amdgpu_cs i64 @compare_int_with_constant(i32 %x) {
; CHECK-LABEL: compare_int_with_constant:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_movk_i32 s0, 0x62
; CHECK-NEXT:    v_cmp_lt_i32_e64 s[0:1], s0, v0
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = icmp sge i32 %x, 99
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %cmp)
  ret i64 %ballot
}

define amdgpu_cs i64 @compare_floats(float %x, float %y) {
; CHECK-LABEL: compare_floats:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_f32_e64 s[0:1], v0, v1
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = fcmp ogt float %x, %y
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %cmp)
  ret i64 %ballot
}

define amdgpu_cs i64 @ctpop_of_ballot(float %x, float %y) {
; CHECK-LABEL: ctpop_of_ballot:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_f32_e32 vcc, v0, v1
; CHECK-NEXT:    s_bcnt1_i32_b64 s0, vcc
; CHECK-NEXT:    s_mov_b32 s1, 0
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = fcmp ogt float %x, %y
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %cmp)
  %bcnt = call i64 @llvm.ctpop.i64(i64 %ballot)
  ret i64 %bcnt
}

define amdgpu_cs i32 @branch_divergent_ballot_ne_zero_non_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_ne_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; CHECK-NEXT:    s_cbranch_vccz .LBB7_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB7_3
; CHECK-NEXT:  .LBB7_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB7_3
; CHECK-NEXT:  .LBB7_3:
  %c = trunc i32 %v to i1
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_ne_zero_non_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_ne_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_and_b32 s0, s0, 1
; CHECK-NEXT:    v_cmp_ne_u32_e64 vcc, s0, 0
; CHECK-NEXT:    s_cbranch_vccz .LBB8_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB8_3
; CHECK-NEXT:  .LBB8_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB8_3
; CHECK-NEXT:  .LBB8_3:
  %c = trunc i32 %v to i1
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_eq_zero_non_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_eq_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; CHECK-NEXT:    s_cbranch_vccz .LBB9_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB9_3
; CHECK-NEXT:  .LBB9_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB9_3
; CHECK-NEXT:  .LBB9_3:
  %c = trunc i32 %v to i1
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_eq_zero_non_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_eq_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_and_b32 s0, s0, 1
; CHECK-NEXT:    v_cmp_ne_u32_e64 vcc, s0, 0
; CHECK-NEXT:    s_cbranch_vccz .LBB10_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB10_3
; CHECK-NEXT:  .LBB10_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB10_3
; CHECK-NEXT:  .LBB10_3:
  %c = trunc i32 %v to i1
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_ne_zero_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_ne_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 12, v0
; CHECK-NEXT:    s_cbranch_vccz .LBB11_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB11_3
; CHECK-NEXT:  .LBB11_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB11_3
; CHECK-NEXT:  .LBB11_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_ne_zero_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_ne_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_lt_u32_e64 vcc, s0, 12
; CHECK-NEXT:    s_cbranch_vccz .LBB12_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB12_3
; CHECK-NEXT:  .LBB12_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB12_3
; CHECK-NEXT:  .LBB12_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_eq_zero_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_eq_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 12, v0
; CHECK-NEXT:    s_cbranch_vccz .LBB13_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB13_3
; CHECK-NEXT:  .LBB13_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB13_3
; CHECK-NEXT:  .LBB13_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_eq_zero_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_eq_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_lt_u32_e64 vcc, s0, 12
; CHECK-NEXT:    s_cbranch_vccz .LBB14_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB14_3
; CHECK-NEXT:  .LBB14_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB14_3
; CHECK-NEXT:  .LBB14_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_ne_zero_and(i32 %v1, i32 %v2) {
; CHECK-LABEL: branch_divergent_ballot_ne_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 12, v0
; CHECK-NEXT:    v_cmp_lt_u32_e64 s[0:1], 34, v1
; CHECK-NEXT:    s_and_b64 vcc, vcc, s[0:1]
; CHECK-NEXT:    s_cbranch_vccz .LBB15_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB15_3
; CHECK-NEXT:  .LBB15_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB15_3
; CHECK-NEXT:  .LBB15_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_ne_zero_and(i32 inreg %v1, i32 inreg %v2) {
; CHECK-LABEL: branch_uniform_ballot_ne_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b64 s[2:3], -1, 0
; CHECK-NEXT:    s_cmp_gt_u32 s1, 34
; CHECK-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CHECK-NEXT:    s_and_b64 s[0:1], s[2:3], s[0:1]
; CHECK-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; CHECK-NEXT:    s_cbranch_scc0 .LBB16_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB16_3
; CHECK-NEXT:  .LBB16_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB16_3
; CHECK-NEXT:  .LBB16_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_eq_zero_and(i32 %v1, i32 %v2) {
; CHECK-LABEL: branch_divergent_ballot_eq_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 12, v0
; CHECK-NEXT:    v_cmp_lt_u32_e64 s[0:1], 34, v1
; CHECK-NEXT:    s_and_b64 vcc, vcc, s[0:1]
; CHECK-NEXT:    s_cbranch_vccz .LBB17_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB17_3
; CHECK-NEXT:  .LBB17_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB17_3
; CHECK-NEXT:  .LBB17_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_eq_zero_and(i32 inreg %v1, i32 inreg %v2) {
; CHECK-LABEL: branch_uniform_ballot_eq_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b64 s[2:3], -1, 0
; CHECK-NEXT:    s_cmp_gt_u32 s1, 34
; CHECK-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CHECK-NEXT:    s_and_b64 s[0:1], s[2:3], s[0:1]
; CHECK-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; CHECK-NEXT:    s_cbranch_scc0 .LBB18_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB18_3
; CHECK-NEXT:  .LBB18_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB18_3
; CHECK-NEXT:  .LBB18_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_sgt_N_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_sgt_N_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_lt_u32_e64 s[0:1], s0, 12
; CHECK-NEXT:    v_cmp_lt_i64_e64 vcc, s[0:1], 23
; CHECK-NEXT:    s_cbranch_vccnz .LBB19_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB19_3
; CHECK-NEXT:  .LBB19_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB19_3
; CHECK-NEXT:  .LBB19_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i64 @llvm.amdgcn.ballot.i64(i1 %c)
  %bc = icmp sgt i64 %ballot, 22
  br i1 %bc, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

declare i64 @llvm.amdgcn.icmp.i64(i1, i1, i32)

define amdgpu_cs i32 @branch_divergent_simulated_negated_ballot_ne_zero_and(i32 %v1, i32 %v2) {
; CHECK-LABEL: branch_divergent_simulated_negated_ballot_ne_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 12, v0
; CHECK-NEXT:    v_cmp_lt_u32_e64 s[0:1], 34, v1
; CHECK-NEXT:    s_and_b64 vcc, vcc, s[0:1]
; CHECK-NEXT:    s_cbranch_vccnz .LBB20_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB20_3
; CHECK-NEXT:  .LBB20_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB20_3
; CHECK-NEXT:  .LBB20_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.icmp.i64(i1 %c, i1 0, i32 32) ; ICMP_EQ == 32
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_simulated_negated_ballot_ne_zero_and(i32 inreg %v1, i32 inreg %v2) {
; CHECK-LABEL: branch_uniform_simulated_negated_ballot_ne_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b64 s[2:3], -1, 0
; CHECK-NEXT:    s_cmp_gt_u32 s1, 34
; CHECK-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CHECK-NEXT:    s_and_b64 s[0:1], s[2:3], s[0:1]
; CHECK-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; CHECK-NEXT:    s_cbranch_scc1 .LBB21_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB21_3
; CHECK-NEXT:  .LBB21_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB21_3
; CHECK-NEXT:  .LBB21_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.icmp.i64(i1 %c, i1 0, i32 32) ; ICMP_EQ == 32
  %ballot_ne_zero = icmp ne i64 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_simulated_negated_ballot_eq_zero_and(i32 %v1, i32 %v2) {
; CHECK-LABEL: branch_divergent_simulated_negated_ballot_eq_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 12, v0
; CHECK-NEXT:    v_cmp_lt_u32_e64 s[0:1], 34, v1
; CHECK-NEXT:    s_and_b64 vcc, vcc, s[0:1]
; CHECK-NEXT:    s_cbranch_vccnz .LBB22_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB22_3
; CHECK-NEXT:  .LBB22_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB22_3
; CHECK-NEXT:  .LBB22_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.icmp.i64(i1 %c, i1 0, i32 32) ; ICMP_EQ == 32
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_simulated_negated_ballot_eq_zero_and(i32 inreg %v1, i32 inreg %v2) {
; CHECK-LABEL: branch_uniform_simulated_negated_ballot_eq_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b64 s[2:3], -1, 0
; CHECK-NEXT:    s_cmp_gt_u32 s1, 34
; CHECK-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CHECK-NEXT:    s_and_b64 s[0:1], s[2:3], s[0:1]
; CHECK-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; CHECK-NEXT:    s_cbranch_scc1 .LBB23_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB23_3
; CHECK-NEXT:  .LBB23_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB23_3
; CHECK-NEXT:  .LBB23_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i64 @llvm.amdgcn.icmp.i64(i1 %c, i1 0, i32 32) ; ICMP_EQ == 32
  %ballot_eq_zero = icmp eq i64 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}