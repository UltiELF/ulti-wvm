; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i64 @test1(i32 %x) nounwind {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret i64 0
;
  %y = lshr i32 %x, 1
  %r = udiv i32 %y, -1
  %z = sext i32 %r to i64
  ret i64 %z
}
define i64 @test2(i32 %x) nounwind {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret i64 0
;
  %y = lshr i32 %x, 31
  %r = udiv i32 %y, 3
  %z = sext i32 %r to i64
  ret i64 %z
}

; The udiv instructions shouldn't be optimized away, and the
; sext instructions should be optimized to zext.

define i64 @test1_PR2274(i32 %x, i32 %g) nounwind {
; CHECK-LABEL: @test1_PR2274(
; CHECK-NEXT:    [[Y:%.*]] = lshr i32 [[X:%.*]], 30
; CHECK-NEXT:    [[R:%.*]] = udiv i32 [[Y]], [[G:%.*]]
; CHECK-NEXT:    [[Z:%.*]] = zext nneg i32 [[R]] to i64
; CHECK-NEXT:    ret i64 [[Z]]
;
  %y = lshr i32 %x, 30
  %r = udiv i32 %y, %g
  %z = sext i32 %r to i64
  ret i64 %z
}
define i64 @test2_PR2274(i32 %x, i32 %v) nounwind {
; CHECK-LABEL: @test2_PR2274(
; CHECK-NEXT:    [[Y:%.*]] = lshr i32 [[X:%.*]], 31
; CHECK-NEXT:    [[R:%.*]] = udiv i32 [[Y]], [[V:%.*]]
; CHECK-NEXT:    [[Z:%.*]] = zext nneg i32 [[R]] to i64
; CHECK-NEXT:    ret i64 [[Z]]
;
  %y = lshr i32 %x, 31
  %r = udiv i32 %y, %v
  %z = sext i32 %r to i64
  ret i64 %z
}

; The udiv should be simplified according to the rule:
; X udiv (C1 << N), where C1 is `1<<C2` --> X >> (N+C2)
@b = external global [1 x i16]

define i32 @PR30366(i1 %a) {
; CHECK-LABEL: @PR30366(
; CHECK-NEXT:    [[Z:%.*]] = zext i1 [[A:%.*]] to i32
; CHECK-NEXT:    [[Z2:%.*]] = zext nneg i16 shl (i16 1, i16 ptrtoint (ptr @b to i16)) to i32
; CHECK-NEXT:    [[D:%.*]] = udiv i32 [[Z]], [[Z2]]
; CHECK-NEXT:    ret i32 [[D]]
;
  %z = zext i1 %a to i32
  %z2 = zext i16 shl (i16 1, i16 ptrtoint (ptr @b to i16)) to i32
  %d = udiv i32 %z, %z2
  ret i32 %d
}

; OSS-Fuzz #4857
; https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=4857
define i177 @ossfuzz_4857(i177 %X, i177 %Y) {
; CHECK-LABEL: @ossfuzz_4857(
; CHECK-NEXT:    store i1 poison, ptr undef, align 1
; CHECK-NEXT:    ret i177 0
;
  %B5 = udiv i177 %Y, -1
  %B4 = add i177 %B5, -1
  %B2 = add i177 %B4, -1
  %B6 = mul i177 %B5, %B2
  %B3 = add i177 %B2, %B2
  %B9 = xor i177 %B4, %B3
  %B13 = ashr i177 %Y, %B2
  %B22 = add i177 %B9, %B13
  %B1 = udiv i177 %B5, %B6
  %C9 = icmp ult i177 %Y, %B22
  store i1 %C9, ptr undef
  ret i177 %B1
}

; 2 low bits are not needed because 12 has 2 trailing zeros

define i8 @udiv_demanded_low_bits_set(i8 %a) {
; CHECK-LABEL: @udiv_demanded_low_bits_set(
; CHECK-NEXT:    [[U:%.*]] = udiv i8 [[A:%.*]], 12
; CHECK-NEXT:    ret i8 [[U]]
;
  %o = or i8 %a, 3
  %u = udiv i8 %o, 12
  ret i8 %u
}

; This can't divide evenly, so it is poison.

define i8 @udiv_exact_demanded_low_bits_set(i8 %a) {
; CHECK-LABEL: @udiv_exact_demanded_low_bits_set(
; CHECK-NEXT:    ret i8 poison
;
  %o = or i8 %a, 3
  %u = udiv exact i8 %o, 12
  ret i8 %u
}

; All high bits are set, so this simplifies.

define i8 @udiv_demanded_high_bits_set(i8 %x, i8 %y) {
; CHECK-LABEL: @udiv_demanded_high_bits_set(
; CHECK-NEXT:    ret i8 21
;
  %o = or i8 %x, -4
  %r = udiv i8 %o, 12
  ret i8 %r
}

; This should fold the same as above.

define i8 @udiv_exact_demanded_high_bits_set(i8 %x, i8 %y) {
; CHECK-LABEL: @udiv_exact_demanded_high_bits_set(
; CHECK-NEXT:    ret i8 21
;
  %o = or i8 %x, -4
  %r = udiv exact i8 %o, 12
  ret i8 %r
}

; 2 low bits are not needed because 12 has 2 trailing zeros

define i8 @udiv_demanded_low_bits_clear(i8 %a) {
; CHECK-LABEL: @udiv_demanded_low_bits_clear(
; CHECK-NEXT:    [[U:%.*]] = udiv i8 [[A:%.*]], 12
; CHECK-NEXT:    ret i8 [[U]]
;
  %o = and i8 %a, -4
  %u = udiv i8 %o, 12
  ret i8 %u
}

; This should fold the same as above.

define i8 @udiv_exact_demanded_low_bits_clear(i8 %a) {
; CHECK-LABEL: @udiv_exact_demanded_low_bits_clear(
; CHECK-NEXT:    [[U:%.*]] = udiv i8 [[A:%.*]], 12
; CHECK-NEXT:    ret i8 [[U]]
;
  %o = and i8 %a, -4
  %u = udiv exact i8 %o, 12
  ret i8 %u
}

define <vscale x 1 x i32> @udiv_demanded3(<vscale x 1 x i32> %a) {
; CHECK-LABEL: @udiv_demanded3(
; CHECK-NEXT:    [[U:%.*]] = udiv <vscale x 1 x i32> [[A:%.*]], shufflevector (<vscale x 1 x i32> insertelement (<vscale x 1 x i32> poison, i32 12, i32 0), <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer)
; CHECK-NEXT:    ret <vscale x 1 x i32> [[U]]
;
  %o = or <vscale x 1 x i32> %a, shufflevector (<vscale x 1 x i32> insertelement (<vscale x 1 x i32> poison, i32 3, i32 0), <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer)
  %u = udiv <vscale x 1 x i32> %o, shufflevector (<vscale x 1 x i32> insertelement (<vscale x 1 x i32> poison, i32 12, i32 0), <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer)
  ret <vscale x 1 x i32> %u
}

; PR74242
define i32 @div_by_zero_or_one_from_dom_cond(i32 %a, i32 %b) {
; CHECK-LABEL: @div_by_zero_or_one_from_dom_cond(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[A:%.*]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[JOIN:%.*]], label [[ZERO_OR_ONE:%.*]]
; CHECK:       zero_or_one:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    ret i32 [[B:%.*]]
;
entry:
  %cmp = icmp ugt i32 %a, 1
  br i1 %cmp, label %join, label %zero_or_one

zero_or_one:
  %div = udiv i32 %b, %a
  br label %join

join:
  %res = phi i32 [ %div, %zero_or_one ], [ %b, %entry ]
  ret i32 %res
}
