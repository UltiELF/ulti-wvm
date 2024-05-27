; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' < %s | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"

define void @f1(i32 %a) {
; CHECK-LABEL: @f1(
; CHECK-NEXT:    [[FR:%.*]] = freeze i32 [[A:%.*]]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[FR]], 0
; CHECK-NEXT:    br i1 [[C]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %c = icmp eq i32 %a, 0
  %fr = freeze i1 %c
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @f2(i32 %a) {
; CHECK-LABEL: @f2(
; CHECK-NEXT:    [[FR:%.*]] = freeze i32 [[A:%.*]]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 0, [[FR]]
; CHECK-NEXT:    br i1 [[C]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %c = icmp eq i32 0, %a
  %fr = freeze i1 %c
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @f3(i32 %a) {
; CHECK-LABEL: @f3(
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 0, 1
; CHECK-NEXT:    br i1 [[C]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %c = icmp eq i32 0, 1
  %fr = freeze i1 %c
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define i1 @ptrcmp(ptr %p) {
; CHECK-LABEL: @ptrcmp(
; CHECK-NEXT:    [[FR:%.*]] = freeze ptr [[P:%.*]]
; CHECK-NEXT:    [[C:%.*]] = icmp eq ptr [[FR]], null
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = icmp eq ptr %p, null
  %fr = freeze i1 %c
  ret i1 %fr
}


define i1 @fcmp(float %a) {
; CHECK-LABEL: @fcmp(
; CHECK-NEXT:    [[FR:%.*]] = freeze float [[A:%.*]]
; CHECK-NEXT:    [[C:%.*]] = fcmp oeq float [[FR]], 0.000000e+00
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = fcmp oeq float %a, 0.0
  %fr = freeze i1 %c
  ret i1 %fr
}

define i1 @fcmp_nan(float %a) {
; CHECK-LABEL: @fcmp_nan(
; CHECK-NEXT:    [[C:%.*]] = fcmp nnan oeq float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[C]]
; CHECK-NEXT:    ret i1 [[FR]]
;
  %c = fcmp nnan oeq float %a, 0.0
  %fr = freeze i1 %c
  ret i1 %fr
}

define void @and_bitmask(i32 %flag) {
; CHECK-LABEL: @and_bitmask(
; CHECK-NEXT:    [[V:%.*]] = and i32 [[FLAG:%.*]], 1
; CHECK-NEXT:    [[FR:%.*]] = freeze i32 [[V]]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[FR]], 0
; CHECK-NEXT:    br i1 [[C]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %v = and i32 %flag, 1
  %c = icmp eq i32 %v, 0
  %fr = freeze i1 %c
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @and_bitmask_r(i32 %flag) {
; CHECK-LABEL: @and_bitmask_r(
; CHECK-NEXT:    [[V:%.*]] = and i32 1, [[FLAG:%.*]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i32 [[V]]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 0, [[FR]]
; CHECK-NEXT:    br i1 [[C]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %v = and i32 1, %flag
  %c = icmp eq i32 0, %v
  %fr = freeze i1 %c
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @and_bitmask2(i32 %flag, i32 %flag2) {
; CHECK-LABEL: @and_bitmask2(
; CHECK-NEXT:    [[V:%.*]] = and i32 [[FLAG:%.*]], 1
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[V]], 0
; CHECK-NEXT:    [[V2:%.*]] = and i32 [[FLAG2:%.*]], 2
; CHECK-NEXT:    [[C2:%.*]] = icmp eq i32 [[V2]], 0
; CHECK-NEXT:    [[COND:%.*]] = or i1 [[C]], [[C2]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[COND]]
; CHECK-NEXT:    br i1 [[FR]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %v = and i32 %flag, 1
  %c = icmp eq i32 %v, 0
  %v2 = and i32 %flag2, 2
  %c2 = icmp eq i32 %v2, 0
  %cond = or i1 %c, %c2
  %fr = freeze i1 %cond
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @and(i1 %a, i1 %b, i1 %c) {
; CHECK-LABEL: @and(
; CHECK-NEXT:    [[COND:%.*]] = and i1 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[COND2:%.*]] = and i1 [[C:%.*]], [[COND]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[COND2]]
; CHECK-NEXT:    br i1 [[FR]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %cond = and i1 %a, %b
  %cond2 = and i1 %c, %cond
  %fr = freeze i1 %cond2
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @and_long(i1 %a, i1 %b, i1 %c, i1 %d, i1 %e, i1 %f, i1 %g) {
; CHECK-LABEL: @and_long(
; CHECK-NEXT:    [[COND:%.*]] = and i1 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[COND2:%.*]] = and i1 [[C:%.*]], [[COND]]
; CHECK-NEXT:    [[COND3:%.*]] = and i1 [[D:%.*]], [[COND2]]
; CHECK-NEXT:    [[COND4:%.*]] = and i1 [[E:%.*]], [[COND3]]
; CHECK-NEXT:    [[COND5:%.*]] = and i1 [[F:%.*]], [[COND4]]
; CHECK-NEXT:    [[COND6:%.*]] = and i1 [[G:%.*]], [[COND5]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[COND6]]
; CHECK-NEXT:    br i1 [[FR]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %cond = and i1 %a, %b
  %cond2 = and i1 %c, %cond
  %cond3 = and i1 %d, %cond2
  %cond4 = and i1 %e, %cond3
  %cond5 = and i1 %f, %cond4
  %cond6 = and i1 %g, %cond5
  %fr = freeze i1 %cond6
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @and_cmp(i32 %v, float %w, i32 %v2) {
; CHECK-LABEL: @and_cmp(
; CHECK-NEXT:    [[C1:%.*]] = icmp eq i32 [[V:%.*]], 0
; CHECK-NEXT:    [[C2:%.*]] = fcmp oeq float [[W:%.*]], 0.000000e+00
; CHECK-NEXT:    [[COND:%.*]] = and i1 [[C1]], [[C2]]
; CHECK-NEXT:    [[C3:%.*]] = icmp eq i32 [[V2:%.*]], 1
; CHECK-NEXT:    [[COND2:%.*]] = and i1 [[COND]], [[C3]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[COND2]]
; CHECK-NEXT:    br i1 [[FR]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %c1 = icmp eq i32 %v, 0
  %c2 = fcmp oeq float %w, 0.0
  %cond = and i1 %c1, %c2
  %c3 = icmp eq i32 %v2, 1
  %cond2 = and i1 %cond, %c3
  %fr = freeze i1 %cond2
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @or(i1 %a, i1 %b, i1 %c) {
; CHECK-LABEL: @or(
; CHECK-NEXT:    [[COND:%.*]] = or i1 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[COND2:%.*]] = or i1 [[C:%.*]], [[COND]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[COND2]]
; CHECK-NEXT:    br i1 [[FR]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    call void @g1()
; CHECK-NEXT:    ret void
; CHECK:       B:
; CHECK-NEXT:    call void @g2()
; CHECK-NEXT:    ret void
;
  %cond = or i1 %a, %b
  %cond2 = or i1 %c, %cond
  %fr = freeze i1 %cond2
  br i1 %fr, label %A, label %B
A:
  call void @g1()
  ret void
B:
  call void @g2()
  ret void
}

define void @and_loop(i1 %a, i1 %b) {
; CHECK-LABEL: @and_loop(
; CHECK-NEXT:    ret void
; CHECK:       UNREACHABLE:
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A:%.*]], [[C]]
; CHECK-NEXT:    [[FR:%.*]] = freeze i1 [[C]]
; CHECK-NEXT:    br i1 [[FR]], label [[UNREACHABLE:%.*]], label [[EXIT:%.*]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret void
;
  ret void
UNREACHABLE:
  %c = and i1 %a, %c
  %fr = freeze i1 %c
  br i1 %fr, label %UNREACHABLE, label %EXIT
EXIT:
  ret void
}

declare void @g1()
declare void @g2()
