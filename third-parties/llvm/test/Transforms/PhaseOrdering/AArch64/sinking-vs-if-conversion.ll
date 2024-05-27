; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes='default<O2>' -S %s | FileCheck %s

target triple = "arm64-apple-macosx"

; A set of test cases where early sinking prevents if-conversion.

%struct.Tree = type { ptr, ptr, i32 }
%struct.Node = type { i32, i32, i32 }

define void @test_find_min(ptr noundef nonnull align 8 dereferenceable(24) %this) {
; CHECK-LABEL: define void @test_find_min(
; CHECK-SAME: ptr nocapture noundef nonnull align 8 dereferenceable(24) [[THIS:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[NUM_:%.*]] = getelementptr inbounds [[STRUCT_TREE:%.*]], ptr [[THIS]], i64 0, i32 2
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[NUM_]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[THIS]], align 8
; CHECK-NEXT:    [[CMP8:%.*]] = icmp sgt i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP8]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[ARRAY_:%.*]] = getelementptr inbounds [[STRUCT_TREE]], ptr [[THIS]], i64 0, i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[ARRAY_]], align 8
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext nneg i32 [[TMP0]] to i64
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[FOR_BODY_LR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[COND_END7:%.*]] ]
; CHECK-NEXT:    [[MIN_010:%.*]] = phi ptr [ [[TMP1]], [[FOR_BODY_LR_PH]] ], [ [[COND8:%.*]], [[COND_END7]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds ptr, ptr [[TMP2]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CMP3:%.*]] = icmp eq ptr [[MIN_010]], null
; CHECK-NEXT:    br i1 [[CMP3]], label [[COND_END7]], label [[COND_FALSE:%.*]]
; CHECK:       cond.false:
; CHECK-NEXT:    [[KEY2:%.*]] = getelementptr inbounds [[STRUCT_NODE:%.*]], ptr [[MIN_010]], i64 0, i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[KEY2]], align 4
; CHECK-NEXT:    [[KEY:%.*]] = getelementptr inbounds [[STRUCT_NODE]], ptr [[TMP3]], i64 0, i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[KEY]], align 4
; CHECK-NEXT:    [[CMP4:%.*]] = icmp slt i32 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[COND:%.*]] = select i1 [[CMP4]], ptr [[TMP3]], ptr [[MIN_010]]
; CHECK-NEXT:    br label [[COND_END7]]
; CHECK:       cond.end7:
; CHECK-NEXT:    [[COND8]] = phi ptr [ [[COND]], [[COND_FALSE]] ], [ [[TMP3]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    [[MIN_0_LCSSA:%.*]] = phi ptr [ [[TMP1]], [[ENTRY:%.*]] ], [ [[COND8]], [[COND_END7]] ]
; CHECK-NEXT:    store ptr [[MIN_0_LCSSA]], ptr [[THIS]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %this.addr = alloca ptr, align 8
  %num = alloca i32, align 4
  %min = alloca ptr, align 8
  %i = alloca i32, align 4
  %x = alloca ptr, align 8
  %xkey = alloca i32, align 4
  %minkey = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %num_ = getelementptr inbounds %struct.Tree, ptr %this1, i32 0, i32 2
  %0 = load i32, ptr %num_, align 8
  store i32 %0, ptr %num, align 4
  %min_ = getelementptr inbounds %struct.Tree, ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %min_, align 8
  store ptr %1, ptr %min, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, ptr %i, align 4
  %3 = load i32, ptr %num, align 4
  %cmp = icmp slt i32 %2, %3
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %array_ = getelementptr inbounds %struct.Tree, ptr %this1, i32 0, i32 1
  %4 = load ptr, ptr %array_, align 8
  %5 = load i32, ptr %i, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds ptr, ptr %4, i64 %idxprom
  %6 = load ptr, ptr %arrayidx, align 8
  store ptr %6, ptr %x, align 8
  %7 = load ptr, ptr %x, align 8
  %key = getelementptr inbounds %struct.Node, ptr %7, i32 0, i32 1
  %8 = load i32, ptr %key, align 4
  store i32 %8, ptr %xkey, align 4
  %9 = load ptr, ptr %min, align 8
  %key2 = getelementptr inbounds %struct.Node, ptr %9, i32 0, i32 1
  %10 = load i32, ptr %key2, align 4
  store i32 %10, ptr %minkey, align 4
  %11 = load ptr, ptr %min, align 8
  %cmp3 = icmp eq ptr %11, null
  br i1 %cmp3, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.body
  %12 = load ptr, ptr %x, align 8
  br label %cond.end7

cond.false:                                       ; preds = %for.body
  %13 = load i32, ptr %xkey, align 4
  %14 = load i32, ptr %minkey, align 4
  %cmp4 = icmp slt i32 %13, %14
  br i1 %cmp4, label %cond.true5, label %cond.false6

cond.true5:                                       ; preds = %cond.false
  %15 = load ptr, ptr %x, align 8
  br label %cond.end

cond.false6:                                      ; preds = %cond.false
  %16 = load ptr, ptr %min, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false6, %cond.true5
  %cond = phi ptr [ %15, %cond.true5 ], [ %16, %cond.false6 ]
  br label %cond.end7

cond.end7:                                        ; preds = %cond.end, %cond.true
  %cond8 = phi ptr [ %12, %cond.true ], [ %cond, %cond.end ]
  store ptr %cond8, ptr %min, align 8
  br label %for.inc

for.inc:                                          ; preds = %cond.end7
  %17 = load i32, ptr %i, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond.cleanup
  %18 = load ptr, ptr %min, align 8
  %min_9 = getelementptr inbounds %struct.Tree, ptr %this1, i32 0, i32 0
  store ptr %18, ptr %min_9, align 8
  ret void
}


define void @cond_select_loop(ptr noalias nocapture noundef readonly %a, ptr noalias nocapture noundef readonly %b, ptr noalias nocapture noundef writeonly %c) {
; CHECK-LABEL: define void @cond_select_loop(
; CHECK-SAME: ptr noalias nocapture noundef readonly [[A:%.*]], ptr noalias nocapture noundef readonly [[B:%.*]], ptr noalias nocapture noundef writeonly [[C:%.*]]) local_unnamed_addr #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_07:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[COND_END:%.*]] ]
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[I_07]]
; CHECK-NEXT:    [[TMP0:%.*]] = load float, ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp ogt float [[TMP0]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP2]], label [[COND_END]], label [[COND_FALSE:%.*]]
; CHECK:       cond.false:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[B]], i64 [[I_07]]
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi float [ [[TMP1]], [[COND_FALSE]] ], [ [[TMP0]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds float, ptr [[C]], i64 [[I_07]]
; CHECK-NEXT:    store float [[COND]], ptr [[ARRAYIDX4]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_07]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC]], 1000
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  %c.addr = alloca ptr, align 8
  %i = alloca i64, align 8
  %_b = alloca float, align 4
  store ptr %a, ptr %a.addr, align 8
  store ptr %b, ptr %b.addr, align 8
  store ptr %c, ptr %c.addr, align 8
  store i64 0, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i64, ptr %i, align 8
  %cmp = icmp ult i64 %0, 1000
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %b.addr, align 8
  %2 = load i64, ptr %i, align 8
  %arrayidx = getelementptr inbounds float, ptr %1, i64 %2
  %3 = load float, ptr %arrayidx, align 4
  store float %3, ptr %_b, align 4
  %4 = load ptr, ptr %a.addr, align 8
  %5 = load i64, ptr %i, align 8
  %arrayidx1 = getelementptr inbounds float, ptr %4, i64 %5
  %6 = load float, ptr %arrayidx1, align 4
  %cmp2 = fcmp ogt float %6, 0.000000e+00
  br i1 %cmp2, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.body
  %7 = load ptr, ptr %a.addr, align 8
  %8 = load i64, ptr %i, align 8
  %arrayidx3 = getelementptr inbounds float, ptr %7, i64 %8
  %9 = load float, ptr %arrayidx3, align 4
  br label %cond.end

cond.false:                                       ; preds = %for.body
  %10 = load float, ptr %_b, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %9, %cond.true ], [ %10, %cond.false ]
  %11 = load ptr, ptr %c.addr, align 8
  %12 = load i64, ptr %i, align 8
  %arrayidx4 = getelementptr inbounds float, ptr %11, i64 %12
  store float %cond, ptr %arrayidx4, align 4
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %13 = load i64, ptr %i, align 8
  %inc = add i64 %13, 1
  store i64 %inc, ptr %i, align 8
  br label %for.cond

for.end:
  ret void
}
