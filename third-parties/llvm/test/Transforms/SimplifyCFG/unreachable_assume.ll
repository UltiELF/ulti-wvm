; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes=simplifycfg,instcombine -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

define i32 @assume1(i32 %p) {
; CHECK-LABEL: @assume1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[P:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 [[P]]
;
entry:
  %cmp = icmp sle i32 %p, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  unreachable

if.end:
  %call = call i32 @abs(i32 %p)
  ret i32 %call
}


define i32 @assume2(i32 %p) {
; CHECK-LABEL: @assume2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[P:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 [[P]]
;
entry:
  %cmp = icmp sgt i32 %p, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:
  br label %if.end

if.else:
  unreachable

if.end:
  %call = call i32 @abs(i32 %p)
  ret i32 %call
}

declare i32 @abs(i32)
