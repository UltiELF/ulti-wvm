; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -replexitval=always -S | FileCheck %s
; Make sure IndVars preserves LCSSA form, especially across loop nests.

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

define void @PR18642(i32 %x) {
; CHECK-LABEL: @PR18642(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    br i1 false, label [[INNER_LATCH:%.*]], label [[OUTER_LATCH:%.*]]
; CHECK:       inner.latch:
; CHECK-NEXT:    br i1 true, label [[INNER_HEADER]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       outer.latch:
; CHECK-NEXT:    br i1 false, label [[OUTER_HEADER]], label [[EXIT_LOOPEXIT1:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ -2147483648, [[INNER_LATCH]] ]
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit.loopexit1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[EXIT_PHI:%.*]] = phi i32 [ [[INC_LCSSA]], [[EXIT_LOOPEXIT]] ], [ undef, [[EXIT_LOOPEXIT1]] ]
; CHECK-NEXT:    ret void
;
entry:
  br label %outer.header

outer.header:
  %outer.iv = phi i32 [ 0, %entry ], [ %x, %outer.latch ]
  br label %inner.header

inner.header:
  %inner.iv = phi i32 [ undef, %outer.header ], [ %inc, %inner.latch ]
  %cmp1 = icmp slt i32 %inner.iv, %outer.iv
  br i1 %cmp1, label %inner.latch, label %outer.latch

inner.latch:
  %inc = add nsw i32 %inner.iv, 1
  %cmp2 = icmp slt i32 %inner.iv, %outer.iv
  br i1 %cmp2, label %inner.header, label %exit

outer.latch:
  br i1 undef, label %outer.header, label %exit

exit:
  %exit.phi = phi i32 [ %inc, %inner.latch ], [ undef, %outer.latch ]
  ret void
}

define i64 @unconditional_exit_simplification(i64 %arg) {
; CHECK-LABEL: @unconditional_exit_simplification(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP1:%.*]]
; CHECK:       loop1:
; CHECK-NEXT:    br label [[LOOP2:%.*]]
; CHECK:       loop2:
; CHECK-NEXT:    [[IV2:%.*]] = phi i64 [ 0, [[LOOP1]] ], [ 1, [[LOOP2]] ]
; CHECK-NEXT:    br i1 true, label [[LOOP2]], label [[LOOP1_LATCH:%.*]]
; CHECK:       loop1.latch:
; CHECK-NEXT:    [[RES_LCSSA:%.*]] = phi i64 [ [[IV2]], [[LOOP2]] ]
; CHECK-NEXT:    br i1 false, label [[LOOP1]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[RES_LCSSA2:%.*]] = phi i64 [ [[RES_LCSSA]], [[LOOP1_LATCH]] ]
; CHECK-NEXT:    ret i64 [[RES_LCSSA2]]
;
entry:
  br label %loop1

loop1:
  %iv1 = phi i64 [ 0, %entry ], [ 1, %loop1.latch ]
  br label %loop2

loop2:
  %iv2 = phi i64 [ 0, %loop1 ], [ 1, %loop2 ]
  %res = add nuw nsw i64 %iv1, %iv2
  br i1 true, label %loop2, label %loop1.latch

loop1.latch:
  %res.lcssa = phi i64 [ %res, %loop2 ]
  br i1 false, label %loop1, label %exit

exit:
  %res.lcssa2 = phi i64 [ %res.lcssa, %loop1.latch ]
  ret i64 %res.lcssa2
}

; Check that it does not crash because the incoming values of an LCSSA phi are
; equal.
define void @pr57000(i64 %a) {
; CHECK-LABEL: @pr57000(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_1_OUTER:%.*]]
; CHECK:       loop.1.loopexit:
; CHECK-NEXT:    br label [[LOOP_1_OUTER]]
; CHECK:       loop.1.outer:
; CHECK-NEXT:    br label [[LOOP_1:%.*]]
; CHECK:       loop.1:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i64 [[A:%.*]], 2546175499358690212
; CHECK-NEXT:    [[CMP_EXT:%.*]] = zext i1 [[CMP]] to i8
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_1]], label [[LOOP_2_HEADER_PREHEADER:%.*]]
; CHECK:       loop.2.header.preheader:
; CHECK-NEXT:    [[CMP_LCSSA2:%.*]] = phi i1 [ [[CMP]], [[LOOP_1]] ]
; CHECK-NEXT:    [[CMP_EXT_LCSSA:%.*]] = phi i8 [ [[CMP_EXT]], [[LOOP_1]] ]
; CHECK-NEXT:    br label [[LOOP_2_HEADER_OUTER:%.*]]
; CHECK:       loop.2.header.outer:
; CHECK-NEXT:    br label [[LOOP_2_HEADER:%.*]]
; CHECK:       loop.2.header:
; CHECK-NEXT:    switch i8 [[CMP_EXT_LCSSA]], label [[LOOP_1_LOOPEXIT:%.*]] [
; CHECK-NEXT:      i8 -1, label [[LOOP_2_LATCH:%.*]]
; CHECK-NEXT:      i8 1, label [[LOOP_2_LATCH]]
; CHECK-NEXT:      i8 4, label [[LOOP_2_HEADER]]
; CHECK-NEXT:    ]
; CHECK:       loop.2.latch:
; CHECK-NEXT:    [[CMP_TRUNC_LCSSA1:%.*]] = phi i1 [ [[CMP_LCSSA2]], [[LOOP_2_HEADER]] ], [ [[CMP_LCSSA2]], [[LOOP_2_HEADER]] ]
; CHECK-NEXT:    call void @use(i1 [[CMP_TRUNC_LCSSA1]])
; CHECK-NEXT:    br label [[LOOP_2_HEADER_OUTER]]
;
entry:
  br label %loop.1

loop.1:
  %p.1 = phi i1 [ 0 , %entry ], [ %p.1, %loop.1 ], [ %p.2, %loop.2.header ]
  %cmp = icmp sle i64 %a, 2546175499358690212
  %cmp.ext = zext i1 %cmp to i8
  br i1 %cmp, label %loop.1, label %loop.2.header

loop.2.header:
  %p.2 = phi i1 [ %p.1, %loop.1 ], [ %p.2, %loop.2.header ], [ %cmp, %loop.2.latch ]
  %cmp.trunc = trunc i8 %cmp.ext to i1
  switch i8 %cmp.ext, label %loop.1 [
  i8 -1, label %loop.2.latch
  i8 1, label %loop.2.latch
  i8 4, label %loop.2.header
  ]

loop.2.latch:
  call void @use(i1 %cmp.trunc)
  br label %loop.2.header
}

define void @D149435(i16 %arg) {
; CHECK-LABEL: @D149435(
; CHECK-NEXT:    br label [[LOOP1:%.*]]
; CHECK:       loop1:
; CHECK-NEXT:    [[FR:%.*]] = freeze i16 [[ARG:%.*]]
; CHECK-NEXT:    [[ARRAYIDX_IDX:%.*]] = shl i16 [[FR]], 1
; CHECK-NEXT:    [[OR:%.*]] = or disjoint i16 [[ARRAYIDX_IDX]], 1
; CHECK-NEXT:    br i1 false, label [[LOOP1]], label [[LOOP2_PREHEADER:%.*]]
; CHECK:       loop2.preheader:
; CHECK-NEXT:    [[FR_LCSSA:%.*]] = phi i16 [ [[FR]], [[LOOP1]] ]
; CHECK-NEXT:    [[OR_LCSSA:%.*]] = phi i16 [ [[OR]], [[LOOP1]] ]
; CHECK-NEXT:    [[UMAX:%.*]] = call i16 @llvm.umax.i16(i16 [[OR_LCSSA]], i16 2)
; CHECK-NEXT:    [[TMP1:%.*]] = add i16 [[UMAX]], -1
; CHECK-NEXT:    [[TMP2:%.*]] = shl i16 [[FR_LCSSA]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = sub i16 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i16 [[TMP3]], 0
; CHECK-NEXT:    [[UMAX1:%.*]] = call i16 @llvm.umax.i16(i16 [[ARG]], i16 2)
; CHECK-NEXT:    [[TMP5:%.*]] = sub i16 [[UMAX1]], [[ARG]]
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i16 [[TMP5]], 0
; CHECK-NEXT:    br label [[LOOP2:%.*]]
; CHECK:       loop2:
; CHECK-NEXT:    br i1 [[TMP4]], label [[TRAP:%.*]], label [[FOR_BODY8:%.*]]
; CHECK:       for.body8:
; CHECK-NEXT:    br i1 [[TMP6]], label [[TRAP]], label [[LOOP2_LATCH:%.*]]
; CHECK:       loop2.latch:
; CHECK-NEXT:    br i1 false, label [[LOOP2]], label [[TRAP]]
; CHECK:       trap:
; CHECK-NEXT:    unreachable
;
  br label %loop1

loop1:
  %fr = freeze i16 %arg
  %arrayidx.idx = shl i16 %fr, 1
  %or = or disjoint i16 %arrayidx.idx, 1
  br i1 false, label %loop1, label %loop2.preheader

loop2.preheader:
  br label %loop2

loop2:
  %iv = phi i16 [ %iv.next, %loop2.latch ], [ 0, %loop2.preheader ]
  %add = add i16 %or, %iv
  %cmp = icmp ugt i16 %add, 1
  br i1 %cmp, label %trap, label %for.body8

for.body8:
  %add2 = add i16 %arg, %iv
  %cmp2 = icmp ugt i16 %add2, 1
  br i1 %cmp2, label %trap, label %loop2.latch

loop2.latch:
  %iv.next = add i16 %iv, 1
  br i1 false, label %loop2, label %trap

trap:
  unreachable
}

declare void @use(i1)
