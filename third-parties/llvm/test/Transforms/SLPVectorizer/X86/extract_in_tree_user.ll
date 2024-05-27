; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=i386-apple-macosx10.9.0 -mcpu=corei7-avx | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

@a = common global ptr null, align 8

; Function Attrs: nounwind ssp uwtable
define i32 @fn1() {
; CHECK-LABEL: @fn1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr @a, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x ptr> poison, ptr [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x ptr> [[TMP1]], <2 x ptr> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i64, <2 x ptr> [[TMP2]], <2 x i64> <i64 11, i64 56>
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x ptr> [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = ptrtoint <2 x ptr> [[TMP3]] to <2 x i64>
; CHECK-NEXT:    store <2 x i64> [[TMP5]], ptr [[TMP4]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %0 = load ptr, ptr @a, align 8
  %add.ptr = getelementptr inbounds i64, ptr %0, i64 11
  %1 = ptrtoint ptr %add.ptr to i64
  store i64 %1, ptr %add.ptr, align 8
  %add.ptr1 = getelementptr inbounds i64, ptr %0, i64 56
  %2 = ptrtoint ptr %add.ptr1 to i64
  %arrayidx2 = getelementptr inbounds i64, ptr %0, i64 12
  store i64 %2, ptr %arrayidx2, align 8
  ret i32 undef
}

declare float @llvm.powi.f32.i32(float, i32)
define void @fn2(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: @fn2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, ptr [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[B:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = add <4 x i32> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i32> [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = sitofp <4 x i32> [[TMP2]] to <4 x float>
; CHECK-NEXT:    [[TMP5:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[TMP4]], i32 [[TMP3]])
; CHECK-NEXT:    store <4 x float> [[TMP5]], ptr [[C:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i0 = load i32, ptr %a, align 4
  %i1 = load i32, ptr %b, align 4
  %add1 = add i32 %i0, %i1
  %fp1 = sitofp i32 %add1 to float
  %call1 = tail call float @llvm.powi.f32.i32(float %fp1,i32 %add1) nounwind readnone

  %arrayidx2 = getelementptr inbounds i32, ptr %a, i32 1
  %i2 = load i32, ptr %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds i32, ptr %b, i32 1
  %i3 = load i32, ptr %arrayidx3, align 4
  %add2 = add i32 %i2, %i3
  %fp2 = sitofp i32 %add2 to float
  %call2 = tail call float @llvm.powi.f32.i32(float %fp2,i32 %add1) nounwind readnone

  %arrayidx4 = getelementptr inbounds i32, ptr %a, i32 2
  %i4 = load i32, ptr %arrayidx4, align 4
  %arrayidx5 = getelementptr inbounds i32, ptr %b, i32 2
  %i5 = load i32, ptr %arrayidx5, align 4
  %add3 = add i32 %i4, %i5
  %fp3 = sitofp i32 %add3 to float
  %call3 = tail call float @llvm.powi.f32.i32(float %fp3,i32 %add1) nounwind readnone

  %arrayidx6 = getelementptr inbounds i32, ptr %a, i32 3
  %i6 = load i32, ptr %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds i32, ptr %b, i32 3
  %i7 = load i32, ptr %arrayidx7, align 4
  %add4 = add i32 %i6, %i7
  %fp4 = sitofp i32 %add4 to float
  %call4 = tail call float @llvm.powi.f32.i32(float %fp4,i32 %add1) nounwind readnone

  store float %call1, ptr %c, align 4
  %arrayidx8 = getelementptr inbounds float, ptr %c, i32 1
  store float %call2, ptr %arrayidx8, align 4
  %arrayidx9 = getelementptr inbounds float, ptr %c, i32 2
  store float %call3, ptr %arrayidx9, align 4
  %arrayidx10 = getelementptr inbounds float, ptr %c, i32 3
  store float %call4, ptr %arrayidx10, align 4
  ret void

}

define void @externally_used_ptrs() {
; CHECK-LABEL: @externally_used_ptrs(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr @a, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x ptr> poison, ptr [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x ptr> [[TMP1]], <2 x ptr> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i64, <2 x ptr> [[TMP2]], <2 x i64> <i64 56, i64 11>
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x ptr> [[TMP3]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = ptrtoint <2 x ptr> [[TMP3]] to <2 x i64>
; CHECK-NEXT:    [[TMP6:%.*]] = load <2 x i64>, ptr [[TMP4]], align 8
; CHECK-NEXT:    [[TMP7:%.*]] = add <2 x i64> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    store <2 x i64> [[TMP7]], ptr [[TMP4]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %0 = load ptr, ptr @a, align 8
  %add.ptr = getelementptr inbounds i64, ptr %0, i64 11
  %1 = ptrtoint ptr %add.ptr to i64
  %add.ptr1 = getelementptr inbounds i64, ptr %0, i64 56
  %2 = ptrtoint ptr %add.ptr1 to i64
  %arrayidx2 = getelementptr inbounds i64, ptr %0, i64 12
  %3 = load i64, ptr %arrayidx2, align 8
  %4 = load i64, ptr %add.ptr, align 8
  %5 = add i64 %1, %3
  %6 = add i64 %2, %4
  store i64 %6, ptr %add.ptr, align 8
  store i64 %5, ptr %arrayidx2, align 8
  ret void
}
