; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-darwin"

declare void @use(double)

; The extracts %v1.lane.0 and %v1.lane.1 should be considered free during SLP,
; because they will be directly in a vector register on AArch64.
define void @noop_extracts_first_2_lanes(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @noop_extracts_first_2_lanes(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <2 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = fmul <2 x double> [[V_1]], [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[V_1]], i32 0
; CHECK-NEXT:    call void @use(double [[TMP2]])
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x double> [[V_1]], i32 1
; CHECK-NEXT:    call void @use(double [[TMP3]])
; CHECK-NEXT:    store <2 x double> [[TMP1]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <2 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <2 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <2 x double> %v.1, i32 1

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2
  %v2.lane.3 = extractelement <4 x double> %v.2, i32 3

  %a.lane.0 = fmul double %v1.lane.0, %v2.lane.2
  %a.lane.1 = fmul double %v1.lane.1, %v2.lane.3

  %a.ins.0 = insertelement <2 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <2 x double> %a.ins.0, double %a.lane.1, i32 1

  call void @use(double %v1.lane.0)
  call void @use(double %v1.lane.1)

  store <2 x double> %a.ins.1, ptr %ptr.1, align 8
  ret void
}

; Extracts of consecutive indices, but different vector operand.
define void @extracts_first_2_lanes_different_vectors(ptr %ptr.1, ptr %ptr.2, ptr %ptr.3) {
; CHECK-LABEL: @extracts_first_2_lanes_different_vectors(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <2 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_0:%.*]] = extractelement <2 x double> [[V_1]], i32 0
; CHECK-NEXT:    [[V_3:%.*]] = load <2 x double>, ptr [[PTR_3:%.*]], align 8
; CHECK-NEXT:    [[V3_LANE_1:%.*]] = extractelement <2 x double> [[V_3]], i32 1
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <2 x double> [[V_1]], <2 x double> [[V_3]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <2 x i32> <i32 2, i32 2>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <2 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    call void @use(double [[V1_LANE_0]])
; CHECK-NEXT:    call void @use(double [[V3_LANE_1]])
; CHECK-NEXT:    store <2 x double> [[TMP2]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <2 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <2 x double> %v.1, i32 0
  %v.3 = load <2 x double>, ptr %ptr.3, align 8
  %v3.lane.1 = extractelement <2 x double> %v.3, i32 1

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.0, %v2.lane.2
  %a.lane.1 = fmul double %v3.lane.1, %v2.lane.2

  %a.ins.0 = insertelement <2 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <2 x double> %a.ins.0, double %a.lane.1, i32 1

  call void @use(double %v1.lane.0)
  call void @use(double %v3.lane.1)

  store <2 x double> %a.ins.1, ptr %ptr.1, align 8
  ret void
}

; The extracts %v1.lane.2 and %v1.lane.3 should be considered free during SLP,
; because they will be directly in a vector register on AArch64.
define void @noop_extract_second_2_lanes(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @noop_extract_second_2_lanes(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <4 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <4 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V1_LANE_3:%.*]] = extractelement <4 x double> [[V_1]], i32 3
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <4 x double> [[V_1]], <4 x double> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <2 x i32> <i32 2, i32 2>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <2 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    call void @use(double [[V1_LANE_2]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_3]])
; CHECK-NEXT:    store <4 x double> [[TMP3]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <4 x double>, ptr %ptr.1, align 8
  %v1.lane.2 = extractelement <4 x double> %v.1, i32 2
  %v1.lane.3 = extractelement <4 x double> %v.1, i32 3

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.2, %v2.lane.2
  %a.lane.1 = fmul double %v1.lane.3, %v2.lane.2

  %a.ins.0 = insertelement <4 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <4 x double> %a.ins.0, double %a.lane.1, i32 1

  call void @use(double %v1.lane.2)
  call void @use(double %v1.lane.3)
  store <4 x double> %a.ins.1, ptr %ptr.1, align 8
  ret void
}

; %v1.lane.0 and %v1.lane.1 are used in reverse-order, so they won't be
; directly in a vector register on AArch64.
define void @extract_reverse_order(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @extract_reverse_order(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <2 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <2 x i32> <i32 2, i32 2>
; CHECK-NEXT:    [[TMP1:%.*]] = fmul <2 x double> [[V_1]], [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x double> [[TMP1]], <2 x double> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x double> [[V_1]], i32 0
; CHECK-NEXT:    call void @use(double [[TMP3]])
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[V_1]], i32 1
; CHECK-NEXT:    call void @use(double [[TMP4]])
; CHECK-NEXT:    store <2 x double> [[TMP2]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <2 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <2 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <2 x double> %v.1, i32 1

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.1, %v2.lane.2
  %a.lane.1 = fmul double %v1.lane.0, %v2.lane.2

  %a.ins.0 = insertelement <2 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <2 x double> %a.ins.0, double %a.lane.1, i32 1

  call void @use(double %v1.lane.0)
  call void @use(double %v1.lane.1)

  store <2 x double> %a.ins.1, ptr %ptr.1, align 8
  ret void
}

; %v1.lane.1 and %v1.lane.2 are extracted from different vector registers on AArch64.
define void @extract_lanes_1_and_2(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @extract_lanes_1_and_2(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <4 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_1:%.*]] = extractelement <4 x double> [[V_1]], i32 1
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <4 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <4 x double> [[V_1]], <4 x double> poison, <2 x i32> <i32 1, i32 2>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <2 x i32> <i32 2, i32 2>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <2 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    call void @use(double [[V1_LANE_1]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_2]])
; CHECK-NEXT:    store <4 x double> [[TMP3]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <4 x double>, ptr %ptr.1, align 8
  %v1.lane.1 = extractelement <4 x double> %v.1, i32 1
  %v1.lane.2 = extractelement <4 x double> %v.1, i32 2

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.1, %v2.lane.2
  %a.lane.1 = fmul double %v1.lane.2, %v2.lane.2

  %a.ins.0 = insertelement <4 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <4 x double> %a.ins.0, double %a.lane.1, i32 1

  call void @use(double %v1.lane.1)
  call void @use(double %v1.lane.2)

  store <4 x double> %a.ins.1, ptr %ptr.1, align 8
  ret void
}

; More complex case where the extracted lanes are directly from a vector
; register on AArch64 and should be considered free, because we can
; directly use the source vector register.
define void @noop_extracts_existing_vector_4_lanes(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @noop_extracts_existing_vector_4_lanes(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <9 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_0:%.*]] = extractelement <9 x double> [[V_1]], i32 0
; CHECK-NEXT:    [[V1_LANE_1:%.*]] = extractelement <9 x double> [[V_1]], i32 1
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <9 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V1_LANE_3:%.*]] = extractelement <9 x double> [[V_1]], i32 3
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[V2_LANE_1:%.*]] = extractelement <4 x double> [[V_2]], i32 1
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <4 x i32> <i32 2, i32 0, i32 2, i32 2>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <4 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x double> [[TMP2]], <4 x double> undef, <9 x i32> <i32 2, i32 3, i32 0, i32 1, i32 4, i32 5, i32 6, i32 7, i32 7>
; CHECK-NEXT:    call void @use(double [[V1_LANE_0]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_1]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_2]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_3]])
; CHECK-NEXT:    store <9 x double> [[TMP3]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <9 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <9 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <9 x double> %v.1, i32 1
  %v1.lane.2 = extractelement <9 x double> %v.1, i32 2
  %v1.lane.3 = extractelement <9 x double> %v.1, i32 3
  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.0 = extractelement <4 x double> %v.2, i32 0
  %v2.lane.1 = extractelement <4 x double> %v.2, i32 1
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2
  %a.lane.0 = fmul double %v1.lane.2, %v2.lane.2
  %a.lane.1 = fmul double %v1.lane.3, %v2.lane.2
  %a.lane.2 = fmul double %v1.lane.0, %v2.lane.2
  %a.lane.3 = fmul double %v1.lane.1, %v2.lane.0
  %a.ins.0 = insertelement <9 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <9 x double> %a.ins.0, double %a.lane.1, i32 1
  %a.ins.2 = insertelement <9 x double> %a.ins.1, double %a.lane.2, i32 2
  %a.ins.3 = insertelement <9 x double> %a.ins.2, double %a.lane.3, i32 3
  call void @use(double %v1.lane.0)
  call void @use(double %v1.lane.1)
  call void @use(double %v1.lane.2)
  call void @use(double %v1.lane.3)
  store <9 x double> %a.ins.3, ptr %ptr.1, align 8
  ret void
}

; Extracted lanes are not used in the right order, so we cannot reuse the
; source vector registers directly.
define void @extracts_jumbled_4_lanes(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @extracts_jumbled_4_lanes(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <9 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_0:%.*]] = extractelement <9 x double> [[V_1]], i32 0
; CHECK-NEXT:    [[V1_LANE_1:%.*]] = extractelement <9 x double> [[V_1]], i32 1
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <9 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V1_LANE_3:%.*]] = extractelement <9 x double> [[V_1]], i32 3
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <4 x i32> <i32 2, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <4 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x double> [[TMP2]], <4 x double> undef, <9 x i32> <i32 0, i32 2, i32 1, i32 3, i32 4, i32 5, i32 6, i32 7, i32 7>
; CHECK-NEXT:    call void @use(double [[V1_LANE_0]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_1]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_2]])
; CHECK-NEXT:    call void @use(double [[V1_LANE_3]])
; CHECK-NEXT:    store <9 x double> [[TMP3]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <9 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <9 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <9 x double> %v.1, i32 1
  %v1.lane.2 = extractelement <9 x double> %v.1, i32 2
  %v1.lane.3 = extractelement <9 x double> %v.1, i32 3
  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.0 = extractelement <4 x double> %v.2, i32 0
  %v2.lane.1 = extractelement <4 x double> %v.2, i32 1
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2
  %a.lane.0 = fmul double %v1.lane.0, %v2.lane.2
  %a.lane.1 = fmul double %v1.lane.2, %v2.lane.1
  %a.lane.2 = fmul double %v1.lane.1, %v2.lane.2
  %a.lane.3 = fmul double %v1.lane.3, %v2.lane.0
  %a.ins.0 = insertelement <9 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <9 x double> %a.ins.0, double %a.lane.1, i32 1
  %a.ins.2 = insertelement <9 x double> %a.ins.1, double %a.lane.2, i32 2
  %a.ins.3 = insertelement <9 x double> %a.ins.2, double %a.lane.3, i32 3
  call void @use(double %v1.lane.0)
  call void @use(double %v1.lane.1)
  call void @use(double %v1.lane.2)
  call void @use(double %v1.lane.3)
  store <9 x double> %a.ins.3, ptr %ptr.1, align 8
  ret void
}


; Even more complex case where the extracted lanes are directly from a vector
; register on AArch64 and should be considered free, because we can
; directly use the source vector register.
define void @noop_extracts_9_lanes(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @noop_extracts_9_lanes(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <9 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <9 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V1_LANE_5:%.*]] = extractelement <9 x double> [[V_1]], i32 5
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[V2_LANE_0:%.*]] = extractelement <4 x double> [[V_2]], i32 0
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <8 x i32> <i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 0, i32 1>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <8 x i32> <i32 0, i32 2, i32 1, i32 0, i32 2, i32 0, i32 2, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <8 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[A_LANE_8:%.*]] = fmul double [[V1_LANE_2]], [[V2_LANE_0]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x double> [[TMP2]], <8 x double> poison, <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison>
; CHECK-NEXT:    [[A_INS_8:%.*]] = insertelement <9 x double> [[TMP3]], double [[A_LANE_8]], i32 8
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <8 x i32> <i32 6, i32 7, i32 8, i32 0, i32 1, i32 2, i32 3, i32 4>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <8 x i32> <i32 2, i32 1, i32 0, i32 2, i32 1, i32 0, i32 2, i32 1>
; CHECK-NEXT:    [[TMP6:%.*]] = fmul <8 x double> [[TMP4]], [[TMP5]]
; CHECK-NEXT:    [[B_LANE_8:%.*]] = fmul double [[V1_LANE_5]], [[V2_LANE_0]]
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <8 x double> [[TMP6]], <8 x double> poison, <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison>
; CHECK-NEXT:    [[B_INS_8:%.*]] = insertelement <9 x double> [[TMP7]], double [[B_LANE_8]], i32 8
; CHECK-NEXT:    [[RES:%.*]] = fsub <9 x double> [[A_INS_8]], [[B_INS_8]]
; CHECK-NEXT:    store <9 x double> [[RES]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <9 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <9 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <9 x double> %v.1, i32 1
  %v1.lane.2 = extractelement <9 x double> %v.1, i32 2
  %v1.lane.3 = extractelement <9 x double> %v.1, i32 3
  %v1.lane.4 = extractelement <9 x double> %v.1, i32 4
  %v1.lane.5 = extractelement <9 x double> %v.1, i32 5
  %v1.lane.6 = extractelement <9 x double> %v.1, i32 6
  %v1.lane.7 = extractelement <9 x double> %v.1, i32 7
  %v1.lane.8 = extractelement <9 x double> %v.1, i32 8

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.0 = extractelement <4 x double> %v.2, i32 0
  %v2.lane.1 = extractelement <4 x double> %v.2, i32 1
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.3, %v2.lane.0
  %a.lane.1 = fmul double %v1.lane.4, %v2.lane.2
  %a.lane.2 = fmul double %v1.lane.5, %v2.lane.1
  %a.lane.3 = fmul double %v1.lane.6, %v2.lane.0
  %a.lane.4 = fmul double %v1.lane.7, %v2.lane.2
  %a.lane.5 = fmul double %v1.lane.8, %v2.lane.0
  %a.lane.6 = fmul double %v1.lane.0, %v2.lane.2
  %a.lane.7 = fmul double %v1.lane.1, %v2.lane.1
  %a.lane.8 = fmul double %v1.lane.2, %v2.lane.0

  %a.ins.0 = insertelement <9 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <9 x double> %a.ins.0, double %a.lane.1, i32 1
  %a.ins.2 = insertelement <9 x double> %a.ins.1, double %a.lane.2, i32 2
  %a.ins.3 = insertelement <9 x double> %a.ins.2, double %a.lane.3, i32 3
  %a.ins.4 = insertelement <9 x double> %a.ins.3, double %a.lane.4, i32 4
  %a.ins.5 = insertelement <9 x double> %a.ins.4, double %a.lane.5, i32 5
  %a.ins.6 = insertelement <9 x double> %a.ins.5, double %a.lane.6, i32 6
  %a.ins.7 = insertelement <9 x double> %a.ins.6, double %a.lane.7, i32 7
  %a.ins.8 = insertelement <9 x double> %a.ins.7, double %a.lane.8, i32 8

  %b.lane.0 = fmul double %v1.lane.6, %v2.lane.2
  %b.lane.1 = fmul double %v1.lane.7, %v2.lane.1
  %b.lane.2 = fmul double %v1.lane.8, %v2.lane.0
  %b.lane.3 = fmul double %v1.lane.0, %v2.lane.2
  %b.lane.4 = fmul double %v1.lane.1, %v2.lane.1
  %b.lane.5 = fmul double %v1.lane.2, %v2.lane.0
  %b.lane.6 = fmul double %v1.lane.3, %v2.lane.2
  %b.lane.7 = fmul double %v1.lane.4, %v2.lane.1
  %b.lane.8 = fmul double %v1.lane.5, %v2.lane.0

  %b.ins.0 = insertelement <9 x double> undef, double %b.lane.0, i32 0
  %b.ins.1 = insertelement <9 x double> %b.ins.0, double %b.lane.1, i32 1
  %b.ins.2 = insertelement <9 x double> %b.ins.1, double %b.lane.2, i32 2
  %b.ins.3 = insertelement <9 x double> %b.ins.2, double %b.lane.3, i32 3
  %b.ins.4 = insertelement <9 x double> %b.ins.3, double %b.lane.4, i32 4
  %b.ins.5 = insertelement <9 x double> %b.ins.4, double %b.lane.5, i32 5
  %b.ins.6 = insertelement <9 x double> %b.ins.5, double %b.lane.6, i32 6
  %b.ins.7 = insertelement <9 x double> %b.ins.6, double %b.lane.7, i32 7
  %b.ins.8 = insertelement <9 x double> %b.ins.7, double %b.lane.8, i32 8

  %res = fsub <9 x double> %a.ins.8, %b.ins.8
  store <9 x double> %res, ptr %ptr.1, align 8
  ret void
}

; Extracted lanes used in first fmul chain are not used in the right order, so
; we cannot reuse the source vector registers directly.
define void @first_mul_chain_jumbled(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @first_mul_chain_jumbled(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <9 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <9 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V1_LANE_5:%.*]] = extractelement <9 x double> [[V_1]], i32 5
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[V2_LANE_0:%.*]] = extractelement <4 x double> [[V_2]], i32 0
; CHECK-NEXT:    [[V2_LANE_1:%.*]] = extractelement <4 x double> [[V_2]], i32 1
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <8 x i32> <i32 4, i32 3, i32 6, i32 5, i32 8, i32 7, i32 1, i32 0>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <8 x i32> <i32 1, i32 0, i32 2, i32 0, i32 2, i32 1, i32 0, i32 2>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <8 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[A_LANE_8:%.*]] = fmul double [[V1_LANE_2]], [[V2_LANE_1]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x double> [[TMP2]], <8 x double> poison, <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison>
; CHECK-NEXT:    [[A_INS_8:%.*]] = insertelement <9 x double> [[TMP3]], double [[A_LANE_8]], i32 8
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <8 x i32> <i32 6, i32 7, i32 8, i32 0, i32 1, i32 2, i32 3, i32 4>
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <8 x double> [[TMP4]], [[TMP1]]
; CHECK-NEXT:    [[B_LANE_8:%.*]] = fmul double [[V1_LANE_5]], [[V2_LANE_0]]
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <8 x double> [[TMP5]], <8 x double> poison, <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison>
; CHECK-NEXT:    [[B_INS_8:%.*]] = insertelement <9 x double> [[TMP6]], double [[B_LANE_8]], i32 8
; CHECK-NEXT:    [[RES:%.*]] = fsub <9 x double> [[A_INS_8]], [[B_INS_8]]
; CHECK-NEXT:    store <9 x double> [[RES]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <9 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <9 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <9 x double> %v.1, i32 1
  %v1.lane.2 = extractelement <9 x double> %v.1, i32 2
  %v1.lane.3 = extractelement <9 x double> %v.1, i32 3
  %v1.lane.4 = extractelement <9 x double> %v.1, i32 4
  %v1.lane.5 = extractelement <9 x double> %v.1, i32 5
  %v1.lane.6 = extractelement <9 x double> %v.1, i32 6
  %v1.lane.7 = extractelement <9 x double> %v.1, i32 7
  %v1.lane.8 = extractelement <9 x double> %v.1, i32 8

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.0 = extractelement <4 x double> %v.2, i32 0
  %v2.lane.1 = extractelement <4 x double> %v.2, i32 1
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.4, %v2.lane.1
  %a.lane.1 = fmul double %v1.lane.3, %v2.lane.0
  %a.lane.2 = fmul double %v1.lane.6, %v2.lane.2
  %a.lane.3 = fmul double %v1.lane.5, %v2.lane.0
  %a.lane.4 = fmul double %v1.lane.8, %v2.lane.2
  %a.lane.5 = fmul double %v1.lane.7, %v2.lane.1
  %a.lane.6 = fmul double %v1.lane.1, %v2.lane.0
  %a.lane.7 = fmul double %v1.lane.0, %v2.lane.2
  %a.lane.8 = fmul double %v1.lane.2, %v2.lane.1

  %a.ins.0 = insertelement <9 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <9 x double> %a.ins.0, double %a.lane.1, i32 1
  %a.ins.2 = insertelement <9 x double> %a.ins.1, double %a.lane.2, i32 2
  %a.ins.3 = insertelement <9 x double> %a.ins.2, double %a.lane.3, i32 3
  %a.ins.4 = insertelement <9 x double> %a.ins.3, double %a.lane.4, i32 4
  %a.ins.5 = insertelement <9 x double> %a.ins.4, double %a.lane.5, i32 5
  %a.ins.6 = insertelement <9 x double> %a.ins.5, double %a.lane.6, i32 6
  %a.ins.7 = insertelement <9 x double> %a.ins.6, double %a.lane.7, i32 7
  %a.ins.8 = insertelement <9 x double> %a.ins.7, double %a.lane.8, i32 8

  %b.lane.0 = fmul double %v1.lane.6, %v2.lane.1
  %b.lane.1 = fmul double %v1.lane.7, %v2.lane.0
  %b.lane.2 = fmul double %v1.lane.8, %v2.lane.2
  %b.lane.3 = fmul double %v1.lane.0, %v2.lane.0
  %b.lane.4 = fmul double %v1.lane.1, %v2.lane.2
  %b.lane.5 = fmul double %v1.lane.2, %v2.lane.1
  %b.lane.6 = fmul double %v1.lane.3, %v2.lane.0
  %b.lane.7 = fmul double %v1.lane.4, %v2.lane.2
  %b.lane.8 = fmul double %v1.lane.5, %v2.lane.0

  %b.ins.0 = insertelement <9 x double> undef, double %b.lane.0, i32 0
  %b.ins.1 = insertelement <9 x double> %b.ins.0, double %b.lane.1, i32 1
  %b.ins.2 = insertelement <9 x double> %b.ins.1, double %b.lane.2, i32 2
  %b.ins.3 = insertelement <9 x double> %b.ins.2, double %b.lane.3, i32 3
  %b.ins.4 = insertelement <9 x double> %b.ins.3, double %b.lane.4, i32 4
  %b.ins.5 = insertelement <9 x double> %b.ins.4, double %b.lane.5, i32 5
  %b.ins.6 = insertelement <9 x double> %b.ins.5, double %b.lane.6, i32 6
  %b.ins.7 = insertelement <9 x double> %b.ins.6, double %b.lane.7, i32 7
  %b.ins.8 = insertelement <9 x double> %b.ins.7, double %b.lane.8, i32 8

  %res = fsub <9 x double> %a.ins.8, %b.ins.8
  store <9 x double> %res, ptr %ptr.1, align 8
  ret void
}

; Extracted lanes used in both fmul chain are not used in the right order, so
; we cannot reuse the source vector registers directly.
define void @first_and_second_mul_chain_jumbled(ptr %ptr.1, ptr %ptr.2) {
; CHECK-LABEL: @first_and_second_mul_chain_jumbled(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[V_1:%.*]] = load <9 x double>, ptr [[PTR_1:%.*]], align 8
; CHECK-NEXT:    [[V1_LANE_2:%.*]] = extractelement <9 x double> [[V_1]], i32 2
; CHECK-NEXT:    [[V1_LANE_4:%.*]] = extractelement <9 x double> [[V_1]], i32 4
; CHECK-NEXT:    [[V_2:%.*]] = load <4 x double>, ptr [[PTR_2:%.*]], align 16
; CHECK-NEXT:    [[V2_LANE_0:%.*]] = extractelement <4 x double> [[V_2]], i32 0
; CHECK-NEXT:    [[V2_LANE_2:%.*]] = extractelement <4 x double> [[V_2]], i32 2
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <8 x i32> <i32 4, i32 3, i32 5, i32 6, i32 8, i32 7, i32 1, i32 0>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <8 x i32> <i32 0, i32 2, i32 1, i32 2, i32 1, i32 0, i32 2, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <8 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[A_LANE_8:%.*]] = fmul double [[V1_LANE_2]], [[V2_LANE_0]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x double> [[TMP2]], <8 x double> poison, <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison>
; CHECK-NEXT:    [[A_INS_8:%.*]] = insertelement <9 x double> [[TMP3]], double [[A_LANE_8]], i32 8
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <9 x double> [[V_1]], <9 x double> poison, <8 x i32> <i32 7, i32 6, i32 8, i32 1, i32 0, i32 3, i32 2, i32 5>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <4 x double> [[V_2]], <4 x double> poison, <8 x i32> <i32 2, i32 1, i32 0, i32 2, i32 0, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP6:%.*]] = fmul <8 x double> [[TMP4]], [[TMP5]]
; CHECK-NEXT:    [[B_LANE_8:%.*]] = fmul double [[V1_LANE_4]], [[V2_LANE_2]]
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <8 x double> [[TMP6]], <8 x double> poison, <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison>
; CHECK-NEXT:    [[B_INS_8:%.*]] = insertelement <9 x double> [[TMP7]], double [[B_LANE_8]], i32 8
; CHECK-NEXT:    [[RES:%.*]] = fsub <9 x double> [[A_INS_8]], [[B_INS_8]]
; CHECK-NEXT:    store <9 x double> [[RES]], ptr [[PTR_1]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %v.1 = load <9 x double>, ptr %ptr.1, align 8
  %v1.lane.0 = extractelement <9 x double> %v.1, i32 0
  %v1.lane.1 = extractelement <9 x double> %v.1, i32 1
  %v1.lane.2 = extractelement <9 x double> %v.1, i32 2
  %v1.lane.3 = extractelement <9 x double> %v.1, i32 3
  %v1.lane.4 = extractelement <9 x double> %v.1, i32 4
  %v1.lane.5 = extractelement <9 x double> %v.1, i32 5
  %v1.lane.6 = extractelement <9 x double> %v.1, i32 6
  %v1.lane.7 = extractelement <9 x double> %v.1, i32 7
  %v1.lane.8 = extractelement <9 x double> %v.1, i32 8

  %v.2 = load <4 x double>, ptr %ptr.2, align 16
  %v2.lane.0 = extractelement <4 x double> %v.2, i32 0
  %v2.lane.1 = extractelement <4 x double> %v.2, i32 1
  %v2.lane.2 = extractelement <4 x double> %v.2, i32 2

  %a.lane.0 = fmul double %v1.lane.4, %v2.lane.0
  %a.lane.1 = fmul double %v1.lane.3, %v2.lane.2
  %a.lane.2 = fmul double %v1.lane.5, %v2.lane.1
  %a.lane.3 = fmul double %v1.lane.6, %v2.lane.2
  %a.lane.4 = fmul double %v1.lane.8, %v2.lane.1
  %a.lane.5 = fmul double %v1.lane.7, %v2.lane.0
  %a.lane.6 = fmul double %v1.lane.1, %v2.lane.2
  %a.lane.7 = fmul double %v1.lane.0, %v2.lane.1
  %a.lane.8 = fmul double %v1.lane.2, %v2.lane.0

  %a.ins.0 = insertelement <9 x double> undef, double %a.lane.0, i32 0
  %a.ins.1 = insertelement <9 x double> %a.ins.0, double %a.lane.1, i32 1
  %a.ins.2 = insertelement <9 x double> %a.ins.1, double %a.lane.2, i32 2
  %a.ins.3 = insertelement <9 x double> %a.ins.2, double %a.lane.3, i32 3
  %a.ins.4 = insertelement <9 x double> %a.ins.3, double %a.lane.4, i32 4
  %a.ins.5 = insertelement <9 x double> %a.ins.4, double %a.lane.5, i32 5
  %a.ins.6 = insertelement <9 x double> %a.ins.5, double %a.lane.6, i32 6
  %a.ins.7 = insertelement <9 x double> %a.ins.6, double %a.lane.7, i32 7
  %a.ins.8 = insertelement <9 x double> %a.ins.7, double %a.lane.8, i32 8

  %b.lane.0 = fmul double %v1.lane.7, %v2.lane.2
  %b.lane.1 = fmul double %v1.lane.6, %v2.lane.1
  %b.lane.2 = fmul double %v1.lane.8, %v2.lane.0
  %b.lane.3 = fmul double %v1.lane.1, %v2.lane.2
  %b.lane.4 = fmul double %v1.lane.0, %v2.lane.0
  %b.lane.5 = fmul double %v1.lane.3, %v2.lane.2
  %b.lane.6 = fmul double %v1.lane.2, %v2.lane.1
  %b.lane.7 = fmul double %v1.lane.5, %v2.lane.0
  %b.lane.8 = fmul double %v1.lane.4, %v2.lane.2

  %b.ins.0 = insertelement <9 x double> undef, double %b.lane.0, i32 0
  %b.ins.1 = insertelement <9 x double> %b.ins.0, double %b.lane.1, i32 1
  %b.ins.2 = insertelement <9 x double> %b.ins.1, double %b.lane.2, i32 2
  %b.ins.3 = insertelement <9 x double> %b.ins.2, double %b.lane.3, i32 3
  %b.ins.4 = insertelement <9 x double> %b.ins.3, double %b.lane.4, i32 4
  %b.ins.5 = insertelement <9 x double> %b.ins.4, double %b.lane.5, i32 5
  %b.ins.6 = insertelement <9 x double> %b.ins.5, double %b.lane.6, i32 6
  %b.ins.7 = insertelement <9 x double> %b.ins.6, double %b.lane.7, i32 7
  %b.ins.8 = insertelement <9 x double> %b.ins.7, double %b.lane.8, i32 8

  %res = fsub <9 x double> %a.ins.8, %b.ins.8
  store <9 x double> %res, ptr %ptr.1, align 8
  ret void
}
