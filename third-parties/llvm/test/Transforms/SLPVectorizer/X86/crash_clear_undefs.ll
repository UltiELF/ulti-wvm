; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=x86_64-- -mcpu=corei7 -pass-remarks-output=%t | FileCheck %s
; RUN: FileCheck %s --input-file=%t --check-prefix=YAML
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

; YAML-LABEL: --- !Passed
; YAML-NEXT:  Pass:            slp-vectorizer
; YAML-NEXT:  Name:            VectorizedList
; YAML-NEXT:  Function:        foo
; YAML-NEXT:  Args:
; YAML-NEXT:    - String:          'SLP vectorized with cost '
; YAML-NEXT:    - Cost:            '-4'
; YAML-NEXT:    - String:          ' and with tree size '
; YAML-NEXT:    - TreeSize:        '10'
; YAML-NEXT:  ...
define i1 @foo() {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr null, align 4
; CHECK-NEXT:    br i1 false, label [[TMP11:%.*]], label [[TMP2:%.*]]
; CHECK:       2:
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x float> <float undef, float 0.000000e+00>, float [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = fadd <2 x float> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x float> [[TMP3]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[TMP7:%.*]] = select <4 x i1> zeroinitializer, <4 x float> [[TMP5]], <4 x float> [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = fadd <4 x float> [[TMP7]], zeroinitializer
; CHECK-NEXT:    [[TMP9:%.*]] = fsub <4 x float> [[TMP7]], zeroinitializer
; CHECK-NEXT:    [[TMP10:%.*]] = shufflevector <4 x float> [[TMP8]], <4 x float> [[TMP9]], <4 x i32> <i32 0, i32 1, i32 6, i32 7>
; CHECK-NEXT:    br label [[TMP11]]
; CHECK:       11:
; CHECK-NEXT:    [[TMP12:%.*]] = phi <4 x float> [ [[TMP10]], [[TMP2]] ], [ zeroinitializer, [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i1 false
;
  %1 = load float, ptr null, align 4
  br i1 false, label %14, label %2

2:                                                ; preds = %0
  %3 = extractelement <4 x float> zeroinitializer, i64 0
  %4 = fadd float %1, 0.000000e+00
  %5 = fadd float %3, 0.000000e+00
  %6 = select i1 false, float %4, float %1
  %7 = fsub float %6, 0.000000e+00
  %8 = select i1 false, float %5, float %3
  %9 = fsub float %8, 0.000000e+00
  %10 = select i1 false, float %4, float %1
  %11 = fadd float 0.000000e+00, %10
  %12 = select i1 false, float %5, float %3
  %13 = fadd float 0.000000e+00, %12
  br label %14

14:                                               ; preds = %2, %0
  %15 = phi float [ %7, %2 ], [ 0.000000e+00, %0 ]
  %16 = phi float [ %9, %2 ], [ 0.000000e+00, %0 ]
  %17 = phi float [ %11, %2 ], [ 0.000000e+00, %0 ]
  %18 = phi float [ %13, %2 ], [ 0.000000e+00, %0 ]
  ret i1 false
}
