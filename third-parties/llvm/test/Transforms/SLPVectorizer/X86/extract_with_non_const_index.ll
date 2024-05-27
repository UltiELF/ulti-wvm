; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -passes=slp-vectorizer -S | FileCheck %s

; Reproducer for an issue discussed here:
; https://reviews.llvm.org/D108703#2974289

define void @test(ptr nocapture %o, ptr nocapture nonnull readonly dereferenceable(8) %a, ptr nocapture nonnull readonly dereferenceable(8) %b, i32 signext %component) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x float>, ptr [[A:%.*]], align 1
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x float>, ptr [[B:%.*]], align 1
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i32 [[COMPONENT:%.*]] to i8
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> [[TMP1]], <2 x float> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 2, i32 3, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <8 x float> [[TMP5]], i8 [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x float> undef, float [[TMP6]], i64 0
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x float> [[TMP3]], i32 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x float> [[TMP7]], float [[TMP8]], i64 1
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x float> [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x float> [[TMP9]], float [[TMP10]], i64 2
; CHECK-NEXT:    [[TMP12:%.*]] = insertelement <4 x float> [[TMP11]], float [[TMP6]], i64 3
; CHECK-NEXT:    store <4 x float> [[TMP12]], ptr [[O:%.*]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <2 x float>, ptr %a, align 1
  %1 = load <2 x float>, ptr %b, align 1
  %2 = trunc i32 %component to i8
  %3 = shufflevector <2 x float> %0, <2 x float> %1, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 2, i32 3, i32 undef, i32 undef>
  %4 = extractelement <8 x float> %3, i8 %2
  %5 = insertelement <4 x float> undef, float %4, i64 0
  %6 = extractelement <2 x float> %1, i32 1
  %7 = insertelement <4 x float> %5, float %6, i64 1
  %8 = extractelement <2 x float> %0, i32 1
  %9 = insertelement <4 x float> %7, float %8, i64 2
  %10 = insertelement <4 x float> %9, float %4, i64 3
  store <4 x float> %10, ptr %o, align 1
  ret void
}
