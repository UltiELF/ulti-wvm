; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes='function(early-cse),globalopt' < %s | FileCheck %s
; RUN: opt -S -passes='function(early-cse)' < %s | opt -S -passes=globalopt | FileCheck %s

@g = internal global [6 x ptr] undef

define void @test1() {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret void
;
  %xor4 = xor i1 add (i1 icmp ne (ptr getelementptr (i8, ptr @g, i64 3), ptr null), i1 1), 0
  %t0 = load ptr, ptr getelementptr (i8, ptr @g, i64 3), align 1
  %t1 = load i16, ptr %t0, align 1
  ret void
}

define void @test2() {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret void
;
  store ptr null, ptr getelementptr inbounds ([6 x ptr], ptr @g, i32 0, i32 5)
  ret void
}
