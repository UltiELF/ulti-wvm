; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --extra_scrub
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefixes=RV64I
; RUN: llc -mtriple=riscv64 -mattr=+m,+xtheadba -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefixes=RV64XTHEADBA

define signext i16 @th_addsl_1(i64 %0, ptr %1) {
; RV64I-LABEL: th_addsl_1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 1
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lh a0, 0(a0)
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: th_addsl_1:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 1
; RV64XTHEADBA-NEXT:    lh a0, 0(a0)
; RV64XTHEADBA-NEXT:    ret
  %3 = getelementptr inbounds i16, ptr %1, i64 %0
  %4 = load i16, ptr %3
  ret i16 %4
}

define signext i32 @th_addsl_2(i64 %0, ptr %1) {
; RV64I-LABEL: th_addsl_2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 2
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lw a0, 0(a0)
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: th_addsl_2:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 2
; RV64XTHEADBA-NEXT:    lw a0, 0(a0)
; RV64XTHEADBA-NEXT:    ret
  %3 = getelementptr inbounds i32, ptr %1, i64 %0
  %4 = load i32, ptr %3
  ret i32 %4
}

define i64 @th_addsl_3(i64 %0, ptr %1) {
; RV64I-LABEL: th_addsl_3:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 3
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    ld a0, 0(a0)
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: th_addsl_3:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 3
; RV64XTHEADBA-NEXT:    ld a0, 0(a0)
; RV64XTHEADBA-NEXT:    ret
  %3 = getelementptr inbounds i64, ptr %1, i64 %0
  %4 = load i64, ptr %3
  ret i64 %4
}

; Type legalization inserts a sext_inreg after the first add. That add will be
; selected as th.addsl which does not sign extend. SimplifyDemandedBits is unable
; to remove the sext_inreg because it has multiple uses. The ashr will use the
; sext_inreg to become sraiw. This leaves the sext_inreg only used by the shl.
; If the shl is selected as sllw, we don't need the sext_inreg.
define i64 @th_addsl_2_extra_sext(i32 %x, i32 %y, i32 %z) {
; RV64I-LABEL: th_addsl_2_extra_sext:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sllw a1, a2, a0
; RV64I-NEXT:    sraiw a0, a0, 2
; RV64I-NEXT:    mul a0, a1, a0
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: th_addsl_2_extra_sext:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 2
; RV64XTHEADBA-NEXT:    sllw a1, a2, a0
; RV64XTHEADBA-NEXT:    sraiw a0, a0, 2
; RV64XTHEADBA-NEXT:    mul a0, a1, a0
; RV64XTHEADBA-NEXT:    ret
  %a = shl i32 %x, 2
  %b = add i32 %a, %y
  %c = shl i32 %z, %b
  %d = ashr i32 %b, 2
  %e = sext i32 %c to i64
  %f = sext i32 %d to i64
  %g = mul i64 %e, %f
  ret i64 %g
}

define i64 @addmul6(i64 %a, i64 %b) {
; RV64I-LABEL: addmul6:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 6
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul6:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 1
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 1
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 6
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul10(i64 %a, i64 %b) {
; RV64I-LABEL: addmul10:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 10
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul10:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 2
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 1
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 10
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul12(i64 %a, i64 %b) {
; RV64I-LABEL: addmul12:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 12
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul12:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 1
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 2
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 12
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul18(i64 %a, i64 %b) {
; RV64I-LABEL: addmul18:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 18
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul18:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 3
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 1
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 18
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul20(i64 %a, i64 %b) {
; RV64I-LABEL: addmul20:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 20
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul20:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 2
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 2
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 20
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul24(i64 %a, i64 %b) {
; RV64I-LABEL: addmul24:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 24
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul24:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 1
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 3
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 24
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul36(i64 %a, i64 %b) {
; RV64I-LABEL: addmul36:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 36
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul36:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 3
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 2
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 36
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul40(i64 %a, i64 %b) {
; RV64I-LABEL: addmul40:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 40
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul40:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 2
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 3
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 40
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @addmul72(i64 %a, i64 %b) {
; RV64I-LABEL: addmul72:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a2, 72
; RV64I-NEXT:    mul a0, a0, a2
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: addmul72:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 3
; RV64XTHEADBA-NEXT:    th.addsl a0, a1, a0, 3
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 72
  %d = add i64 %c, %b
  ret i64 %d
}

define i64 @mul96(i64 %a) {
; RV64I-LABEL: mul96:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, 96
; RV64I-NEXT:    mul a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: mul96:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 1
; RV64XTHEADBA-NEXT:    slli a0, a0, 5
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 96
  ret i64 %c
}

define i64 @mul160(i64 %a) {
; RV64I-LABEL: mul160:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, 160
; RV64I-NEXT:    mul a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: mul160:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 2
; RV64XTHEADBA-NEXT:    slli a0, a0, 5
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 160
  ret i64 %c
}

define i64 @mul200(i64 %a) {
; RV64I-LABEL: mul200:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, 200
; RV64I-NEXT:    mul a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: mul200:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 2
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 2
; RV64XTHEADBA-NEXT:    slli a0, a0, 3
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 200
  ret i64 %c
}

define i64 @mul288(i64 %a) {
; RV64I-LABEL: mul288:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, 288
; RV64I-NEXT:    mul a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64XTHEADBA-LABEL: mul288:
; RV64XTHEADBA:       # %bb.0:
; RV64XTHEADBA-NEXT:    th.addsl a0, a0, a0, 3
; RV64XTHEADBA-NEXT:    slli a0, a0, 5
; RV64XTHEADBA-NEXT:    ret
  %c = mul i64 %a, 288
  ret i64 %c
}
