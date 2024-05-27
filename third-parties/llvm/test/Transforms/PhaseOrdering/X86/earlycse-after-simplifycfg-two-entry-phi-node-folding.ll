; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes="default<O3>" -S < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; PR51092: SimplifyCFG might produce duplicate PHI's/select's.
; We need to deduplicate them so that further transformations are possible.
define dso_local void @foo(ptr %in, i64 %lo, i64 %hi, i32 %ishi) #0 {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[ISHI:%.*]], 0
; CHECK-NEXT:    [[LO_HI:%.*]] = select i1 [[TOBOOL_NOT]], i64 [[LO:%.*]], i64 [[HI:%.*]]
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, ptr [[IN:%.*]], i64 [[LO_HI]]
; CHECK-NEXT:    [[ARRAYVAL2:%.*]] = load i32, ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    [[INC2:%.*]] = add nsw i32 [[ARRAYVAL2]], 1
; CHECK-NEXT:    store i32 [[INC2]], ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %in.addr = alloca ptr, align 8
  %lo.addr = alloca i64, align 8
  %hi.addr = alloca i64, align 8
  %ishi.addr = alloca i32, align 4
  store ptr %in, ptr %in.addr, align 8
  store i64 %lo, ptr %lo.addr, align 8
  store i64 %hi, ptr %hi.addr, align 8
  store i32 %ishi, ptr %ishi.addr, align 4
  %ishi.reloaded = load i32, ptr %ishi.addr, align 4
  %tobool = icmp ne i32 %ishi.reloaded, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:
  %in.reloaded = load ptr, ptr %in.addr, align 8
  %hi.reloaded = load i64, ptr %hi.addr, align 8
  %arrayidx = getelementptr inbounds i32, ptr %in.reloaded, i64 %hi.reloaded
  %arrayval = load i32, ptr %arrayidx, align 4
  %inc = add nsw i32 %arrayval, 1
  store i32 %inc, ptr %arrayidx, align 4
  br label %if.end

if.else:
  %in.reloaded2 = load ptr, ptr %in.addr, align 8
  %lo.reloaded = load i64, ptr %lo.addr, align 8
  %arrayidx1 = getelementptr inbounds i32, ptr %in.reloaded2, i64 %lo.reloaded
  %arrayval2 = load i32, ptr %arrayidx1, align 4
  %inc2 = add nsw i32 %arrayval2, 1
  store i32 %inc2, ptr %arrayidx1, align 4
  br label %if.end

if.end:
  ret void
}
