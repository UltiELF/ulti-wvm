; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-BE \
; RUN:   --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-LE \
; RUN:   --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
@glob = dso_local local_unnamed_addr global i16 0, align 2

define i64 @test_llgess(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: test_llgess:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_llgess:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sub r3, r3, r4
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    xori r3, r3, 1
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_llgess:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r3, r4
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    xori r3, r3, 1
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

define i64 @test_llgess_sext(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: test_llgess_sext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    addi r3, r3, -1
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_llgess_sext:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sub r3, r3, r4
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    addi r3, r3, -1
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_llgess_sext:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r3, r4
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    addi r3, r3, -1
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

define dso_local void @test_llgess_store(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: test_llgess_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    sth r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_llgess_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sub r3, r3, r4
; CHECK-BE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    xori r3, r3, 1
; CHECK-BE-NEXT:    sth r3, glob@toc@l(r4)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_llgess_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r3, r4
; CHECK-LE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    xori r3, r3, 1
; CHECK-LE-NEXT:    sth r3, glob@toc@l(r4)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, ptr @glob, align 2
  ret void
}

define dso_local void @test_llgess_sext_store(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: test_llgess_sext_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub r3, r3, r4
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    addi r3, r3, -1
; CHECK-NEXT:    sth r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_llgess_sext_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sub r3, r3, r4
; CHECK-BE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    addi r3, r3, -1
; CHECK-BE-NEXT:    sth r3, glob@toc@l(r4)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_llgess_sext_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sub r3, r3, r4
; CHECK-LE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    addi r3, r3, -1
; CHECK-LE-NEXT:    sth r3, glob@toc@l(r4)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, ptr @glob, align 2
  ret void
}
