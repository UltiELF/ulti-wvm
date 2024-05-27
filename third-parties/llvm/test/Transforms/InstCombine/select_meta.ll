; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals

; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i32 @foo(i32) local_unnamed_addr #0  {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP0:%.*]], 2
; CHECK-NEXT:    [[DOTV:%.*]] = select i1 [[TMP2]], i32 20, i32 -20, !prof [[PROF0:![0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[DOTV]], [[TMP0]]
; CHECK-NEXT:    ret i32 [[TMP3]]
;
  %2 = icmp sgt i32 %0, 2
  %3 = add nsw i32 %0, 20
  %4 = add i32 %0, -20
  select i1 %2, i32 %3, i32 %4, !prof !1
  ret i32 %5
}

define i8 @shrink_select(i1 %cond, i32 %x) {
; CHECK-LABEL: @shrink_select(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[X:%.*]] to i8
; CHECK-NEXT:    [[TRUNC:%.*]] = select i1 [[COND:%.*]], i8 [[TMP1]], i8 42, !prof [[PROF0]]
; CHECK-NEXT:    ret i8 [[TRUNC]]
;
  %sel = select i1 %cond, i32 %x, i32 42, !prof !1
  %trunc = trunc i32 %sel to i8
  ret i8 %trunc
}

define void @min_max_bitcast(<4 x float> %a, <4 x float> %b, ptr %ptr1, ptr %ptr2) {
; CHECK-LABEL: @min_max_bitcast(
; CHECK-NEXT:    [[CMP:%.*]] = fcmp olt <4 x float> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL1_V:%.*]] = select <4 x i1> [[CMP]], <4 x float> [[A]], <4 x float> [[B]], !prof [[PROF0]]
; CHECK-NEXT:    [[SEL2_V:%.*]] = select <4 x i1> [[CMP]], <4 x float> [[B]], <4 x float> [[A]], !prof [[PROF0]]
; CHECK-NEXT:    store <4 x float> [[SEL1_V]], ptr [[PTR1:%.*]], align 16
; CHECK-NEXT:    store <4 x float> [[SEL2_V]], ptr [[PTR2:%.*]], align 16
; CHECK-NEXT:    ret void
;
  %cmp = fcmp olt <4 x float> %a, %b
  %bc1 = bitcast <4 x float> %a to <4 x i32>
  %bc2 = bitcast <4 x float> %b to <4 x i32>
  %sel1 = select <4 x i1> %cmp, <4 x i32> %bc1, <4 x i32> %bc2, !prof !1
  %sel2 = select <4 x i1> %cmp, <4 x i32> %bc2, <4 x i32> %bc1, !prof !1
  store <4 x i32> %sel1, ptr %ptr1
  store <4 x i32> %sel2, ptr %ptr2
  ret void
}

define i32 @foo2(i32, i32) local_unnamed_addr #0  {
; CHECK-LABEL: @foo2(
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[TMP0:%.*]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = sub i32 0, [[TMP1:%.*]]
; CHECK-NEXT:    [[DOTP:%.*]] = select i1 [[TMP3]], i32 [[TMP1]], i32 [[TMP4]], !prof [[PROF0]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[DOTP]], [[TMP0]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
  %3 = icmp sgt i32 %0, 2
  %4 = add nsw i32 %0, %1
  %5 = sub nsw i32 %0, %1
  select i1 %3, i32 %4, i32 %5, !prof !1
  ret i32 %6
}

define i64 @test43(i32 %a) nounwind {
; CHECK-LABEL: @test43(
; CHECK-NEXT:    [[NARROW:%.*]] = call i32 @llvm.smax.i32(i32 [[A:%.*]], i32 0)
; CHECK-NEXT:    [[MAX:%.*]] = zext nneg i32 [[NARROW]] to i64
; CHECK-NEXT:    ret i64 [[MAX]]
;
  %a_ext = sext i32 %a to i64
  %is_a_nonnegative = icmp sgt i32 %a, -1
  %max = select i1 %is_a_nonnegative, i64 %a_ext, i64 0, !prof !1
  ret i64 %max
}

define <2 x i32> @scalar_select_of_vectors_sext(<2 x i1> %cca, i1 %ccb) {
; CHECK-LABEL: @scalar_select_of_vectors_sext(
; CHECK-NEXT:    [[NARROW:%.*]] = select i1 [[CCB:%.*]], <2 x i1> [[CCA:%.*]], <2 x i1> zeroinitializer, !prof [[PROF0]]
; CHECK-NEXT:    [[R:%.*]] = sext <2 x i1> [[NARROW]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %ccax = sext <2 x i1> %cca to <2 x i32>
  %r = select i1 %ccb, <2 x i32> %ccax, <2 x i32> <i32 0, i32 0>, !prof !1
  ret <2 x i32> %r
}


define i16 @t7(i32 %a) {
; CHECK-LABEL: @t7(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.smin.i32(i32 [[A:%.*]], i32 -32768)
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[TMP1]] to i16
; CHECK-NEXT:    ret i16 [[TMP2]]
;
  %1 = icmp slt i32 %a, -32768
  %2 = trunc i32 %a to i16
  %3 = select i1 %1, i16 %2, i16 -32768, !prof !1
  ret i16 %3
}

define i32 @abs_nabs_x01(i32 %x) {
; CHECK-LABEL: @abs_nabs_x01(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.abs.i32(i32 [[X:%.*]], i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %cmp = icmp sgt i32 %x, -1
  %sub = sub nsw i32 0, %x
  %cond = select i1 %cmp, i32 %sub, i32 %x, !prof !1
  %cmp1 = icmp sgt i32 %cond, -1
  %sub16 = sub nsw i32 0, %cond
  %cond18 = select i1 %cmp1, i32 %cond, i32 %sub16, !prof !2
  ret i32 %cond18
}

; Swap predicate / metadata order

define <2 x i32> @abs_nabs_x01_vec(<2 x i32> %x) {
; CHECK-LABEL: @abs_nabs_x01_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i32> @llvm.abs.v2i32(<2 x i32> [[X:%.*]], i1 false)
; CHECK-NEXT:    ret <2 x i32> [[TMP1]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 -1, i32 -1>
  %sub = sub nsw <2 x i32> zeroinitializer, %x
  %cond = select <2 x i1> %cmp, <2 x i32> %sub, <2 x i32> %x, !prof !1
  %cmp1 = icmp sgt <2 x i32> %cond, <i32 -1, i32 -1>
  %sub16 = sub nsw <2 x i32> zeroinitializer, %cond
  %cond18 = select <2 x i1> %cmp1, <2 x i32> %cond, <2 x i32> %sub16, !prof !2
  ret <2 x i32> %cond18
}

; SMAX(SMAX(x, y), x) -> SMAX(x, y)
define i32 @test30(i32 %x, i32 %y) {
; CHECK-LABEL: @test30(
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.smax.i32(i32 [[X:%.*]], i32 [[Y:%.*]])
; CHECK-NEXT:    ret i32 [[COND]]
;
  %cmp = icmp sgt i32 %x, %y
  %cond = select i1 %cmp, i32 %x, i32 %y, !prof !1
  %cmp5 = icmp sgt i32 %cond, %x
  %retval = select i1 %cmp5, i32 %cond, i32 %x, !prof !2
  ret i32 %retval
}

; SMAX(SMAX(75, X), 36) -> SMAX(X, 75)
define i32 @test70(i32 %x) {
; CHECK-LABEL: @test70(
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.smax.i32(i32 [[X:%.*]], i32 75)
; CHECK-NEXT:    ret i32 [[COND]]
;
  %cmp = icmp slt i32 %x, 75
  %cond = select i1 %cmp, i32 75, i32 %x, !prof !1
  %cmp3 = icmp slt i32 %cond, 36
  %retval = select i1 %cmp3, i32 36, i32 %cond, !prof !2
  ret i32 %retval
}

; Swap predicate / metadata order
; SMIN(SMIN(X, 92), 11) -> SMIN(X, 11)
define i32 @test72(i32 %x) {
; CHECK-LABEL: @test72(
; CHECK-NEXT:    [[RETVAL:%.*]] = call i32 @llvm.smin.i32(i32 [[X:%.*]], i32 11)
; CHECK-NEXT:    ret i32 [[RETVAL]]
;
  %cmp = icmp sgt i32 %x, 92
  %cond = select i1 %cmp, i32 92, i32 %x, !prof !1
  %cmp3 = icmp sgt i32 %cond, 11
  %retval = select i1 %cmp3, i32 11, i32 %cond, !prof !2
  ret i32 %retval
}

; Swap predicate / metadata order
; SMAX(SMAX(X, 36), 75) -> SMAX(X, 75)
define i32 @test74(i32 %x) {
; CHECK-LABEL: @test74(
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.smax.i32(i32 [[X:%.*]], i32 36)
; CHECK-NEXT:    [[RETVAL:%.*]] = call i32 @llvm.umax.i32(i32 [[COND]], i32 75)
; CHECK-NEXT:    ret i32 [[RETVAL]]
;
  %cmp = icmp slt i32 %x, 36
  %cond = select i1 %cmp, i32 36, i32 %x, !prof !1
  %cmp3 = icmp slt i32 %cond, 75
  %retval = select i1 %cmp3, i32 75, i32 %cond, !prof !2
  ret i32 %retval
}

; The xor is moved after the select. The metadata remains the same because the select operands are not swapped only inverted.
define i32 @smin1(i32 %x) {
; CHECK-LABEL: @smin1(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.smax.i32(i32 [[X:%.*]], i32 0)
; CHECK-NEXT:    [[SEL:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %not_x = xor i32 %x, -1
  %cmp = icmp sgt i32 %x, 0
  %sel = select i1 %cmp, i32 %not_x, i32 -1, !prof !1
  ret i32 %sel
}

; The compare should change, and the metadata is swapped because the select operands are swapped and inverted.
define i32 @smin2(i32 %x) {
; CHECK-LABEL: @smin2(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.smax.i32(i32 [[X:%.*]], i32 0)
; CHECK-NEXT:    [[SEL:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %not_x = xor i32 %x, -1
  %cmp = icmp slt i32 %x, 0
  %sel = select i1 %cmp, i32 -1, i32 %not_x, !prof !1
  ret i32 %sel
}

; The xor is moved after the select. The metadata remains the same because the select operands are not swapped only inverted.
define i32 @smax1(i32 %x) {
; CHECK-LABEL: @smax1(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.smin.i32(i32 [[X:%.*]], i32 0)
; CHECK-NEXT:    [[SEL:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %not_x = xor i32 %x, -1
  %cmp = icmp slt i32 %x, 0
  %sel = select i1 %cmp, i32 %not_x, i32 -1, !prof !1
  ret i32 %sel
}

; The compare should change, and the metadata is swapped because the select operands are swapped and inverted.
define i32 @smax2(i32 %x) {
; CHECK-LABEL: @smax2(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.smin.i32(i32 [[X:%.*]], i32 0)
; CHECK-NEXT:    [[SEL:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %not_x = xor i32 %x, -1
  %cmp = icmp sgt i32 %x, 0
  %sel = select i1 %cmp, i32 -1, i32 %not_x, !prof !1
  ret i32 %sel
}

; The compare should change, but the metadata remains the same because the select operands are not swapped.
define i32 @umin1(i32 %x) {
; CHECK-LABEL: @umin1(
; CHECK-NEXT:    [[SEL:%.*]] = call i32 @llvm.umin.i32(i32 [[X:%.*]], i32 -2147483648)
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %cmp = icmp sgt i32 %x, -1
  %sel = select i1 %cmp, i32 %x, i32 -2147483648, !prof !1
  ret i32 %sel
}

; The compare should change, and the metadata is swapped because the select operands are swapped.
define i32 @umin2(i32 %x) {
; CHECK-LABEL: @umin2(
; CHECK-NEXT:    [[SEL:%.*]] = call i32 @llvm.umin.i32(i32 [[X:%.*]], i32 2147483647)
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %cmp = icmp slt i32 %x, 0
  %sel = select i1 %cmp, i32 2147483647, i32 %x, !prof !1
  ret i32 %sel
}

; The compare should change, but the metadata remains the same because the select operands are not swapped.
define i32 @umax1(i32 %x) {
; CHECK-LABEL: @umax1(
; CHECK-NEXT:    [[SEL:%.*]] = call i32 @llvm.umax.i32(i32 [[X:%.*]], i32 2147483647)
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %cmp = icmp slt i32 %x, 0
  %sel = select i1 %cmp, i32 %x, i32 2147483647, !prof !1
  ret i32 %sel
}

; The compare should change, and the metadata is swapped because the select operands are swapped.
define i32 @umax2(i32 %x) {
; CHECK-LABEL: @umax2(
; CHECK-NEXT:    [[SEL:%.*]] = call i32 @llvm.umax.i32(i32 [[X:%.*]], i32 -2147483648)
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %cmp = icmp sgt i32 %x, -1
  %sel = select i1 %cmp, i32 -2147483648, i32 %x, !prof !1
  ret i32 %sel
}

; The condition is inverted, and the select ops are swapped. The metadata should be swapped.

define i32 @not_cond(i1 %c, i32 %tv, i32 %fv) {
; CHECK-LABEL: @not_cond(
; CHECK-NEXT:    [[R:%.*]] = select i1 [[C:%.*]], i32 [[FV:%.*]], i32 [[TV:%.*]], !prof [[PROF1:![0-9]+]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %notc = xor i1 %c, true
  %r = select i1 %notc, i32 %tv, i32 %fv, !prof !1
  ret i32 %r
}

; The condition is inverted, and the select ops are swapped. The metadata should be swapped.

define <2 x i32> @not_cond_vec(<2 x i1> %c, <2 x i32> %tv, <2 x i32> %fv) {
; CHECK-LABEL: @not_cond_vec(
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[C:%.*]], <2 x i32> [[FV:%.*]], <2 x i32> [[TV:%.*]], !prof [[PROF1]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %notc = xor <2 x i1> %c, <i1 true, i1 true>
  %r = select <2 x i1> %notc, <2 x i32> %tv, <2 x i32> %fv, !prof !1
  ret <2 x i32> %r
}

; Should match vector 'not' with undef element.
; The condition is inverted, and the select ops are swapped. The metadata should be swapped.

define <2 x i32> @not_cond_vec_undef(<2 x i1> %c, <2 x i32> %tv, <2 x i32> %fv) {
; CHECK-LABEL: @not_cond_vec_undef(
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[C:%.*]], <2 x i32> [[FV:%.*]], <2 x i32> [[TV:%.*]], !prof [[PROF1]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %notc = xor <2 x i1> %c, <i1 undef, i1 true>
  %r = select <2 x i1> %notc, <2 x i32> %tv, <2 x i32> %fv, !prof !1
  ret <2 x i32> %r
}

define i64 @select_add(i1 %cond, i64 %x, i64 %y) {
; CHECK-LABEL: @select_add(
; CHECK-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i64 [[Y:%.*]], i64 0, !prof [[PROF0]], !unpredictable !2
; CHECK-NEXT:    [[RET:%.*]] = add i64 [[OP]], [[X:%.*]]
; CHECK-NEXT:    ret i64 [[RET]]
;
  %op = add i64 %x, %y
  %ret = select i1 %cond, i64 %op, i64 %x, !prof !1, !unpredictable !3
  ret i64 %ret
}

define <2 x i32> @select_or(<2 x i1> %cond, <2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @select_or(
; CHECK-NEXT:    [[OP:%.*]] = select <2 x i1> [[COND:%.*]], <2 x i32> [[Y:%.*]], <2 x i32> zeroinitializer, !prof [[PROF0]], !unpredictable !2
; CHECK-NEXT:    [[RET:%.*]] = or <2 x i32> [[OP]], [[X:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[RET]]
;
  %op = or <2 x i32> %x, %y
  %ret = select <2 x i1> %cond, <2 x i32> %op, <2 x i32> %x, !prof !1, !unpredictable !3
  ret <2 x i32> %ret
}

define i17 @select_sub(i1 %cond, i17 %x, i17 %y) {
; CHECK-LABEL: @select_sub(
; CHECK-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i17 [[Y:%.*]], i17 0, !prof [[PROF0]], !unpredictable !2
; CHECK-NEXT:    [[RET:%.*]] = sub i17 [[X:%.*]], [[OP]]
; CHECK-NEXT:    ret i17 [[RET]]
;
  %op = sub i17 %x, %y
  %ret = select i1 %cond, i17 %op, i17 %x, !prof !1, !unpredictable !3
  ret i17 %ret
}

define i128 @select_ashr(i1 %cond, i128 %x, i128 %y) {
; CHECK-LABEL: @select_ashr(
; CHECK-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i128 [[Y:%.*]], i128 0, !prof [[PROF0]], !unpredictable !2
; CHECK-NEXT:    [[RET:%.*]] = ashr i128 [[X:%.*]], [[OP]]
; CHECK-NEXT:    ret i128 [[RET]]
;
  %op = ashr i128 %x, %y
  %ret = select i1 %cond, i128 %op, i128 %x, !prof !1, !unpredictable !3
  ret i128 %ret
}

define double @select_fmul(i1 %cond, double %x, double %y) {
; CHECK-LABEL: @select_fmul(
; CHECK-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], double [[Y:%.*]], double 1.000000e+00, !prof [[PROF0]], !unpredictable !2
; CHECK-NEXT:    [[RET:%.*]] = fmul double [[OP]], [[X:%.*]]
; CHECK-NEXT:    ret double [[RET]]
;
  %op = fmul double %x, %y
  %ret = select i1 %cond, double %op, double %x, !prof !1, !unpredictable !3
  ret double %ret
}

define <2 x float> @select_fdiv(i1 %cond, <2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @select_fdiv(
; CHECK-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], <2 x float> [[Y:%.*]], <2 x float> <float 1.000000e+00, float 1.000000e+00>, !prof [[PROF0]], !unpredictable !2
; CHECK-NEXT:    [[RET:%.*]] = fdiv <2 x float> [[X:%.*]], [[OP]]
; CHECK-NEXT:    ret <2 x float> [[RET]]
;
  %op = fdiv <2 x float> %x, %y
  %ret = select i1 %cond, <2 x float> %op, <2 x float> %x, !prof !1, !unpredictable !3
  ret <2 x float> %ret
}

!1 = !{!"branch_weights", i32 2, i32 10}
!2 = !{!"branch_weights", i32 3, i32 10}
!3 = !{}

;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nounwind }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
;.
; CHECK: [[PROF0]] = !{!"branch_weights", i32 2, i32 10}
; CHECK: [[PROF1]] = !{!"branch_weights", i32 10, i32 2}
; CHECK: [[META2:![0-9]+]] = !{}
;.
