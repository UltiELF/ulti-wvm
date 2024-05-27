; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; We used to hit an assertion in getFlippedStrictnessPredicateAndConstant due
; to assuming that edge cases such as %cmp (ult x, 0) already has been
; simplified. But that depends on the worklist order, so that is not always
; guaranteed.

define i16 @d(ptr %d.a, ptr %d.b) {
; CHECK-LABEL: @d(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T0:%.*]] = load i16, ptr [[D_A:%.*]], align 1
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i16 [[T0]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[LAND_END:%.*]], label [[LAND_RHS:%.*]]
; CHECK:       land.rhs:
; CHECK-NEXT:    br label [[LAND_END]]
; CHECK:       land.end:
; CHECK-NEXT:    ret i16 -1
;
entry:
  %t0 = load i16, ptr %d.a, align 1
  %tobool = icmp ne i16 %t0, 0
  br i1 %tobool, label %land.rhs, label %land.end

land.rhs:
  %t1 = load i16, ptr %d.b, align 1
  %cmp = icmp ult i16 %t1, 0
  br label %land.end

land.end:
  %t2 = phi i1 [ false, %entry ], [ %cmp, %land.rhs ]
  %land.ext = zext i1 %t2 to i16
  %mul = mul nsw i16 %land.ext, 3
  %neg = xor i16 %mul, -1
  ret i16 %neg
}
