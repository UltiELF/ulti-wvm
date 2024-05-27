; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

declare void @use(i32)

declare i32 @llvm.ctlz.i32(i32, i1)
declare <3 x i17> @llvm.ctlz.v3i17(<3 x i17>, i1)

declare i32 @llvm.cttz.i32(i32, i1)
declare <3 x i5> @llvm.cttz.v3i5(<3 x i5>, i1)

declare i32 @llvm.ctpop.i32(i32)
declare <3 x i7> @llvm.ctpop.v3i7(<3 x i7>)

declare i32 @llvm.usub.sat.i32(i32, i32)

define i32 @ctlz_sel_const_true_false(i1 %b) {
; CHECK-LABEL: @ctlz_sel_const_true_false(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 29, i32 0
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 -7
  %c = call i32 @llvm.ctlz.i32(i32 %s, i1 true)
  ret i32 %c
}

define i32 @ctlz_sel_const_true(i1 %b, i32 %x) {
; CHECK-LABEL: @ctlz_sel_const_true(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 29, i32 [[TMP1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.ctlz.i32(i32 %s, i1 false)
  ret i32 %c
}

define <3 x i17> @ctlz_sel_const_false(<3 x i1> %b, <3 x i17> %x) {
; CHECK-LABEL: @ctlz_sel_const_false(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i17> @llvm.ctlz.v3i17(<3 x i17> [[X:%.*]], i1 true), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[C:%.*]] = select <3 x i1> [[B:%.*]], <3 x i17> [[TMP1]], <3 x i17> <i17 14, i17 0, i17 poison>
; CHECK-NEXT:    ret <3 x i17> [[C]]
;
  %s = select <3 x i1> %b, <3 x i17> %x, <3 x i17> <i17 7, i17 -1, i17 0>
  %c = call <3 x i17> @llvm.ctlz.v3i17(<3 x i17> %s, i1 true)
  ret <3 x i17> %c
}

define i32 @ctlz_sel_const_true_false_extra_use(i1 %b) {
; CHECK-LABEL: @ctlz_sel_const_true_false_extra_use(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 -1, i32 7
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctlz.i32(i32 [[S]], i1 true), !range [[RNG2:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 -1, i32 7
  call void @use(i32 %s)
  %c = call i32 @llvm.ctlz.i32(i32 %s, i1 false)
  ret i32 %c
}

define i32 @cttz_sel_const_true_false(i1 %b) {
; CHECK-LABEL: @cttz_sel_const_true_false(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 2, i32 0
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 4, i32 -7
  %c = call i32 @llvm.cttz.i32(i32 %s, i1 false)
  ret i32 %c
}

define i32 @cttz_sel_const_true(i1 %b, i32 %x) {
; CHECK-LABEL: @cttz_sel_const_true(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 true), !range [[RNG0]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 0, i32 [[TMP1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.cttz.i32(i32 %s, i1 true)
  ret i32 %c
}

define <3 x i5> @cttz_sel_const_false(<3 x i1> %b, <3 x i5> %x) {
; CHECK-LABEL: @cttz_sel_const_false(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i5> @llvm.cttz.v3i5(<3 x i5> [[X:%.*]], i1 false), !range [[RNG3:![0-9]+]]
; CHECK-NEXT:    [[C:%.*]] = select <3 x i1> [[B:%.*]], <3 x i5> [[TMP1]], <3 x i5> <i5 0, i5 0, i5 5>
; CHECK-NEXT:    ret <3 x i5> [[C]]
;
  %s = select <3 x i1> %b, <3 x i5> %x, <3 x i5> <i5 7, i5 -1, i5 0>
  %c = call <3 x i5> @llvm.cttz.v3i5(<3 x i5> %s, i1 false)
  ret <3 x i5> %c
}

define i32 @cttz_sel_const_true_false_extra_use(i1 %b) {
; CHECK-LABEL: @cttz_sel_const_true_false_extra_use(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 -8
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.cttz.i32(i32 [[S]], i1 true), !range [[RNG0]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 -8
  call void @use(i32 %s)
  %c = call i32 @llvm.cttz.i32(i32 %s, i1 true)
  ret i32 %c
}

define i32 @ctpop_sel_const_true_false(i1 %b) {
; CHECK-LABEL: @ctpop_sel_const_true_false(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 2, i32 30
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 -7
  %c = call i32 @llvm.ctpop.i32(i32 %s)
  ret i32 %c
}

define i32 @ctpop_sel_const_true(i1 %b, i32 %x) {
; CHECK-LABEL: @ctpop_sel_const_true(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctpop.i32(i32 [[X:%.*]]), !range [[RNG0]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 2, i32 [[TMP1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.ctpop.i32(i32 %s)
  ret i32 %c
}

define <3 x i7> @ctpop_sel_const_false(<3 x i1> %b, <3 x i7> %x) {
; CHECK-LABEL: @ctpop_sel_const_false(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i7> @llvm.ctpop.v3i7(<3 x i7> [[X:%.*]]), !range [[RNG4:![0-9]+]]
; CHECK-NEXT:    [[C:%.*]] = select <3 x i1> [[B:%.*]], <3 x i7> [[TMP1]], <3 x i7> <i7 3, i7 7, i7 0>
; CHECK-NEXT:    ret <3 x i7> [[C]]
;
  %s = select <3 x i1> %b, <3 x i7> %x, <3 x i7> <i7 7, i7 -1, i7 0>
  %c = call <3 x i7> @llvm.ctpop.v3i7(<3 x i7> %s)
  ret <3 x i7> %c
}

define i32 @ctpop_sel_const_true_false_extra_use(i1 %b) {
; CHECK-LABEL: @ctpop_sel_const_true_false_extra_use(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 7
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctpop.i32(i32 [[S]]), !range [[RNG5:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 7
  call void @use(i32 %s)
  %c = call i32 @llvm.ctpop.i32(i32 %s)
  ret i32 %c
}

define i32 @usub_sat_rhs_const_select_all_const(i1 %b) {
; CHECK-LABEL: @usub_sat_rhs_const_select_all_const(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 0, i32 3
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 10
  %c = call i32 @llvm.usub.sat.i32(i32 %s, i32 7)
  ret i32 %c
}

define i32 @usub_sat_rhs_var_select_all_const(i1 %b, i32 %x) {
; CHECK-LABEL: @usub_sat_rhs_var_select_all_const(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 10
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.usub.sat.i32(i32 [[S]], i32 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 10
  %c = call i32 @llvm.usub.sat.i32(i32 %s, i32 %x)
  ret i32 %c
}

define i32 @usub_sat_rhs_const_select_one_const(i1 %b, i32 %x) {
; CHECK-LABEL: @usub_sat_rhs_const_select_one_const(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.usub.sat.i32(i32 [[X:%.*]], i32 7)
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 0, i32 [[TMP1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.usub.sat.i32(i32 %s, i32 7)
  ret i32 %c
}

define i32 @usub_sat_rhs_const_select_no_const(i1 %b, i32 %x, i32 %y) {
; CHECK-LABEL: @usub_sat_rhs_const_select_no_const(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 [[Y:%.*]], i32 [[X:%.*]]
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.usub.sat.i32(i32 [[S]], i32 7)
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 %y, i32 %x
  %c = call i32 @llvm.usub.sat.i32(i32 %s, i32 7)
  ret i32 %c
}

define i32 @usub_sat_lhs_const_select_all_const(i1 %b) {
; CHECK-LABEL: @usub_sat_lhs_const_select_all_const(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i32 2, i32 0
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 10
  %c = call i32 @llvm.usub.sat.i32(i32 7, i32 %s)
  ret i32 %c
}

@g1 = constant <2 x i32> zeroinitializer
@g2 = external global i8
declare <2 x i32> @llvm.masked.load.v2i32.p0(ptr, i32, <2 x i1>, <2 x i32>)

define <2 x i32> @non_speculatable(i1 %b) {
; CHECK-LABEL: @non_speculatable(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], ptr @g1, ptr @g2
; CHECK-NEXT:    [[C:%.*]] = call <2 x i32> @llvm.masked.load.v2i32.p0(ptr nonnull [[S]], i32 64, <2 x i1> <i1 true, i1 false>, <2 x i32> poison)
; CHECK-NEXT:    ret <2 x i32> [[C]]
;
  %s = select i1 %b, ptr @g1, ptr @g2
  %c = call <2 x i32> @llvm.masked.load.v2i32.p0(ptr %s, i32 64, <2 x i1> <i1 true, i1 false>, <2 x i32> poison)
  ret <2 x i32> %c
}

declare i32 @llvm.vector.reduce.add.v2i32(<2 x i32>)

define i32 @vec_to_scalar_select_scalar(i1 %b) {
; CHECK-LABEL: @vec_to_scalar_select_scalar(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], <2 x i32> <i32 1, i32 2>, <2 x i32> <i32 3, i32 4>
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> [[S]])
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, <2 x i32> <i32 1, i32 2>, <2 x i32> <i32 3, i32 4>
  %c = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> %s)
  ret i32 %c
}

define i32 @vec_to_scalar_select_vector(<2 x i1> %b) {
; CHECK-LABEL: @vec_to_scalar_select_vector(
; CHECK-NEXT:    [[S:%.*]] = select <2 x i1> [[B:%.*]], <2 x i32> <i32 1, i32 2>, <2 x i32> <i32 3, i32 4>
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> [[S]])
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select <2 x i1> %b, <2 x i32> <i32 1, i32 2>, <2 x i32> <i32 3, i32 4>
  %c = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> %s)
  ret i32 %c
}

define i8 @test_drop_noundef(i1 %cond, i8 %val) {
; CHECK-LABEL: @test_drop_noundef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i8 @llvm.smin.i8(i8 [[VAL:%.*]], i8 0)
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[COND:%.*]], i8 -1, i8 [[TMP0]]
; CHECK-NEXT:    ret i8 [[RET]]
;
entry:
  %sel = select i1 %cond, i8 -1, i8 %val
  %ret = call noundef i8 @llvm.smin.i8(i8 %sel, i8 0)
  ret i8 %ret
}

define i1 @pr85536(i32 %a) {
; CHECK-LABEL: @pr85536(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[A:%.*]], 31
; CHECK-NEXT:    [[SHL1:%.*]] = shl nsw i32 -1, [[A]]
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[SHL1]] to i64
; CHECK-NEXT:    [[SHL2:%.*]] = shl i64 [[ZEXT]], 48
; CHECK-NEXT:    [[SHR:%.*]] = ashr exact i64 [[SHL2]], 48
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.smin.i64(i64 [[SHR]], i64 0)
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 65535
; CHECK-NEXT:    [[RET1:%.*]] = icmp eq i64 [[TMP1]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i1 [[RET1]], i1 false
; CHECK-NEXT:    ret i1 [[RET]]
;
entry:
  %cmp1 = icmp ugt i32 %a, 30
  %shl1 = shl nsw i32 -1, %a
  %zext = zext i32 %shl1 to i64
  %shl2 = shl i64 %zext, 48
  %shr = ashr exact i64 %shl2, 48
  %sel = select i1 %cmp1, i64 -1, i64 %shr
  %smin = call noundef i64 @llvm.smin.i64(i64 %sel, i64 0)
  %masked = and i64 %smin, 65535
  %ret = icmp eq i64 %masked, 0
  ret i1 %ret
}
