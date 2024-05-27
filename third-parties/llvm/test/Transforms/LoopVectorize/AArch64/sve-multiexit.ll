; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize < %s -S -o - | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

; Test cases to make sure LV & loop versioning can handle loops with
; multiple exiting branches.

; Multiple branches exiting the loop to a unique exit block.
define void @multiple_exits_unique_exit_block(ptr %A, ptr %B, i32 %N) #0 {
; CHECK-LABEL: @multiple_exits_unique_exit_block(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A2:%.*]] = ptrtoint ptr [[A:%.*]] to i64
; CHECK-NEXT:    [[B1:%.*]] = ptrtoint ptr [[B:%.*]] to i64
; CHECK-NEXT:    [[UMIN:%.*]] = call i32 @llvm.umin.i32(i32 [[N:%.*]], i32 999)
; CHECK-NEXT:    [[TMP0:%.*]] = add nuw nsw i32 [[UMIN]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP2:%.*]] = mul i32 [[TMP1]], 8
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i32 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP3]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 8
; CHECK-NEXT:    [[TMP6:%.*]] = sub i64 [[B1]], [[A2]]
; CHECK-NEXT:    [[DIFF_CHECK:%.*]] = icmp ult i64 [[TMP6]], [[TMP5]]
; CHECK-NEXT:    br i1 [[DIFF_CHECK]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP7:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP8:%.*]] = mul i32 [[TMP7]], 8
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[TMP0]], [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP10:%.*]] = select i1 [[TMP9]], i32 [[TMP8]], i32 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[TMP0]], [[TMP10]]
; CHECK-NEXT:    [[TMP11:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP12:%.*]] = mul i32 [[TMP11]], 8
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP13:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP14:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP15:%.*]] = mul i32 [[TMP14]], 4
; CHECK-NEXT:    [[TMP16:%.*]] = add i32 [[TMP15]], 0
; CHECK-NEXT:    [[TMP17:%.*]] = mul i32 [[TMP16]], 1
; CHECK-NEXT:    [[TMP18:%.*]] = add i32 [[INDEX]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP18]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i32, ptr [[TMP19]], i32 0
; CHECK-NEXT:    [[TMP22:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP23:%.*]] = mul i64 [[TMP22]], 4
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i32, ptr [[TMP19]], i64 [[TMP23]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x i32>, ptr [[TMP21]], align 4
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <vscale x 4 x i32>, ptr [[TMP24]], align 4
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP18]]
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds i32, ptr [[TMP25]], i32 0
; CHECK-NEXT:    [[TMP28:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP29:%.*]] = mul i64 [[TMP28]], 4
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr inbounds i32, ptr [[TMP25]], i64 [[TMP29]]
; CHECK-NEXT:    store <vscale x 4 x i32> [[WIDE_LOAD]], ptr [[TMP27]], align 4
; CHECK-NEXT:    store <vscale x 4 x i32> [[WIDE_LOAD3]], ptr [[TMP30]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], [[TMP12]]
; CHECK-NEXT:    [[TMP31:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP31]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY:%.*]] ]
; CHECK-NEXT:    [[COND_0:%.*]] = icmp eq i32 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[COND_0]], label [[EXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_GEP:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[IV]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[A_GEP]], align 4
; CHECK-NEXT:    [[B_GEP:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[LV]], ptr [[B_GEP]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw i32 [[IV]], 1
; CHECK-NEXT:    [[COND_1:%.*]] = icmp ult i32 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[COND_1]], label [[LOOP_HEADER]], label [[EXIT]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %for.body ]
  %cond.0 = icmp eq i32 %iv, %N
  br i1 %cond.0, label %exit, label %for.body

for.body:
  %A.gep = getelementptr inbounds i32, ptr %A, i32 %iv
  %lv = load i32, ptr %A.gep, align 4
  %B.gep = getelementptr inbounds i32, ptr %B, i32 %iv
  store i32 %lv, ptr %B.gep, align 4
  %iv.next = add nuw i32 %iv, 1
  %cond.1 = icmp ult i32 %iv.next, 1000
  br i1 %cond.1, label %loop.header, label %exit

exit:
  ret void
}


; Multiple branches exiting the loop to different blocks.
define i32 @multiple_exits_multiple_exit_blocks(ptr %A, ptr %B, i32 %N) #0 {
; CHECK-LABEL: @multiple_exits_multiple_exit_blocks(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A2:%.*]] = ptrtoint ptr [[A:%.*]] to i64
; CHECK-NEXT:    [[B1:%.*]] = ptrtoint ptr [[B:%.*]] to i64
; CHECK-NEXT:    [[UMIN:%.*]] = call i32 @llvm.umin.i32(i32 [[N:%.*]], i32 999)
; CHECK-NEXT:    [[TMP0:%.*]] = add nuw nsw i32 [[UMIN]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP2:%.*]] = mul i32 [[TMP1]], 8
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i32 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP3]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 8
; CHECK-NEXT:    [[TMP6:%.*]] = sub i64 [[B1]], [[A2]]
; CHECK-NEXT:    [[DIFF_CHECK:%.*]] = icmp ult i64 [[TMP6]], [[TMP5]]
; CHECK-NEXT:    br i1 [[DIFF_CHECK]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP7:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP8:%.*]] = mul i32 [[TMP7]], 8
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[TMP0]], [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP10:%.*]] = select i1 [[TMP9]], i32 [[TMP8]], i32 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[TMP0]], [[TMP10]]
; CHECK-NEXT:    [[TMP11:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP12:%.*]] = mul i32 [[TMP11]], 8
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP13:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP14:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP15:%.*]] = mul i32 [[TMP14]], 4
; CHECK-NEXT:    [[TMP16:%.*]] = add i32 [[TMP15]], 0
; CHECK-NEXT:    [[TMP17:%.*]] = mul i32 [[TMP16]], 1
; CHECK-NEXT:    [[TMP18:%.*]] = add i32 [[INDEX]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP18]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i32, ptr [[TMP19]], i32 0
; CHECK-NEXT:    [[TMP22:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP23:%.*]] = mul i64 [[TMP22]], 4
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i32, ptr [[TMP19]], i64 [[TMP23]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x i32>, ptr [[TMP21]], align 4
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <vscale x 4 x i32>, ptr [[TMP24]], align 4
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP18]]
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds i32, ptr [[TMP25]], i32 0
; CHECK-NEXT:    [[TMP28:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP29:%.*]] = mul i64 [[TMP28]], 4
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr inbounds i32, ptr [[TMP25]], i64 [[TMP29]]
; CHECK-NEXT:    store <vscale x 4 x i32> [[WIDE_LOAD]], ptr [[TMP27]], align 4
; CHECK-NEXT:    store <vscale x 4 x i32> [[WIDE_LOAD3]], ptr [[TMP30]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], [[TMP12]]
; CHECK-NEXT:    [[TMP31:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP31]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY:%.*]] ]
; CHECK-NEXT:    [[COND_0:%.*]] = icmp eq i32 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[COND_0]], label [[EXIT_0:%.*]], label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_GEP:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[IV]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[A_GEP]], align 4
; CHECK-NEXT:    [[B_GEP:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[LV]], ptr [[B_GEP]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw i32 [[IV]], 1
; CHECK-NEXT:    [[COND_1:%.*]] = icmp ult i32 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[COND_1]], label [[LOOP_HEADER]], label [[EXIT_1:%.*]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit.0:
; CHECK-NEXT:    ret i32 1
; CHECK:       exit.1:
; CHECK-NEXT:    ret i32 2
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %for.body ]
  %cond.0 = icmp eq i32 %iv, %N
  br i1 %cond.0, label %exit.0, label %for.body

for.body:
  %A.gep = getelementptr inbounds i32, ptr %A, i32 %iv
  %lv = load i32, ptr %A.gep, align 4
  %B.gep = getelementptr inbounds i32, ptr %B, i32 %iv
  store i32 %lv, ptr %B.gep, align 4
  %iv.next = add nuw i32 %iv, 1
  %cond.1 = icmp ult i32 %iv.next, 1000
  br i1 %cond.1, label %loop.header, label %exit.1

exit.0:
  ret i32 1

exit.1:
  ret i32 2
}

attributes #0 = { "target-features"="+sve2" }
