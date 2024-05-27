; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s  -passes="print<cost-model>" 2>&1 -disable-output -mtriple=arm64-apple-ios -mcpu=cyclone | FileCheck %s --check-prefix=CHECK-THROUGHPUT
; RUN: opt < %s  -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=code-size -mtriple=aarch64-- | FileCheck %s --check-prefix=CHECK-SIZE
target datalayout = "e-p:32:32:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:32:64-v128:32:128-a0:0:32-n32-S32"

define void @select() {
    ; Scalar values
; CHECK-THROUGHPUT-LABEL: 'select'
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1 = select i1 undef, i8 undef, i8 undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2 = select i1 undef, i16 undef, i16 undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v3 = select i1 undef, i32 undef, i32 undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v4 = select i1 undef, i64 undef, i64 undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v5 = select i1 undef, float undef, float undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v6 = select i1 undef, double undef, double undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v13b = select <16 x i1> undef, <16 x i16> undef, <16 x i16> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v15b = select <8 x i1> undef, <8 x i32> undef, <8 x i32> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v15c = select <16 x i1> undef, <16 x i32> undef, <16 x i32> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 80 for instruction: %v16a = select <4 x i1> undef, <4 x i64> undef, <4 x i64> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 160 for instruction: %v16b = select <8 x i1> undef, <8 x i64> undef, <8 x i64> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 320 for instruction: %v16c = select <16 x i1> undef, <16 x i64> undef, <16 x i64> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2float = select <2 x i1> undef, <2 x float> undef, <2 x float> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4float = select <4 x i1> undef, <4 x float> undef, <4 x float> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2double = select <2 x i1> undef, <2 x double> undef, <2 x double> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4half = select <4 x i1> undef, <4 x half> undef, <4 x half> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v8half = select <8 x i1> undef, <8 x half> undef, <8 x half> undef
; CHECK-THROUGHPUT-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-SIZE-LABEL: 'select'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v1 = select i1 undef, i8 undef, i8 undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2 = select i1 undef, i16 undef, i16 undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v3 = select i1 undef, i32 undef, i32 undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v4 = select i1 undef, i64 undef, i64 undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v5 = select i1 undef, float undef, float undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v6 = select i1 undef, double undef, double undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v13b = select <16 x i1> undef, <16 x i16> undef, <16 x i16> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v15b = select <8 x i1> undef, <8 x i32> undef, <8 x i32> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v15c = select <16 x i1> undef, <16 x i32> undef, <16 x i32> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v16a = select <4 x i1> undef, <4 x i64> undef, <4 x i64> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v16b = select <8 x i1> undef, <8 x i64> undef, <8 x i64> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v16c = select <16 x i1> undef, <16 x i64> undef, <16 x i64> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2float = select <2 x i1> undef, <2 x float> undef, <2 x float> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v4float = select <4 x i1> undef, <4 x float> undef, <4 x float> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2double = select <2 x i1> undef, <2 x double> undef, <2 x double> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v4half = select <4 x i1> undef, <4 x half> undef, <4 x half> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v8half = select <8 x i1> undef, <8 x half> undef, <8 x half> undef
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %v1 = select i1 undef, i8 undef, i8 undef
  %v2 = select i1 undef, i16 undef, i16 undef
  %v3 = select i1 undef, i32 undef, i32 undef
  %v4 = select i1 undef, i64 undef, i64 undef
  %v5 = select i1 undef, float undef, float undef
  %v6 = select i1 undef, double undef, double undef

  %v13b = select <16 x i1>  undef, <16 x i16> undef, <16 x i16> undef

  %v15b = select <8 x i1>  undef, <8 x i32> undef, <8 x i32> undef
  %v15c = select <16 x i1>  undef, <16 x i32> undef, <16 x i32> undef

  ; Vector values - check for vectors of i64s that have a high cost because
  ; they end up scalarized.
  %v16a = select <4 x i1> undef, <4 x i64> undef, <4 x i64> undef
  %v16b = select <8 x i1> undef, <8 x i64> undef, <8 x i64> undef
  %v16c = select <16 x i1> undef, <16 x i64> undef, <16 x i64> undef

  ; simd vector float
  %v2float = select <2 x i1> undef, <2 x float> undef, <2 x float> undef
  %v4float = select <4 x i1> undef, <4 x float> undef, <4 x float> undef
  %v2double = select <2 x i1> undef, <2 x double> undef, <2 x double> undef
  %v4half = select <4 x i1> undef, <4 x half> undef, <4 x half> undef
  %v8half = select <8 x i1> undef, <8 x half> undef, <8 x half> undef
  ret void
}
