; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S -passes=gvn < %s | FileCheck %s

; Make sure we don't have use-after-free due to dangling values in
; select available value.

define i64 @test(i1 %c, ptr %p) {
; CHECK-LABEL: define i64 @test(
; CHECK-SAME: i1 [[C:%.*]], ptr [[P:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[P]], [[ENTRY]] ], [ [[SELECT:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[ICMP:%.*]] = icmp eq i64 [[IV]], 0
; CHECK-NEXT:    br i1 [[ICMP]], label [[LOOP_EXIT_CRIT_EDGE:%.*]], label [[LOOP_CONT:%.*]]
; CHECK:       loop.exit_crit_edge:
; CHECK-NEXT:    [[RES_PRE:%.*]] = load i64, ptr [[PTR_IV]], align 8
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       loop.cont:
; CHECK-NEXT:    [[ADD]] = add i64 [[IV]], -1
; CHECK-NEXT:    [[RES_PRE1:%.*]] = load i64, ptr [[PTR_IV]], align 8
; CHECK-NEXT:    br i1 [[C]], label [[EXITSPLIT:%.*]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[LOAD6:%.*]] = load i64, ptr [[P]], align 8
; CHECK-NEXT:    [[ICMP7:%.*]] = icmp ugt i64 [[RES_PRE1]], [[LOAD6]]
; CHECK-NEXT:    [[TMP0:%.*]] = select i1 [[ICMP7]], i64 [[RES_PRE1]], i64 [[LOAD6]]
; CHECK-NEXT:    [[SELECT]] = select i1 [[ICMP7]], ptr [[PTR_IV]], ptr [[P]]
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       exitsplit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RES:%.*]] = phi i64 [ [[RES_PRE1]], [[EXITSPLIT]] ], [ [[RES_PRE]], [[LOOP_EXIT_CRIT_EDGE]] ]
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %add, %loop.latch ]
  %ptr.iv = phi ptr [ %p, %entry ], [ %select, %loop.latch ]
  %icmp = icmp eq i64 %iv, 0
  br i1 %icmp, label %exit, label %loop.cont

loop.cont:
  %add = add i64 %iv, -1
  br i1 %c, label %exit, label %loop.latch

loop.latch:
  %load = load i64, ptr %ptr.iv, align 8
  %load6 = load i64, ptr %p, align 8
  %icmp7 = icmp ugt i64 %load, %load6
  %select = select i1 %icmp7, ptr %ptr.iv, ptr %p
  br label %loop

exit:
  %res = load i64, ptr %ptr.iv, align 8
  ret i64 %res
}
