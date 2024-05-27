; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mattr=+sse4.2 | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mattr=+avx | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mattr=+avx512f | FileCheck %s --check-prefixes=AVX512
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefixes=AVX512
;
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mcpu=slm | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mcpu=goldmont | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=x86_64-- -mcpu=btver2 | FileCheck %s --check-prefixes=AVX,AVX1

define i32 @f32(i32 %arg) {
; SSE-LABEL: 'f32'
; SSE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %F32 = call float @llvm.maxnum.f32(float undef, float undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2F32 = call <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F32 = call <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V8F32 = call <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V16F32 = call <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX1-LABEL: 'f32'
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %F32 = call float @llvm.maxnum.f32(float undef, float undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V2F32 = call <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V4F32 = call <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8F32 = call <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16F32 = call <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX2-LABEL: 'f32'
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %F32 = call float @llvm.maxnum.f32(float undef, float undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F32 = call <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F32 = call <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V8F32 = call <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V16F32 = call <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'f32'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %F32 = call float @llvm.maxnum.f32(float undef, float undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2F32 = call <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4F32 = call <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F32 = call <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F32 = call <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %F32 = call float @llvm.maxnum.f32(float undef, float undef)
  %V2F32 = call <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
  %V4F32 = call <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
  %V8F32 = call <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
  %V16F32 = call <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
  ret i32 undef
}

define i32 @f64(i32 %arg) {
; SSE-LABEL: 'f64'
; SSE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %f64 = call double @llvm.maxnum.f64(double undef, double undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2f64 = call <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4f64 = call <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8f64 = call <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16f64 = call <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX1-LABEL: 'f64'
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %f64 = call double @llvm.maxnum.f64(double undef, double undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V2f64 = call <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V4f64 = call <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V8f64 = call <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V16f64 = call <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX2-LABEL: 'f64'
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %f64 = call double @llvm.maxnum.f64(double undef, double undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2f64 = call <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V4f64 = call <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V8f64 = call <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V16f64 = call <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'f64'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %f64 = call double @llvm.maxnum.f64(double undef, double undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2f64 = call <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4f64 = call <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V8f64 = call <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V16f64 = call <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %f64 = call double @llvm.maxnum.f64(double undef, double undef)
  %V2f64 = call <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
  %V4f64 = call <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
  %V8f64 = call <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
  %V16f64 = call <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
  ret i32 undef
}

define i32 @f32_nnan(i32 %arg) {
; SSE-LABEL: 'f32_nnan'
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F32 = call nnan float @llvm.maxnum.f32(float undef, float undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2F32 = call nnan <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4F32 = call nnan <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F32 = call nnan <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F32 = call nnan <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX-LABEL: 'f32_nnan'
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F32 = call nnan float @llvm.maxnum.f32(float undef, float undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2F32 = call nnan <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4F32 = call nnan <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8F32 = call nnan <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16F32 = call nnan <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'f32_nnan'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F32 = call nnan float @llvm.maxnum.f32(float undef, float undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2F32 = call nnan <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4F32 = call nnan <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8F32 = call nnan <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16F32 = call nnan <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %F32 = call nnan float @llvm.maxnum.f32(float undef, float undef)
  %V2F32 = call nnan <2 x float> @llvm.maxnum.v2f32(<2 x float> undef, <2 x float> undef)
  %V4F32 = call nnan <4 x float> @llvm.maxnum.v4f32(<4 x float> undef, <4 x float> undef)
  %V8F32 = call nnan <8 x float> @llvm.maxnum.v8f32(<8 x float> undef, <8 x float> undef)
  %V16F32 = call nnan <16 x float> @llvm.maxnum.v16f32(<16 x float> undef, <16 x float> undef)
  ret i32 undef
}

define i32 @f64_nnan(i32 %arg) {
; SSE-LABEL: 'f64_nnan'
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f64 = call nnan double @llvm.maxnum.f64(double undef, double undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2f64 = call nnan <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4f64 = call nnan <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8f64 = call nnan <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V16f64 = call nnan <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX-LABEL: 'f64_nnan'
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f64 = call nnan double @llvm.maxnum.f64(double undef, double undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2f64 = call nnan <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4f64 = call nnan <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8f64 = call nnan <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16f64 = call nnan <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'f64_nnan'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f64 = call nnan double @llvm.maxnum.f64(double undef, double undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2f64 = call nnan <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4f64 = call nnan <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8f64 = call nnan <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16f64 = call nnan <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %f64 = call nnan double @llvm.maxnum.f64(double undef, double undef)
  %V2f64 = call nnan <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> undef)
  %V4f64 = call nnan <4 x double> @llvm.maxnum.v4f64(<4 x double> undef, <4 x double> undef)
  %V8f64 = call nnan <8 x double> @llvm.maxnum.v8f64(<8 x double> undef, <8 x double> undef)
  %V16f64 = call nnan <16 x double> @llvm.maxnum.v16f64(<16 x double> undef, <16 x double> undef)
  ret i32 undef
}

declare float @llvm.maxnum.f32(float, float)
declare <2 x float> @llvm.maxnum.v2f32(<2 x float>, <2 x float>)
declare <4 x float> @llvm.maxnum.v4f32(<4 x float>, <4 x float>)
declare <8 x float> @llvm.maxnum.v8f32(<8 x float>, <8 x float>)
declare <16 x float> @llvm.maxnum.v16f32(<16 x float>, <16 x float>)

declare double @llvm.maxnum.f64(double, double)
declare <2 x double> @llvm.maxnum.v2f64(<2 x double>, <2 x double>)
declare <4 x double> @llvm.maxnum.v4f64(<4 x double>, <4 x double>)
declare <8 x double> @llvm.maxnum.v8f64(<8 x double>, <8 x double>)
declare <16 x double> @llvm.maxnum.v16f64(<16 x double>, <16 x double>)
