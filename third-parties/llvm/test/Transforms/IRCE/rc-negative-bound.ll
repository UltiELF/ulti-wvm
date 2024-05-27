; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -verify-loop-info -irce-print-changed-loops -passes=irce -S < %s 2>&1 | FileCheck %s
; RUN: opt -verify-loop-info -irce-print-changed-loops -passes='require<branch-prob>,irce' -S < %s 2>&1 | FileCheck %s

; CHECK-NOT: irce: in function test_01: constrained Loop
; CHECK-NOT: irce: in function test_02: constrained Loop
; CHECK: irce: in function test_03: constrained Loop

; RC against known negative value. We should not do IRCE here.
define void @test_01(ptr %arr, i32 %n) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp slt i32 [[IDX]], -9
; CHECK-NEXT:    br i1 [[ABC]], label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS:%.*]], !prof [[PROF0:![0-9]+]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp slt i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;

  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp slt i32 %idx, -9
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp slt i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; Same as test_01, but the latch condition is unsigned.
define void @test_02(ptr %arr, i32 %n) {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp slt i32 [[IDX]], -9
; CHECK-NEXT:    br i1 [[ABC]], label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp ult i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;

  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp slt i32 %idx, -9
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp ult i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; RC against a value which is not known to be non-negative. Here we should
; expand runtime checks against bound being positive or negative.
define void @test_03(ptr %arr, i32 %n, i32 %bound) {
; CHECK-LABEL: @test_03(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[BOUND:%.*]], -2147483647
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[TMP0]], i32 0)
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[BOUND]], [[SMAX]]
; CHECK-NEXT:    [[SMIN:%.*]] = call i32 @llvm.smin.i32(i32 [[BOUND]], i32 0)
; CHECK-NEXT:    [[SMAX1:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN]], i32 -1)
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw i32 [[SMAX1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = mul i32 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[SMIN2:%.*]] = call i32 @llvm.smin.i32(i32 [[N]], i32 [[TMP3]])
; CHECK-NEXT:    [[EXIT_MAINLOOP_AT:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN2]], i32 0)
; CHECK-NEXT:    [[TMP4:%.*]] = icmp slt i32 0, [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP4]], label [[LOOP_PREHEADER4:%.*]], label [[MAIN_PSEUDO_EXIT:%.*]]
; CHECK:       loop.preheader4:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER4]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add nsw i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp slt i32 [[IDX]], [[BOUND]]
; CHECK-NEXT:    br i1 true, label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS_LOOPEXIT5:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp slt i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp slt i32 [[IDX_NEXT]], [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[LOOP]], label [[MAIN_EXIT_SELECTOR:%.*]]
; CHECK:       main.exit.selector:
; CHECK-NEXT:    [[IDX_NEXT_LCSSA:%.*]] = phi i32 [ [[IDX_NEXT]], [[IN_BOUNDS]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = icmp slt i32 [[IDX_NEXT_LCSSA]], [[N]]
; CHECK-NEXT:    br i1 [[TMP6]], label [[MAIN_PSEUDO_EXIT]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       main.pseudo.exit:
; CHECK-NEXT:    [[IDX_COPY:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    [[INDVAR_END:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    br label [[POSTLOOP:%.*]]
; CHECK:       out.of.bounds.loopexit:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS:%.*]]
; CHECK:       out.of.bounds.loopexit5:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit.loopexit:
; CHECK-NEXT:    br label [[EXIT_LOOPEXIT]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       postloop:
; CHECK-NEXT:    br label [[LOOP_POSTLOOP:%.*]]
; CHECK:       loop.postloop:
; CHECK-NEXT:    [[IDX_POSTLOOP:%.*]] = phi i32 [ [[IDX_NEXT_POSTLOOP:%.*]], [[IN_BOUNDS_POSTLOOP:%.*]] ], [ [[IDX_COPY]], [[POSTLOOP]] ]
; CHECK-NEXT:    [[IDX_NEXT_POSTLOOP]] = add i32 [[IDX_POSTLOOP]], 1
; CHECK-NEXT:    [[ABC_POSTLOOP:%.*]] = icmp slt i32 [[IDX_POSTLOOP]], [[BOUND]]
; CHECK-NEXT:    br i1 [[ABC_POSTLOOP]], label [[IN_BOUNDS_POSTLOOP]], label [[OUT_OF_BOUNDS_LOOPEXIT:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds.postloop:
; CHECK-NEXT:    [[ADDR_POSTLOOP:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX_POSTLOOP]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR_POSTLOOP]], align 4
; CHECK-NEXT:    [[NEXT_POSTLOOP:%.*]] = icmp slt i32 [[IDX_NEXT_POSTLOOP]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT_POSTLOOP]], label [[LOOP_POSTLOOP]], label [[EXIT_LOOPEXIT_LOOPEXIT:%.*]], !llvm.loop [[LOOP1:![0-9]+]], !loop_constrainer.loop.clone [[META6:![0-9]+]]
;

  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp slt i32 %idx, %bound
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp slt i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; RC against a value which is not known to be non-negative. Here we should
; expand runtime checks against bound being positive or negative.
define void @test_04(ptr %arr, i32 %n, i32 %bound) {
; CHECK-LABEL: @test_04(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[SMIN:%.*]] = call i32 @llvm.smin.i32(i32 [[BOUND:%.*]], i32 0)
; CHECK-NEXT:    [[TMP0:%.*]] = sub i32 [[BOUND]], [[SMIN]]
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN]], i32 -1)
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw i32 [[SMAX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = mul i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[EXIT_MAINLOOP_AT:%.*]] = call i32 @llvm.umin.i32(i32 [[N]], i32 [[TMP2]])
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i32 0, [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[LOOP_PREHEADER1:%.*]], label [[MAIN_PSEUDO_EXIT:%.*]]
; CHECK:       loop.preheader1:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER1]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp slt i32 [[IDX]], [[BOUND]]
; CHECK-NEXT:    br i1 true, label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS_LOOPEXIT2:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp ult i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ult i32 [[IDX_NEXT]], [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP4]], label [[LOOP]], label [[MAIN_EXIT_SELECTOR:%.*]]
; CHECK:       main.exit.selector:
; CHECK-NEXT:    [[IDX_NEXT_LCSSA:%.*]] = phi i32 [ [[IDX_NEXT]], [[IN_BOUNDS]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ult i32 [[IDX_NEXT_LCSSA]], [[N]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[MAIN_PSEUDO_EXIT]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       main.pseudo.exit:
; CHECK-NEXT:    [[IDX_COPY:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    [[INDVAR_END:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    br label [[POSTLOOP:%.*]]
; CHECK:       out.of.bounds.loopexit:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS:%.*]]
; CHECK:       out.of.bounds.loopexit2:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit.loopexit:
; CHECK-NEXT:    br label [[EXIT_LOOPEXIT]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       postloop:
; CHECK-NEXT:    br label [[LOOP_POSTLOOP:%.*]]
; CHECK:       loop.postloop:
; CHECK-NEXT:    [[IDX_POSTLOOP:%.*]] = phi i32 [ [[IDX_NEXT_POSTLOOP:%.*]], [[IN_BOUNDS_POSTLOOP:%.*]] ], [ [[IDX_COPY]], [[POSTLOOP]] ]
; CHECK-NEXT:    [[IDX_NEXT_POSTLOOP]] = add i32 [[IDX_POSTLOOP]], 1
; CHECK-NEXT:    [[ABC_POSTLOOP:%.*]] = icmp slt i32 [[IDX_POSTLOOP]], [[BOUND]]
; CHECK-NEXT:    br i1 [[ABC_POSTLOOP]], label [[IN_BOUNDS_POSTLOOP]], label [[OUT_OF_BOUNDS_LOOPEXIT:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds.postloop:
; CHECK-NEXT:    [[ADDR_POSTLOOP:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX_POSTLOOP]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR_POSTLOOP]], align 4
; CHECK-NEXT:    [[NEXT_POSTLOOP:%.*]] = icmp ult i32 [[IDX_NEXT_POSTLOOP]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT_POSTLOOP]], label [[LOOP_POSTLOOP]], label [[EXIT_LOOPEXIT_LOOPEXIT:%.*]], !llvm.loop [[LOOP7:![0-9]+]], !loop_constrainer.loop.clone [[META6]]
;

  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp slt i32 %idx, %bound
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp ult i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; Same as test_01, unsigned range check.
; FIXME: We could remove the range check here, but it does not happen due to the
; limintation we posed to fix the miscompile (see comments in the method
; computeSafeIterationSpace).
define void @test_05(ptr %arr, i32 %n) {
; CHECK-LABEL: @test_05(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp ult i32 [[IDX]], -9
; CHECK-NEXT:    br i1 [[ABC]], label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp slt i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp ult i32 %idx, -9
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp slt i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; Same as test_02, unsigned range check.
; FIXME: We could remove the range check here, but it does not happen due to the
; limintation we posed to fix the miscompile (see comments in the method
; computeSafeIterationSpace).
define void @test_06(ptr %arr, i32 %n) {
; CHECK-LABEL: @test_06(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp ult i32 [[IDX]], -9
; CHECK-NEXT:    br i1 [[ABC]], label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp ult i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp ult i32 %idx, -9
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp ult i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; Same as test_03, unsigned range check.
; FIXME: Currently we remove the check, but we will not execute the main loop if
; %bound is negative (i.e. in [SINT_MAX + 1, UINT_MAX)). We should be able to
; safely remove this check (see comments in the method
; computeSafeIterationSpace).
define void @test_07(ptr %arr, i32 %n, i32 %bound) {
; CHECK-LABEL: @test_07(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[BOUND:%.*]], -2147483647
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[TMP0]], i32 0)
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[BOUND]], [[SMAX]]
; CHECK-NEXT:    [[SMIN:%.*]] = call i32 @llvm.smin.i32(i32 [[BOUND]], i32 0)
; CHECK-NEXT:    [[SMAX1:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN]], i32 -1)
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw i32 [[SMAX1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = mul i32 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[SMIN2:%.*]] = call i32 @llvm.smin.i32(i32 [[N]], i32 [[TMP3]])
; CHECK-NEXT:    [[EXIT_MAINLOOP_AT:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN2]], i32 0)
; CHECK-NEXT:    [[TMP4:%.*]] = icmp slt i32 0, [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP4]], label [[LOOP_PREHEADER4:%.*]], label [[MAIN_PSEUDO_EXIT:%.*]]
; CHECK:       loop.preheader4:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER4]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add nsw i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp ult i32 [[IDX]], [[BOUND]]
; CHECK-NEXT:    br i1 true, label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS_LOOPEXIT5:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp slt i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp slt i32 [[IDX_NEXT]], [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[LOOP]], label [[MAIN_EXIT_SELECTOR:%.*]]
; CHECK:       main.exit.selector:
; CHECK-NEXT:    [[IDX_NEXT_LCSSA:%.*]] = phi i32 [ [[IDX_NEXT]], [[IN_BOUNDS]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = icmp slt i32 [[IDX_NEXT_LCSSA]], [[N]]
; CHECK-NEXT:    br i1 [[TMP6]], label [[MAIN_PSEUDO_EXIT]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       main.pseudo.exit:
; CHECK-NEXT:    [[IDX_COPY:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    [[INDVAR_END:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    br label [[POSTLOOP:%.*]]
; CHECK:       out.of.bounds.loopexit:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS:%.*]]
; CHECK:       out.of.bounds.loopexit5:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit.loopexit:
; CHECK-NEXT:    br label [[EXIT_LOOPEXIT]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       postloop:
; CHECK-NEXT:    br label [[LOOP_POSTLOOP:%.*]]
; CHECK:       loop.postloop:
; CHECK-NEXT:    [[IDX_POSTLOOP:%.*]] = phi i32 [ [[IDX_NEXT_POSTLOOP:%.*]], [[IN_BOUNDS_POSTLOOP:%.*]] ], [ [[IDX_COPY]], [[POSTLOOP]] ]
; CHECK-NEXT:    [[IDX_NEXT_POSTLOOP]] = add i32 [[IDX_POSTLOOP]], 1
; CHECK-NEXT:    [[ABC_POSTLOOP:%.*]] = icmp ult i32 [[IDX_POSTLOOP]], [[BOUND]]
; CHECK-NEXT:    br i1 [[ABC_POSTLOOP]], label [[IN_BOUNDS_POSTLOOP]], label [[OUT_OF_BOUNDS_LOOPEXIT:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds.postloop:
; CHECK-NEXT:    [[ADDR_POSTLOOP:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX_POSTLOOP]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR_POSTLOOP]], align 4
; CHECK-NEXT:    [[NEXT_POSTLOOP:%.*]] = icmp slt i32 [[IDX_NEXT_POSTLOOP]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT_POSTLOOP]], label [[LOOP_POSTLOOP]], label [[EXIT_LOOPEXIT_LOOPEXIT:%.*]], !llvm.loop [[LOOP8:![0-9]+]], !loop_constrainer.loop.clone [[META6]]
;
  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp ult i32 %idx, %bound
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp slt i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

; Same as test_04, unsigned range check.
; FIXME: Currently we remove the check, but we will not execute the main loop if
; %bound is negative (i.e. in [SINT_MAX + 1, UINT_MAX)). We should be able to
; safely remove this check (see comments in the method
; computeSafeIterationSpace).
define void @test_08(ptr %arr, i32 %n, i32 %bound) {
; CHECK-LABEL: @test_08(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FIRST_ITR_CHECK:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[FIRST_ITR_CHECK]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[SMIN:%.*]] = call i32 @llvm.smin.i32(i32 [[BOUND:%.*]], i32 0)
; CHECK-NEXT:    [[TMP0:%.*]] = sub i32 [[BOUND]], [[SMIN]]
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN]], i32 -1)
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw i32 [[SMAX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = mul i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[EXIT_MAINLOOP_AT:%.*]] = call i32 @llvm.umin.i32(i32 [[N]], i32 [[TMP2]])
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i32 0, [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[LOOP_PREHEADER1:%.*]], label [[MAIN_PSEUDO_EXIT:%.*]]
; CHECK:       loop.preheader1:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER1]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[ABC:%.*]] = icmp ult i32 [[IDX]], [[BOUND]]
; CHECK-NEXT:    br i1 true, label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS_LOOPEXIT2:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp ult i32 [[IDX_NEXT]], [[N]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ult i32 [[IDX_NEXT]], [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP4]], label [[LOOP]], label [[MAIN_EXIT_SELECTOR:%.*]]
; CHECK:       main.exit.selector:
; CHECK-NEXT:    [[IDX_NEXT_LCSSA:%.*]] = phi i32 [ [[IDX_NEXT]], [[IN_BOUNDS]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ult i32 [[IDX_NEXT_LCSSA]], [[N]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[MAIN_PSEUDO_EXIT]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       main.pseudo.exit:
; CHECK-NEXT:    [[IDX_COPY:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    [[INDVAR_END:%.*]] = phi i32 [ 0, [[LOOP_PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    br label [[POSTLOOP:%.*]]
; CHECK:       out.of.bounds.loopexit:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS:%.*]]
; CHECK:       out.of.bounds.loopexit2:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit.loopexit:
; CHECK-NEXT:    br label [[EXIT_LOOPEXIT]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       postloop:
; CHECK-NEXT:    br label [[LOOP_POSTLOOP:%.*]]
; CHECK:       loop.postloop:
; CHECK-NEXT:    [[IDX_POSTLOOP:%.*]] = phi i32 [ [[IDX_NEXT_POSTLOOP:%.*]], [[IN_BOUNDS_POSTLOOP:%.*]] ], [ [[IDX_COPY]], [[POSTLOOP]] ]
; CHECK-NEXT:    [[IDX_NEXT_POSTLOOP]] = add i32 [[IDX_POSTLOOP]], 1
; CHECK-NEXT:    [[ABC_POSTLOOP:%.*]] = icmp ult i32 [[IDX_POSTLOOP]], [[BOUND]]
; CHECK-NEXT:    br i1 [[ABC_POSTLOOP]], label [[IN_BOUNDS_POSTLOOP]], label [[OUT_OF_BOUNDS_LOOPEXIT:%.*]], !prof [[PROF0]]
; CHECK:       in.bounds.postloop:
; CHECK-NEXT:    [[ADDR_POSTLOOP:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX_POSTLOOP]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR_POSTLOOP]], align 4
; CHECK-NEXT:    [[NEXT_POSTLOOP:%.*]] = icmp ult i32 [[IDX_NEXT_POSTLOOP]], [[N]]
; CHECK-NEXT:    br i1 [[NEXT_POSTLOOP]], label [[LOOP_POSTLOOP]], label [[EXIT_LOOPEXIT_LOOPEXIT:%.*]], !llvm.loop [[LOOP9:![0-9]+]], !loop_constrainer.loop.clone [[META6]]
;
  entry:
  %first.itr.check = icmp sgt i32 %n, 0
  br i1 %first.itr.check, label %loop, label %exit

  loop:
  %idx = phi i32 [ 0, %entry ] , [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %abc = icmp ult i32 %idx, %bound
  br i1 %abc, label %in.bounds, label %out.of.bounds, !prof !0

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp ult i32 %idx.next, %n
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}
!0 = !{!"branch_weights", i32 64, i32 4}
