; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p indvars -S -o - %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

; Based on TSVC s172.
define void @test_s172(i32 noundef %xa, i32 noundef %xb, ptr nocapture noundef %a, ptr nocapture noundef readonly %b) {
; CHECK-LABEL: define void @test_s172(
; CHECK-SAME: i32 noundef [[XA:%.*]], i32 noundef [[XB:%.*]], ptr nocapture noundef [[A:%.*]], ptr nocapture noundef readonly [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[XA]], -1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[XA]], 32001
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[SUB]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[XB]] to i64
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[TMP0]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], [[TMP1]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i64 [[INDVARS_IV_NEXT]], 32000
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END_LOOPEXIT:%.*]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %sub = add nsw i32 %xa, -1
  %cmp1 = icmp slt i32 %xa, 32001
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:
  br label %for.body

for.body:
  %i.02 = phi i32 [ %add3, %for.body ], [ %sub, %for.body.preheader ]
  %idxprom = sext i32 %i.02 to i64
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %a, i64 %idxprom
  %1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %1, %0
  store i32 %add, ptr %arrayidx2, align 4
  %add3 = add nsw i32 %i.02, %xb
  %cmp = icmp slt i32 %add3, 32000
  br i1 %cmp, label %for.body, label %for.end.loopexit, !llvm.loop !0

for.end.loopexit:
  br label %for.end

for.end:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.mustprogress"}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.mustprogress"}
;.
