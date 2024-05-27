; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx1010 < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx90a < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa < %s | FileCheck -check-prefixes=ALL %s

; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx1010 < %s | FileCheck -check-prefixes=ALL-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx90a < %s | FileCheck -check-prefixes=ALL-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=ALL-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa < %s | FileCheck -check-prefixes=ALL-SIZE %s
; END.

define i32 @fcopysign(i32 %arg) {
; ALL-LABEL: 'fcopysign'
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F32 = call float @llvm.copysign.f32(float undef, float undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F32 = call <4 x float> @llvm.copysign.v4f32(<4 x float> undef, <4 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V8F32 = call <8 x float> @llvm.copysign.v8f32(<8 x float> undef, <8 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V16F32 = call <16 x float> @llvm.copysign.v16f32(<16 x float> undef, <16 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F64 = call double @llvm.copysign.f64(double undef, double undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = call <2 x double> @llvm.copysign.v2f64(<2 x double> undef, <2 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = call <4 x double> @llvm.copysign.v4f64(<4 x double> undef, <4 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V8F64 = call <8 x double> @llvm.copysign.v8f64(<8 x double> undef, <8 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret i32 undef
;
; ALL-SIZE-LABEL: 'fcopysign'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F32 = call float @llvm.copysign.f32(float undef, float undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F32 = call <4 x float> @llvm.copysign.v4f32(<4 x float> undef, <4 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V8F32 = call <8 x float> @llvm.copysign.v8f32(<8 x float> undef, <8 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V16F32 = call <16 x float> @llvm.copysign.v16f32(<16 x float> undef, <16 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F64 = call double @llvm.copysign.f64(double undef, double undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = call <2 x double> @llvm.copysign.v2f64(<2 x double> undef, <2 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = call <4 x double> @llvm.copysign.v4f64(<4 x double> undef, <4 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V8F64 = call <8 x double> @llvm.copysign.v8f64(<8 x double> undef, <8 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  %F32 = call float @llvm.copysign.f32(float undef, float undef)
  %V4F32 = call <4 x float> @llvm.copysign.v4f32(<4 x float> undef, <4 x float> undef)
  %V8F32 = call <8 x float> @llvm.copysign.v8f32(<8 x float> undef, <8 x float> undef)
  %V16F32 = call <16 x float> @llvm.copysign.v16f32(<16 x float> undef, <16 x float> undef)

  %F64 = call double @llvm.copysign.f64(double undef, double undef)
  %V2F64 = call <2 x double> @llvm.copysign.v2f64(<2 x double> undef, <2 x double> undef)
  %V4F64 = call <4 x double> @llvm.copysign.v4f64(<4 x double> undef, <4 x double> undef)
  %V8F64 = call <8 x double> @llvm.copysign.v8f64(<8 x double> undef, <8 x double> undef)

  ret i32 undef
}

define i32 @fsqrt(i32 %arg) {
; ALL-LABEL: 'fsqrt'
; ALL-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %F32 = call float @llvm.sqrt.f32(float undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4F32 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8F32 = call <8 x float> @llvm.sqrt.v8f32(<8 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16F32 = call <16 x float> @llvm.sqrt.v16f32(<16 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %F64 = call double @llvm.sqrt.f64(double undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2F64 = call <2 x double> @llvm.sqrt.v2f64(<2 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4F64 = call <4 x double> @llvm.sqrt.v4f64(<4 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8F64 = call <8 x double> @llvm.sqrt.v8f64(<8 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret i32 undef
;
; ALL-SIZE-LABEL: 'fsqrt'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %F32 = call float @llvm.sqrt.f32(float undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4F32 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8F32 = call <8 x float> @llvm.sqrt.v8f32(<8 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16F32 = call <16 x float> @llvm.sqrt.v16f32(<16 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %F64 = call double @llvm.sqrt.f64(double undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2F64 = call <2 x double> @llvm.sqrt.v2f64(<2 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4F64 = call <4 x double> @llvm.sqrt.v4f64(<4 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8F64 = call <8 x double> @llvm.sqrt.v8f64(<8 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  %F32 = call float @llvm.sqrt.f32(float undef)
  %V4F32 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> undef)
  %V8F32 = call <8 x float> @llvm.sqrt.v8f32(<8 x float> undef)
  %V16F32 = call <16 x float> @llvm.sqrt.v16f32(<16 x float> undef)

  %F64 = call double @llvm.sqrt.f64(double undef)
  %V2F64 = call <2 x double> @llvm.sqrt.v2f64(<2 x double> undef)
  %V4F64 = call <4 x double> @llvm.sqrt.v4f64(<4 x double> undef)
  %V8F64 = call <8 x double> @llvm.sqrt.v8f64(<8 x double> undef)

  ret i32 undef
}

declare float @llvm.copysign.f32(float, float)
declare <4 x float> @llvm.copysign.v4f32(<4 x float>, <4 x float>)
declare <8 x float> @llvm.copysign.v8f32(<8 x float>, <8 x float>)
declare <16 x float> @llvm.copysign.v16f32(<16 x float>, <16 x float>)

declare double @llvm.copysign.f64(double, double)
declare <2 x double> @llvm.copysign.v2f64(<2 x double>, <2 x double>)
declare <4 x double> @llvm.copysign.v4f64(<4 x double>, <4 x double>)
declare <8 x double> @llvm.copysign.v8f64(<8 x double>, <8 x double>)

declare float @llvm.sqrt.f32(float)
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>)
declare <8 x float> @llvm.sqrt.v8f32(<8 x float>)
declare <16 x float> @llvm.sqrt.v16f32(<16 x float>)

declare double @llvm.sqrt.f64(double)
declare <2 x double> @llvm.sqrt.v2f64(<2 x double>)
declare <4 x double> @llvm.sqrt.v4f64(<4 x double>)
declare <8 x double> @llvm.sqrt.v8f64(<8 x double>)
