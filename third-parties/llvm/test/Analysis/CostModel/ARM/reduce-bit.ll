; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=armv8a-linux-gnueabihf -mattr=+fp64 -passes="print<cost-model>" 2>&1 -disable-output | FileCheck %s --check-prefix=CHECK-V8
; RUN: opt < %s -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve -passes="print<cost-model>" 2>&1 -disable-output | FileCheck %s --check-prefix=CHECK-MVEI

define void @and() {
; CHECK-V8-LABEL: 'and'
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1i64 = call i64 @llvm.vector.reduce.and.v1i64(<1 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i64 = call i64 @llvm.vector.reduce.and.v2i64(<2 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v4i64 = call i64 @llvm.vector.reduce.and.v4i64(<4 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i32 = call i32 @llvm.vector.reduce.and.v2i32(<2 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v8i32 = call i32 @llvm.vector.reduce.and.v8i32(<8 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i16 = call i16 @llvm.vector.reduce.and.v2i16(<2 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i16 = call i16 @llvm.vector.reduce.and.v4i16(<4 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v8i16 = call i16 @llvm.vector.reduce.and.v8i16(<8 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %v16i16 = call i16 @llvm.vector.reduce.and.v16i16(<16 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i8 = call i8 @llvm.vector.reduce.and.v2i8(<2 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i8 = call i8 @llvm.vector.reduce.and.v4i8(<4 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %v8i8 = call i8 @llvm.vector.reduce.and.v8i8(<8 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v16i8 = call i8 @llvm.vector.reduce.and.v16i8(<16 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %v32i8 = call i8 @llvm.vector.reduce.and.v32i8(<32 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-MVEI-LABEL: 'and'
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1i64 = call i64 @llvm.vector.reduce.and.v1i64(<1 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = call i64 @llvm.vector.reduce.and.v2i64(<2 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v4i64 = call i64 @llvm.vector.reduce.and.v4i64(<4 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i32 = call i32 @llvm.vector.reduce.and.v2i32(<2 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i32 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %v8i32 = call i32 @llvm.vector.reduce.and.v8i32(<8 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i16 = call i16 @llvm.vector.reduce.and.v2i16(<2 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i16 = call i16 @llvm.vector.reduce.and.v4i16(<4 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %v8i16 = call i16 @llvm.vector.reduce.and.v8i16(<8 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %v16i16 = call i16 @llvm.vector.reduce.and.v16i16(<16 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i8 = call i8 @llvm.vector.reduce.and.v2i8(<2 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i8 = call i8 @llvm.vector.reduce.and.v4i8(<4 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %v8i8 = call i8 @llvm.vector.reduce.and.v8i8(<8 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 31 for instruction: %v16i8 = call i8 @llvm.vector.reduce.and.v16i8(<16 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %v32i8 = call i8 @llvm.vector.reduce.and.v32i8(<32 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
entry:
  %v1i64 = call i64 @llvm.vector.reduce.and.v1i64(<1 x i64> undef)
  %v2i64 = call i64 @llvm.vector.reduce.and.v2i64(<2 x i64> undef)
  %v4i64 = call i64 @llvm.vector.reduce.and.v4i64(<4 x i64> undef)
  %v2i32 = call i32 @llvm.vector.reduce.and.v2i32(<2 x i32> undef)
  %v4i32 = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> undef)
  %v8i32 = call i32 @llvm.vector.reduce.and.v8i32(<8 x i32> undef)
  %v2i16 = call i16 @llvm.vector.reduce.and.v2i16(<2 x i16> undef)
  %v4i16 = call i16 @llvm.vector.reduce.and.v4i16(<4 x i16> undef)
  %v8i16 = call i16 @llvm.vector.reduce.and.v8i16(<8 x i16> undef)
  %v16i16 = call i16 @llvm.vector.reduce.and.v16i16(<16 x i16> undef)
  %v2i8 = call i8 @llvm.vector.reduce.and.v2i8(<2 x i8> undef)
  %v4i8 = call i8 @llvm.vector.reduce.and.v4i8(<4 x i8> undef)
  %v8i8 = call i8 @llvm.vector.reduce.and.v8i8(<8 x i8> undef)
  %v16i8 = call i8 @llvm.vector.reduce.and.v16i8(<16 x i8> undef)
  %v32i8 = call i8 @llvm.vector.reduce.and.v32i8(<32 x i8> undef)
  ret void
}

define void @or() {
; CHECK-V8-LABEL: 'or'
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1i64 = call i64 @llvm.vector.reduce.or.v1i64(<1 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i64 = call i64 @llvm.vector.reduce.or.v2i64(<2 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v4i64 = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i32 = call i32 @llvm.vector.reduce.or.v2i32(<2 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v8i32 = call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i16 = call i16 @llvm.vector.reduce.or.v2i16(<2 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i16 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v8i16 = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %v16i16 = call i16 @llvm.vector.reduce.or.v16i16(<16 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i8 = call i8 @llvm.vector.reduce.or.v2i8(<2 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i8 = call i8 @llvm.vector.reduce.or.v4i8(<4 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %v8i8 = call i8 @llvm.vector.reduce.or.v8i8(<8 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v16i8 = call i8 @llvm.vector.reduce.or.v16i8(<16 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %v32i8 = call i8 @llvm.vector.reduce.or.v32i8(<32 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-MVEI-LABEL: 'or'
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1i64 = call i64 @llvm.vector.reduce.or.v1i64(<1 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = call i64 @llvm.vector.reduce.or.v2i64(<2 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v4i64 = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i32 = call i32 @llvm.vector.reduce.or.v2i32(<2 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i32 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %v8i32 = call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i16 = call i16 @llvm.vector.reduce.or.v2i16(<2 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i16 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %v8i16 = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %v16i16 = call i16 @llvm.vector.reduce.or.v16i16(<16 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i8 = call i8 @llvm.vector.reduce.or.v2i8(<2 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i8 = call i8 @llvm.vector.reduce.or.v4i8(<4 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %v8i8 = call i8 @llvm.vector.reduce.or.v8i8(<8 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 31 for instruction: %v16i8 = call i8 @llvm.vector.reduce.or.v16i8(<16 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %v32i8 = call i8 @llvm.vector.reduce.or.v32i8(<32 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
entry:
  %v1i64 = call i64 @llvm.vector.reduce.or.v1i64(<1 x i64> undef)
  %v2i64 = call i64 @llvm.vector.reduce.or.v2i64(<2 x i64> undef)
  %v4i64 = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> undef)
  %v2i32 = call i32 @llvm.vector.reduce.or.v2i32(<2 x i32> undef)
  %v4i32 = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> undef)
  %v8i32 = call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> undef)
  %v2i16 = call i16 @llvm.vector.reduce.or.v2i16(<2 x i16> undef)
  %v4i16 = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> undef)
  %v8i16 = call i16 @llvm.vector.reduce.or.v8i16(<8 x i16> undef)
  %v16i16 = call i16 @llvm.vector.reduce.or.v16i16(<16 x i16> undef)
  %v2i8 = call i8 @llvm.vector.reduce.or.v2i8(<2 x i8> undef)
  %v4i8 = call i8 @llvm.vector.reduce.or.v4i8(<4 x i8> undef)
  %v8i8 = call i8 @llvm.vector.reduce.or.v8i8(<8 x i8> undef)
  %v16i8 = call i8 @llvm.vector.reduce.or.v16i8(<16 x i8> undef)
  %v32i8 = call i8 @llvm.vector.reduce.or.v32i8(<32 x i8> undef)
  ret void
}

define void @xor() {
; CHECK-V8-LABEL: 'xor'
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1i64 = call i64 @llvm.vector.reduce.xor.v1i64(<1 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i64 = call i64 @llvm.vector.reduce.xor.v2i64(<2 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v4i64 = call i64 @llvm.vector.reduce.xor.v4i64(<4 x i64> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i32 = call i32 @llvm.vector.reduce.xor.v2i32(<2 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v8i32 = call i32 @llvm.vector.reduce.xor.v8i32(<8 x i32> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i16 = call i16 @llvm.vector.reduce.xor.v2i16(<2 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i16 = call i16 @llvm.vector.reduce.xor.v4i16(<4 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v8i16 = call i16 @llvm.vector.reduce.xor.v8i16(<8 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %v16i16 = call i16 @llvm.vector.reduce.xor.v16i16(<16 x i16> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i8 = call i8 @llvm.vector.reduce.xor.v2i8(<2 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i8 = call i8 @llvm.vector.reduce.xor.v4i8(<4 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %v8i8 = call i8 @llvm.vector.reduce.xor.v8i8(<8 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v16i8 = call i8 @llvm.vector.reduce.xor.v16i8(<16 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %v32i8 = call i8 @llvm.vector.reduce.xor.v32i8(<32 x i8> undef)
; CHECK-V8-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-MVEI-LABEL: 'xor'
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1i64 = call i64 @llvm.vector.reduce.xor.v1i64(<1 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = call i64 @llvm.vector.reduce.xor.v2i64(<2 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v4i64 = call i64 @llvm.vector.reduce.xor.v4i64(<4 x i64> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i32 = call i32 @llvm.vector.reduce.xor.v2i32(<2 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i32 = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %v8i32 = call i32 @llvm.vector.reduce.xor.v8i32(<8 x i32> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i16 = call i16 @llvm.vector.reduce.xor.v2i16(<2 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i16 = call i16 @llvm.vector.reduce.xor.v4i16(<4 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %v8i16 = call i16 @llvm.vector.reduce.xor.v8i16(<8 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %v16i16 = call i16 @llvm.vector.reduce.xor.v16i16(<16 x i16> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v2i8 = call i8 @llvm.vector.reduce.xor.v2i8(<2 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v4i8 = call i8 @llvm.vector.reduce.xor.v4i8(<4 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %v8i8 = call i8 @llvm.vector.reduce.xor.v8i8(<8 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 31 for instruction: %v16i8 = call i8 @llvm.vector.reduce.xor.v16i8(<16 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %v32i8 = call i8 @llvm.vector.reduce.xor.v32i8(<32 x i8> undef)
; CHECK-MVEI-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
entry:
  %v1i64 = call i64 @llvm.vector.reduce.xor.v1i64(<1 x i64> undef)
  %v2i64 = call i64 @llvm.vector.reduce.xor.v2i64(<2 x i64> undef)
  %v4i64 = call i64 @llvm.vector.reduce.xor.v4i64(<4 x i64> undef)
  %v2i32 = call i32 @llvm.vector.reduce.xor.v2i32(<2 x i32> undef)
  %v4i32 = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> undef)
  %v8i32 = call i32 @llvm.vector.reduce.xor.v8i32(<8 x i32> undef)
  %v2i16 = call i16 @llvm.vector.reduce.xor.v2i16(<2 x i16> undef)
  %v4i16 = call i16 @llvm.vector.reduce.xor.v4i16(<4 x i16> undef)
  %v8i16 = call i16 @llvm.vector.reduce.xor.v8i16(<8 x i16> undef)
  %v16i16 = call i16 @llvm.vector.reduce.xor.v16i16(<16 x i16> undef)
  %v2i8 = call i8 @llvm.vector.reduce.xor.v2i8(<2 x i8> undef)
  %v4i8 = call i8 @llvm.vector.reduce.xor.v4i8(<4 x i8> undef)
  %v8i8 = call i8 @llvm.vector.reduce.xor.v8i8(<8 x i8> undef)
  %v16i8 = call i8 @llvm.vector.reduce.xor.v16i8(<16 x i8> undef)
  %v32i8 = call i8 @llvm.vector.reduce.xor.v32i8(<32 x i8> undef)
  ret void
}

declare i16 @llvm.vector.reduce.and.v16i16(<16 x i16>)
declare i16 @llvm.vector.reduce.and.v2i16(<2 x i16>)
declare i16 @llvm.vector.reduce.and.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.and.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.or.v16i16(<16 x i16>)
declare i16 @llvm.vector.reduce.or.v2i16(<2 x i16>)
declare i16 @llvm.vector.reduce.or.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.or.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.xor.v16i16(<16 x i16>)
declare i16 @llvm.vector.reduce.xor.v2i16(<2 x i16>)
declare i16 @llvm.vector.reduce.xor.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.xor.v8i16(<8 x i16>)
declare i32 @llvm.vector.reduce.and.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.and.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.and.v8i32(<8 x i32>)
declare i32 @llvm.vector.reduce.or.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.or.v8i32(<8 x i32>)
declare i32 @llvm.vector.reduce.xor.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.xor.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.xor.v8i32(<8 x i32>)
declare i64 @llvm.vector.reduce.and.v1i64(<1 x i64>)
declare i64 @llvm.vector.reduce.and.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.and.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.or.v1i64(<1 x i64>)
declare i64 @llvm.vector.reduce.or.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.or.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.xor.v1i64(<1 x i64>)
declare i64 @llvm.vector.reduce.xor.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.xor.v4i64(<4 x i64>)
declare i8 @llvm.vector.reduce.and.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.and.v32i8(<32 x i8>)
declare i8 @llvm.vector.reduce.and.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.and.v4i8(<4 x i8>)
declare i8 @llvm.vector.reduce.and.v2i8(<2 x i8>)
declare i8 @llvm.vector.reduce.or.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.or.v32i8(<32 x i8>)
declare i8 @llvm.vector.reduce.or.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.or.v4i8(<4 x i8>)
declare i8 @llvm.vector.reduce.or.v2i8(<2 x i8>)
declare i8 @llvm.vector.reduce.xor.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.xor.v32i8(<32 x i8>)
declare i8 @llvm.vector.reduce.xor.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.xor.v4i8(<4 x i8>)
declare i8 @llvm.vector.reduce.xor.v2i8(<2 x i8>)
