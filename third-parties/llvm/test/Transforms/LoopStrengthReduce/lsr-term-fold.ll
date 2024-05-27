; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes="loop-reduce" -S -lsr-term-fold | FileCheck %s

target datalayout = "e-p:64:64:64-n64"

define void @const_tripcount(ptr %a) {
; CHECK-LABEL: @const_tripcount(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 1600
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i64 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i64 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i64 [ %lsr.iv.next, %for.body ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i64 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i64 4
  %exitcond.not = icmp eq i64 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

define void @runtime_tripcount(ptr %a, i32 %N) {
; CHECK-LABEL: @runtime_tripcount(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i32 84
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i32 [[N:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = shl nuw nsw i64 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 88
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP3]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i64 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i32 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ %N, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i64 4
  %exitcond.not = icmp eq i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; In this case, the i8 IVs increment *isn't* nsw.  As a result, a N of 0
; is well defined, and thus the post-inc starts at 255.
define void @wrap_around(ptr %a, i8 %N) {
; CHECK-LABEL: @wrap_around(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i8 [[N:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = shl nuw nsw i64 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 4
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 [[TMP3]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[A]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i8 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i64 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %a, %entry ]
  %lsr.iv = phi i8 [ %lsr.iv.next, %for.body ], [ %N, %entry ]
  store i8 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add i8 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i64 4
  %exitcond.not = icmp eq i8 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; The replacing AddRec IV is a complicated AddRec. This tests whether
; the fold terminating condition transformation is writing new terminating
; condition in the correct type.
define void @ptr_of_ptr_addrec(ptr %ptrptr, i32 %length) {
; CHECK-LABEL: @ptr_of_ptr_addrec(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[START_PTRPTR:%.*]] = getelementptr ptr, ptr [[PTRPTR:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[LENGTH:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = shl nuw nsw i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 8
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[START_PTRPTR]], i64 [[TMP3]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IT_04:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[START_PTRPTR]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[IT_04]], align 8
; CHECK-NEXT:    tail call void @foo(ptr [[TMP4]])
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr ptr, ptr [[IT_04]], i64 1
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[INCDEC_PTR]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %start.ptrptr = getelementptr inbounds ptr, ptr %ptrptr
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %dec, %for.body ], [ %length, %entry ]
  %it.04 = phi ptr [ %incdec.ptr, %for.body ], [ %start.ptrptr, %entry ]
  %0 = load ptr, ptr %it.04, align 8
  tail call void @foo(ptr %0)
  %incdec.ptr = getelementptr inbounds ptr, ptr %it.04, i64 1
  %dec = add nsw i32 %i.05, -1
  %tobool.not = icmp eq i32 %dec, 0
  br i1 %tobool.not, label %for.end, label %for.body

for.end:                                 ; preds = %for.body
  ret void
}

declare void @foo(ptr)

define void @iv_start_non_preheader(ptr %mark, i32 signext %length) {
; CHECK-LABEL: @iv_start_non_preheader(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TOBOOL_NOT3:%.*]] = icmp eq i32 [[LENGTH:%.*]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT3]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[LENGTH]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = shl nuw nsw i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 8
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[MARK:%.*]], i64 [[TMP3]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[DST_04:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[MARK]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[DST_04]], align 8
; CHECK-NEXT:    [[TMP5:%.*]] = call ptr @foo(ptr [[TMP4]])
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr ptr, ptr [[DST_04]], i64 1
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[INCDEC_PTR]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[FOR_BODY]]
;
entry:
  %tobool.not3 = icmp eq i32 %length, 0
  br i1 %tobool.not3, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %dec, %for.body ], [ %length, %entry ]
  %dst.04 = phi ptr [ %incdec.ptr, %for.body ], [ %mark, %entry ]
  %0 = load ptr, ptr %dst.04, align 8
  call ptr @foo(ptr %0)
  %incdec.ptr = getelementptr inbounds ptr, ptr %dst.04, i64 1
  %dec = add nsw i32 %i.05, -1
  %tobool.not = icmp eq i32 %dec, 0
  br i1 %tobool.not, label %for.cond.cleanup, label %for.body
}

; Consider the case where %a points to a buffer exactly 17 bytes long.  The
; loop below will access bytes: 0, 4, 8, and 16.  The key bit is that we
; advance the pointer IV by *4* each time, and thus on the iteration we write
; byte 16, %uglygep2 (the pointer increment) is past the end of the underlying
; storage and thus violates the inbounds requirements.  As a result, %uglygep2
; is poison on the final iteration.  If we insert a branch on that value
; (without stripping the poison flag), we have inserted undefined behavior
; where it did not previously exist.
define void @inbounds_poison_use(ptr %a) {
; CHECK-LABEL: @inbounds_poison_use(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 16
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[A]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i8 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i64 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %a, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 4, %entry ]
  store i8 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr inbounds i8, ptr %lsr.iv1, i64 4
  %exitcond.not = icmp eq i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; In this case, the integer IV has a larger bitwidth than the pointer IV.
; This means that the smaller IV may wrap around multiple times before
; the original loop exit is taken.
define void @iv_size(ptr %a, i128 %N) {
; CHECK-LABEL: @iv_size(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[A:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[LSR_IV:%.*]] = phi i128 [ [[LSR_IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[N:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[LSR_IV_NEXT]] = add nsw i128 [[LSR_IV]], -1
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i64 4
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i128 [[LSR_IV_NEXT]], 0
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %a, %entry ]
  %lsr.iv = phi i128 [ %lsr.iv.next, %for.body ], [ %N, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i128 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i64 4
  %exitcond.not = icmp eq i128 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; To check correct folding not equality terminating condition
; Due to SLE offset must be - 1600
define void @IcmpSle(ptr %a) {
; CHECK-LABEL: @IcmpSle(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i32 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 1600
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i32 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 4
  %exitcond.not = icmp sle i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Due to SLT offset must be - 1604
define void @IcmpSlt(ptr %a) {
; CHECK-LABEL: @IcmpSlt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i32 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 1604
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i32 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 4
  %exitcond.not = icmp slt i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Invert predicate and branches
define void @IcmpSgt(ptr %a) {
; CHECK-LABEL: @IcmpSgt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i32 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 1600
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 4
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i32 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 4
  %exitcond.not = icmp sgt i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; Invert predicate and branches
define void @SeveralLoopLatch(ptr %a) {
; CHECK-LABEL: @SeveralLoopLatch(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i32 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 1600
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[ANOTHER_BRANCH:%.*]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 4
; CHECK-NEXT:    br label [[ANOTHER_BRANCH]]
; CHECK:       another.branch:
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i32 84
  br label %for.body

for.body:                                         ; preds = %another.branch, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %another.branch ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %another.branch ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 4
  br label %another.branch

another.branch:
  %exitcond.not = icmp sgt i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; Invert branch in SeveralLoopLatch
define void @SeveralLoopLatch2(ptr %a) {
; CHECK-LABEL: @SeveralLoopLatch2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i32 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 1600
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[ANOTHER_BRANCH:%.*]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 4
; CHECK-NEXT:    br label [[ANOTHER_BRANCH]]
; CHECK:       another.branch:
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i32 84
  br label %for.body

for.body:                                         ; preds = %another.branch, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %another.branch ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %another.branch ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 4
  br label %another.branch

another.branch:
  %exitcond.not = icmp sle i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}


define void @non_branch_terminator(ptr %a) {
; CHECK-LABEL: @non_branch_terminator(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 84
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV2:%.*]] = phi i64 [ [[LSR_IV_NEXT3:%.*]], [[FOR_BODY]] ], [ 378, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i64 4
; CHECK-NEXT:    [[LSR_IV_NEXT3]] = add nsw i64 [[LSR_IV2]], -1
; CHECK-NEXT:    switch i64 [[LSR_IV2]], label [[FOR_BODY]] [
; CHECK-NEXT:      i64 0, label [[FOR_END:%.*]]
; CHECK-NEXT:    ]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %uglygep = getelementptr i8, ptr %a, i64 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i64 [ %lsr.iv.next, %for.body ], [ 379, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i64 %lsr.iv, -1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i64 4
  switch i64 %lsr.iv.next, label %for.body [i64 0, label %for.end]

for.end:                                          ; preds = %for.body
  ret void
}

define void @expensive_expand_short_tc(ptr %a, i32 %offset, i32 %n) {
; CHECK-LABEL: @expensive_expand_short_tc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OFFSET_NONZERO:%.*]] = or i32 [[OFFSET:%.*]], 1
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 84
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = sext i32 [[OFFSET_NONZERO]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = add nsw i64 [[TMP4]], 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP5]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 [[OFFSET_NONZERO]]
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]], !prof [[PROF0:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %offset.nonzero = or i32 %offset, 1
  %uglygep = getelementptr i8, ptr %a, i64 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 0, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, 1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 %offset.nonzero
  %exitcond.not = icmp eq i32 %lsr.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !prof !{!"branch_weights", i32 1, i32 3}

for.end:                                          ; preds = %for.body
  ret void
}

define void @expensive_expand_long_tc(ptr %a, i32 %offset, i32 %n) {
; CHECK-LABEL: @expensive_expand_long_tc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OFFSET_NONZERO:%.*]] = or i32 [[OFFSET:%.*]], 1
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 84
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = sext i32 [[OFFSET_NONZERO]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = add nsw i64 [[TMP4]], 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP5]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 [[OFFSET_NONZERO]]
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]], !prof [[PROF1:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %offset.nonzero = or i32 %offset, 1
  %uglygep = getelementptr i8, ptr %a, i64 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 0, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, 1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 %offset.nonzero
  %exitcond.not = icmp eq i32 %lsr.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !prof !{!"branch_weights", i32 1, i32 300}

for.end:                                          ; preds = %for.body
  ret void
}

define void @expensive_expand_unknown_tc(ptr %a, i32 %offset, i32 %n) {
; CHECK-LABEL: @expensive_expand_unknown_tc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OFFSET_NONZERO:%.*]] = or i32 [[OFFSET:%.*]], 1
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 84
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = sext i32 [[OFFSET_NONZERO]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = add nsw i64 [[TMP4]], 84
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP5]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV1:%.*]] = phi ptr [ [[UGLYGEP2:%.*]], [[FOR_BODY]] ], [ [[UGLYGEP]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    store i32 1, ptr [[LSR_IV1]], align 4
; CHECK-NEXT:    [[UGLYGEP2]] = getelementptr i8, ptr [[LSR_IV1]], i32 [[OFFSET_NONZERO]]
; CHECK-NEXT:    [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND:%.*]] = icmp eq ptr [[UGLYGEP2]], [[SCEVGEP]]
; CHECK-NEXT:    br i1 [[LSR_FOLD_TERM_COND_REPLACED_TERM_COND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %offset.nonzero = or i32 %offset, 1
  %uglygep = getelementptr i8, ptr %a, i64 84
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %lsr.iv1 = phi ptr [ %uglygep2, %for.body ], [ %uglygep, %entry ]
  %lsr.iv = phi i32 [ %lsr.iv.next, %for.body ], [ 0, %entry ]
  store i32 1, ptr %lsr.iv1, align 4
  %lsr.iv.next = add nsw i32 %lsr.iv, 1
  %uglygep2 = getelementptr i8, ptr %lsr.iv1, i32 %offset.nonzero
  %exitcond.not = icmp eq i32 %lsr.iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}
