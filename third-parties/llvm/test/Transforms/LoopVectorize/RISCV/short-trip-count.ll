; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=riscv64 -mattr=+zve32x -passes=loop-vectorize < %s | FileCheck %s

define void @small_trip_count_min_vlen_128(ptr nocapture %a) nounwind vscale_range(4,1024) {
; CHECK-LABEL: @small_trip_count_min_vlen_128(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i32 [[TMP0]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i32 [[TMP2]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = sub i32 [[TMP3]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i32 4, [[TMP4]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N_RND_UP]], [[TMP1]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP9:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP10:%.*]] = mul i32 [[TMP9]], 4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32 [[TMP5]], i32 4)
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 0
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP7]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <vscale x 4 x i32> [[WIDE_MASKED_LOAD]], shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i64 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[TMP8]], ptr [[TMP7]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], [[TMP10]]
; CHECK-NEXT:    br i1 true, label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_NEXT:%.*]], [[LOOP]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[IV]]
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[GEP]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[V]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV]], 3
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %a, i32 %iv
  %v = load i32, ptr %gep, align 4
  %add = add nsw i32 %v, 1
  store i32 %add, ptr %gep, align 4
  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv, 3
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

define void @small_trip_count_min_vlen_32(ptr nocapture %a) nounwind vscale_range(1,1024) {
; CHECK-LABEL: @small_trip_count_min_vlen_32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i32 [[TMP0]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i32 [[TMP2]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = sub i32 [[TMP3]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i32 4, [[TMP4]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N_RND_UP]], [[TMP1]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP9:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP10:%.*]] = mul i32 [[TMP9]], 4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32 [[TMP5]], i32 4)
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 0
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP7]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <vscale x 4 x i32> [[WIDE_MASKED_LOAD]], shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i64 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[TMP8]], ptr [[TMP7]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], [[TMP10]]
; CHECK-NEXT:    br i1 true, label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_NEXT:%.*]], [[LOOP]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[IV]]
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[GEP]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[V]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV]], 3
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %a, i32 %iv
  %v = load i32, ptr %gep, align 4
  %add = add nsw i32 %v, 1
  store i32 %add, ptr %gep, align 4
  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv, 3
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}
