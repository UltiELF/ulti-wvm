; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-bound-split -S < %s | FileCheck %s

@B = external global [10 x i16], align 1

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[ENTRY_SPLIT]] ], [ [[INC_0:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[I_1:%.*]] = phi i16 [ 10, [[ENTRY_SPLIT]] ], [ [[INC_0]], [[FOR_INC]] ]
; CHECK-NEXT:    [[I_2:%.*]] = phi i16 [ 10, [[ENTRY_SPLIT]] ], [ [[INC_2:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[I_3:%.*]] = phi i16 [ 15, [[ENTRY_SPLIT]] ], [ 30, [[FOR_INC]] ]
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i16 [[I_0]], 5
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[ENTRY_SPLIT_SPLIT:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i16 [[I_0]], 5
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [10 x i16], ptr @B, i16 0, i16 [[I_0]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i16, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    br i1 true, label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @foo(i16 [[TMP0]], i16 [[I_3]])
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       if.else:
; CHECK-NEXT:    call void @bar(i16 [[TMP0]], i16 [[I_3]])
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC_0]] = add nuw nsw i16 [[I_0]], 1
; CHECK-NEXT:    [[INC_2]] = add nuw nsw i16 [[I_2]], 2
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       entry.split.split:
; CHECK-NEXT:    [[I_0_LCSSA:%.*]] = phi i16 [ [[I_0]], [[FOR_COND]] ]
; CHECK-NEXT:    [[I_1_LCSSA:%.*]] = phi i16 [ [[I_1]], [[FOR_COND]] ]
; CHECK-NEXT:    [[I_2_LCSSA:%.*]] = phi i16 [ [[I_2]], [[FOR_COND]] ]
; CHECK-NEXT:    [[I_3_LCSSA:%.*]] = phi i16 [ [[I_3]], [[FOR_COND]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne i16 [[I_0_LCSSA]], 10
; CHECK-NEXT:    br i1 [[TMP1]], label [[FOR_COND_SPLIT_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.cond.split.preheader:
; CHECK-NEXT:    br label [[FOR_COND_SPLIT:%.*]]
; CHECK:       for.cond.split:
; CHECK-NEXT:    [[I_0_SPLIT:%.*]] = phi i16 [ [[INC_0_SPLIT:%.*]], [[FOR_INC_SPLIT:%.*]] ], [ [[I_0_LCSSA]], [[FOR_COND_SPLIT_PREHEADER]] ]
; CHECK-NEXT:    [[I_1_SPLIT:%.*]] = phi i16 [ [[INC_0_SPLIT]], [[FOR_INC_SPLIT]] ], [ [[I_1_LCSSA]], [[FOR_COND_SPLIT_PREHEADER]] ]
; CHECK-NEXT:    [[I_2_SPLIT:%.*]] = phi i16 [ [[INC_2_SPLIT:%.*]], [[FOR_INC_SPLIT]] ], [ [[I_2_LCSSA]], [[FOR_COND_SPLIT_PREHEADER]] ]
; CHECK-NEXT:    [[I_3_SPLIT:%.*]] = phi i16 [ 30, [[FOR_INC_SPLIT]] ], [ [[I_3_LCSSA]], [[FOR_COND_SPLIT_PREHEADER]] ]
; CHECK-NEXT:    [[EXITCOND_NOT_SPLIT:%.*]] = icmp eq i16 [[I_0_SPLIT]], 10
; CHECK-NEXT:    br i1 [[EXITCOND_NOT_SPLIT]], label [[FOR_END_LOOPEXIT:%.*]], label [[FOR_BODY_SPLIT:%.*]]
; CHECK:       for.body.split:
; CHECK-NEXT:    [[CMP1_SPLIT:%.*]] = icmp ult i16 [[I_0_SPLIT]], 5
; CHECK-NEXT:    [[ARRAYIDX_SPLIT:%.*]] = getelementptr inbounds [10 x i16], ptr @B, i16 0, i16 [[I_0_SPLIT]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i16, ptr [[ARRAYIDX_SPLIT]], align 1
; CHECK-NEXT:    br i1 false, label [[IF_THEN_SPLIT:%.*]], label [[IF_ELSE_SPLIT:%.*]]
; CHECK:       if.else.split:
; CHECK-NEXT:    call void @bar(i16 [[TMP2]], i16 [[I_3_SPLIT]])
; CHECK-NEXT:    br label [[FOR_INC_SPLIT]]
; CHECK:       if.then.split:
; CHECK-NEXT:    call void @foo(i16 [[TMP2]], i16 [[I_3_SPLIT]])
; CHECK-NEXT:    br label [[FOR_INC_SPLIT]]
; CHECK:       for.inc.split:
; CHECK-NEXT:    [[INC_0_SPLIT]] = add nuw nsw i16 [[I_0_SPLIT]], 1
; CHECK-NEXT:    [[INC_2_SPLIT]] = add nuw nsw i16 [[I_2_SPLIT]], 2
; CHECK-NEXT:    br label [[FOR_COND_SPLIT]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ 0, %entry ], [ %inc.0, %for.inc ]
  %i.1 = phi i16 [ 10, %entry ], [ %inc.0, %for.inc ]
  %i.2 = phi i16 [ 10, %entry ], [ %inc.2, %for.inc ]
  %i.3 = phi i16 [ 15, %entry ], [ 30, %for.inc ]
  %exitcond.not = icmp eq i16 %i.0, 10
  br i1 %exitcond.not, label %for.end, label %for.body

for.body:                                         ; preds = %for.cond
  %cmp1 = icmp ult i16 %i.0, 5
  %arrayidx = getelementptr inbounds [10 x i16], ptr @B, i16 0, i16 %i.0
  %0 = load i16, ptr %arrayidx, align 1
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  call void @foo(i16 %0, i16 %i.3)
  br label %for.inc

if.else:                                          ; preds = %for.body
  call void @bar(i16 %0, i16 %i.3)
  br label %for.inc

for.inc:                                          ; preds = %if.else, %if.then
  %inc.0 = add nuw nsw i16 %i.0, 1
  %inc.2 = add nuw nsw i16 %i.2, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare void @foo(i16, i16)
declare void @bar(i16, i16)
