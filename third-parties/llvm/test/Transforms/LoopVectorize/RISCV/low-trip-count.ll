; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -riscv-v-vector-bits-min=128 -scalable-vectorization=on -force-target-instruction-cost=1 -S < %s | FileCheck %s

target triple = "riscv64"

define void @trip5_i8(ptr noalias nocapture noundef %dst, ptr noalias nocapture noundef readonly %src) #0 {
; CHECK-LABEL: @trip5_i8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 16
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 16
; CHECK-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP3]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 5, [[TMP4]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 16
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP7:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 [[TMP7]], i64 5)
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[TMP8]], i32 0
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr [[TMP9]], i32 1, <vscale x 16 x i1> [[ACTIVE_LANE_MASK]], <vscale x 16 x i8> poison)
; CHECK-NEXT:    [[TMP10:%.*]] = shl <vscale x 16 x i8> [[WIDE_MASKED_LOAD]], shufflevector (<vscale x 16 x i8> insertelement (<vscale x 16 x i8> poison, i8 1, i64 0), <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i8, ptr [[DST:%.*]], i64 [[TMP7]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i32 0
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr [[TMP12]], i32 1, <vscale x 16 x i1> [[ACTIVE_LANE_MASK]], <vscale x 16 x i8> poison)
; CHECK-NEXT:    [[TMP13:%.*]] = add <vscale x 16 x i8> [[TMP10]], [[WIDE_MASKED_LOAD1]]
; CHECK-NEXT:    call void @llvm.masked.store.nxv16i8.p0(<vscale x 16 x i8> [[TMP13]], ptr [[TMP12]], i32 1, <vscale x 16 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP6]]
; CHECK-NEXT:    br i1 true, label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_08:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[I_08]]
; CHECK-NEXT:    [[TMP14:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[MUL:%.*]] = shl i8 [[TMP14]], 1
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[I_08]]
; CHECK-NEXT:    [[TMP15:%.*]] = load i8, ptr [[ARRAYIDX1]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[MUL]], [[TMP15]]
; CHECK-NEXT:    store i8 [[ADD]], ptr [[ARRAYIDX1]], align 1
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_08]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC]], 5
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.08 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, ptr %src, i64 %i.08
  %0 = load i8, ptr %arrayidx, align 1
  %mul = shl i8 %0, 1
  %arrayidx1 = getelementptr inbounds i8, ptr %dst, i64 %i.08
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %mul, %1
  store i8 %add, ptr %arrayidx1, align 1
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, 5
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

attributes #0 = { "target-features"="+v,+d" }
