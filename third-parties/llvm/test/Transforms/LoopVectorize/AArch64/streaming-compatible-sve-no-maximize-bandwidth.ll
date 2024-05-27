; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize -force-streaming-compatible-sve -enable-fixedwidth-autovec-in-streaming-mode -mattr=+sve -force-target-instruction-cost=1 -scalable-vectorization=off -force-vector-interleave=1 -S 2>&1 | FileCheck %s --check-prefix=SC_SVE
; RUN: opt < %s -passes=loop-vectorize -mattr=+sve -force-target-instruction-cost=1 -scalable-vectorization=off -force-vector-interleave=1 -S 2>&1 | FileCheck %s --check-prefix=NO_SC_SVE

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

@a =  global [32 x i16] zeroinitializer, align 2
@b =  global [32 x i16] zeroinitializer, align 2
@c =  global [32 x i16] zeroinitializer, align 2

define i32 @foo(i32 noundef %n, i32 noundef %lag, i32 noundef %shift) vscale_range(1,16) {
; SC_SVE-LABEL: @foo(
; SC_SVE-NEXT:  entry:
; SC_SVE-NEXT:    [[TMP0:%.*]] = sext i32 [[LAG:%.*]] to i64
; SC_SVE-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N:%.*]] to i64
; SC_SVE-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[WIDE_TRIP_COUNT]], 4
; SC_SVE-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; SC_SVE:       vector.ph:
; SC_SVE-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[WIDE_TRIP_COUNT]], 4
; SC_SVE-NEXT:    [[N_VEC:%.*]] = sub i64 [[WIDE_TRIP_COUNT]], [[N_MOD_VF]]
; SC_SVE-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[SHIFT:%.*]], i64 0
; SC_SVE-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
; SC_SVE-NEXT:    br label [[VECTOR_BODY:%.*]]
; SC_SVE:       vector.body:
; SC_SVE-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; SC_SVE-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP17:%.*]], [[VECTOR_BODY]] ]
; SC_SVE-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; SC_SVE-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 0
; SC_SVE-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [32 x i16], ptr @a, i64 0, i64 [[TMP1]]
; SC_SVE-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i16, ptr [[TMP2]], i32 0
; SC_SVE-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i16>, ptr [[TMP3]], align 2
; SC_SVE-NEXT:    [[TMP4:%.*]] = sext <4 x i16> [[WIDE_LOAD]] to <4 x i32>
; SC_SVE-NEXT:    [[TMP5:%.*]] = ashr <4 x i32> [[TMP4]], [[VEC_IND]]
; SC_SVE-NEXT:    [[TMP6:%.*]] = add nsw i64 [[TMP1]], [[TMP0]]
; SC_SVE-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [32 x i16], ptr @b, i64 0, i64 [[TMP6]]
; SC_SVE-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i16, ptr [[TMP7]], i32 0
; SC_SVE-NEXT:    [[WIDE_LOAD1:%.*]] = load <4 x i16>, ptr [[TMP8]], align 2
; SC_SVE-NEXT:    [[TMP9:%.*]] = sext <4 x i16> [[WIDE_LOAD1]] to <4 x i32>
; SC_SVE-NEXT:    [[TMP10:%.*]] = shl <4 x i32> [[TMP9]], [[VEC_IND]]
; SC_SVE-NEXT:    [[TMP11:%.*]] = mul nsw <4 x i32> [[TMP10]], [[TMP5]]
; SC_SVE-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [32 x i16], ptr @c, i64 0, i64 [[TMP1]]
; SC_SVE-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i16, ptr [[TMP12]], i32 0
; SC_SVE-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x i16>, ptr [[TMP13]], align 2
; SC_SVE-NEXT:    [[TMP14:%.*]] = sext <4 x i16> [[WIDE_LOAD2]] to <4 x i32>
; SC_SVE-NEXT:    [[TMP15:%.*]] = add nsw <4 x i32> [[TMP11]], [[TMP14]]
; SC_SVE-NEXT:    [[TMP16:%.*]] = shl <4 x i32> [[TMP15]], [[BROADCAST_SPLAT]]
; SC_SVE-NEXT:    [[TMP17]] = add <4 x i32> [[TMP16]], [[VEC_PHI]]
; SC_SVE-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; SC_SVE-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; SC_SVE-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; SC_SVE-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; SC_SVE:       middle.block:
; SC_SVE-NEXT:    [[TMP19:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP17]])
; SC_SVE-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[WIDE_TRIP_COUNT]], [[N_VEC]]
; SC_SVE-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[SCALAR_PH]]
; SC_SVE:       scalar.ph:
; SC_SVE-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; SC_SVE-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP19]], [[MIDDLE_BLOCK]] ]
; SC_SVE-NEXT:    br label [[FOR_BODY:%.*]]
; SC_SVE:       for.body:
; SC_SVE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; SC_SVE-NEXT:    [[RET_018:%.*]] = phi i32 [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[ADD9:%.*]], [[FOR_BODY]] ]
; SC_SVE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32 x i16], ptr @a, i64 0, i64 [[INDVARS_IV]]
; SC_SVE-NEXT:    [[TMP20:%.*]] = load i16, ptr [[ARRAYIDX]], align 2
; SC_SVE-NEXT:    [[CONV:%.*]] = sext i16 [[TMP20]] to i32
; SC_SVE-NEXT:    [[TMP21:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; SC_SVE-NEXT:    [[SHR:%.*]] = ashr i32 [[CONV]], [[TMP21]]
; SC_SVE-NEXT:    [[TMP22:%.*]] = add nsw i64 [[INDVARS_IV]], [[TMP0]]
; SC_SVE-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [32 x i16], ptr @b, i64 0, i64 [[TMP22]]
; SC_SVE-NEXT:    [[TMP23:%.*]] = load i16, ptr [[ARRAYIDX2]], align 2
; SC_SVE-NEXT:    [[CONV3:%.*]] = sext i16 [[TMP23]] to i32
; SC_SVE-NEXT:    [[SHL:%.*]] = shl i32 [[CONV3]], [[TMP21]]
; SC_SVE-NEXT:    [[MUL:%.*]] = mul nsw i32 [[SHL]], [[SHR]]
; SC_SVE-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds [32 x i16], ptr @c, i64 0, i64 [[INDVARS_IV]]
; SC_SVE-NEXT:    [[TMP24:%.*]] = load i16, ptr [[ARRAYIDX5]], align 2
; SC_SVE-NEXT:    [[CONV6:%.*]] = sext i16 [[TMP24]] to i32
; SC_SVE-NEXT:    [[ADD7:%.*]] = add nsw i32 [[MUL]], [[CONV6]]
; SC_SVE-NEXT:    [[SHL8:%.*]] = shl i32 [[ADD7]], [[SHIFT]]
; SC_SVE-NEXT:    [[ADD9]] = add nsw i32 [[SHL8]], [[RET_018]]
; SC_SVE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; SC_SVE-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; SC_SVE-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; SC_SVE:       for.end:
; SC_SVE-NEXT:    [[RET_0_LCSSA:%.*]] = phi i32 [ [[ADD9]], [[FOR_BODY]] ], [ [[TMP19]], [[MIDDLE_BLOCK]] ]
; SC_SVE-NEXT:    ret i32 [[RET_0_LCSSA]]
;
; NO_SC_SVE-LABEL: @foo(
; NO_SC_SVE-NEXT:  entry:
; NO_SC_SVE-NEXT:    [[TMP0:%.*]] = sext i32 [[LAG:%.*]] to i64
; NO_SC_SVE-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N:%.*]] to i64
; NO_SC_SVE-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[WIDE_TRIP_COUNT]], 8
; NO_SC_SVE-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; NO_SC_SVE:       vector.ph:
; NO_SC_SVE-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[WIDE_TRIP_COUNT]], 8
; NO_SC_SVE-NEXT:    [[N_VEC:%.*]] = sub i64 [[WIDE_TRIP_COUNT]], [[N_MOD_VF]]
; NO_SC_SVE-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <8 x i32> poison, i32 [[SHIFT:%.*]], i64 0
; NO_SC_SVE-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <8 x i32> [[BROADCAST_SPLATINSERT]], <8 x i32> poison, <8 x i32> zeroinitializer
; NO_SC_SVE-NEXT:    br label [[VECTOR_BODY:%.*]]
; NO_SC_SVE:       vector.body:
; NO_SC_SVE-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; NO_SC_SVE-NEXT:    [[VEC_PHI:%.*]] = phi <8 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP17:%.*]], [[VECTOR_BODY]] ]
; NO_SC_SVE-NEXT:    [[VEC_IND:%.*]] = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; NO_SC_SVE-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 0
; NO_SC_SVE-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [32 x i16], ptr @a, i64 0, i64 [[TMP1]]
; NO_SC_SVE-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i16, ptr [[TMP2]], i32 0
; NO_SC_SVE-NEXT:    [[WIDE_LOAD:%.*]] = load <8 x i16>, ptr [[TMP3]], align 2
; NO_SC_SVE-NEXT:    [[TMP4:%.*]] = sext <8 x i16> [[WIDE_LOAD]] to <8 x i32>
; NO_SC_SVE-NEXT:    [[TMP5:%.*]] = ashr <8 x i32> [[TMP4]], [[VEC_IND]]
; NO_SC_SVE-NEXT:    [[TMP6:%.*]] = add nsw i64 [[TMP1]], [[TMP0]]
; NO_SC_SVE-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [32 x i16], ptr @b, i64 0, i64 [[TMP6]]
; NO_SC_SVE-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i16, ptr [[TMP7]], i32 0
; NO_SC_SVE-NEXT:    [[WIDE_LOAD1:%.*]] = load <8 x i16>, ptr [[TMP8]], align 2
; NO_SC_SVE-NEXT:    [[TMP9:%.*]] = sext <8 x i16> [[WIDE_LOAD1]] to <8 x i32>
; NO_SC_SVE-NEXT:    [[TMP10:%.*]] = shl <8 x i32> [[TMP9]], [[VEC_IND]]
; NO_SC_SVE-NEXT:    [[TMP11:%.*]] = mul nsw <8 x i32> [[TMP10]], [[TMP5]]
; NO_SC_SVE-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [32 x i16], ptr @c, i64 0, i64 [[TMP1]]
; NO_SC_SVE-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i16, ptr [[TMP12]], i32 0
; NO_SC_SVE-NEXT:    [[WIDE_LOAD2:%.*]] = load <8 x i16>, ptr [[TMP13]], align 2
; NO_SC_SVE-NEXT:    [[TMP14:%.*]] = sext <8 x i16> [[WIDE_LOAD2]] to <8 x i32>
; NO_SC_SVE-NEXT:    [[TMP15:%.*]] = add nsw <8 x i32> [[TMP11]], [[TMP14]]
; NO_SC_SVE-NEXT:    [[TMP16:%.*]] = shl <8 x i32> [[TMP15]], [[BROADCAST_SPLAT]]
; NO_SC_SVE-NEXT:    [[TMP17]] = add <8 x i32> [[TMP16]], [[VEC_PHI]]
; NO_SC_SVE-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; NO_SC_SVE-NEXT:    [[VEC_IND_NEXT]] = add <8 x i32> [[VEC_IND]], <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
; NO_SC_SVE-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; NO_SC_SVE-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; NO_SC_SVE:       middle.block:
; NO_SC_SVE-NEXT:    [[TMP19:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP17]])
; NO_SC_SVE-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[WIDE_TRIP_COUNT]], [[N_VEC]]
; NO_SC_SVE-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[SCALAR_PH]]
; NO_SC_SVE:       scalar.ph:
; NO_SC_SVE-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; NO_SC_SVE-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP19]], [[MIDDLE_BLOCK]] ]
; NO_SC_SVE-NEXT:    br label [[FOR_BODY:%.*]]
; NO_SC_SVE:       for.body:
; NO_SC_SVE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; NO_SC_SVE-NEXT:    [[RET_018:%.*]] = phi i32 [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[ADD9:%.*]], [[FOR_BODY]] ]
; NO_SC_SVE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32 x i16], ptr @a, i64 0, i64 [[INDVARS_IV]]
; NO_SC_SVE-NEXT:    [[TMP20:%.*]] = load i16, ptr [[ARRAYIDX]], align 2
; NO_SC_SVE-NEXT:    [[CONV:%.*]] = sext i16 [[TMP20]] to i32
; NO_SC_SVE-NEXT:    [[TMP21:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; NO_SC_SVE-NEXT:    [[SHR:%.*]] = ashr i32 [[CONV]], [[TMP21]]
; NO_SC_SVE-NEXT:    [[TMP22:%.*]] = add nsw i64 [[INDVARS_IV]], [[TMP0]]
; NO_SC_SVE-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [32 x i16], ptr @b, i64 0, i64 [[TMP22]]
; NO_SC_SVE-NEXT:    [[TMP23:%.*]] = load i16, ptr [[ARRAYIDX2]], align 2
; NO_SC_SVE-NEXT:    [[CONV3:%.*]] = sext i16 [[TMP23]] to i32
; NO_SC_SVE-NEXT:    [[SHL:%.*]] = shl i32 [[CONV3]], [[TMP21]]
; NO_SC_SVE-NEXT:    [[MUL:%.*]] = mul nsw i32 [[SHL]], [[SHR]]
; NO_SC_SVE-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds [32 x i16], ptr @c, i64 0, i64 [[INDVARS_IV]]
; NO_SC_SVE-NEXT:    [[TMP24:%.*]] = load i16, ptr [[ARRAYIDX5]], align 2
; NO_SC_SVE-NEXT:    [[CONV6:%.*]] = sext i16 [[TMP24]] to i32
; NO_SC_SVE-NEXT:    [[ADD7:%.*]] = add nsw i32 [[MUL]], [[CONV6]]
; NO_SC_SVE-NEXT:    [[SHL8:%.*]] = shl i32 [[ADD7]], [[SHIFT]]
; NO_SC_SVE-NEXT:    [[ADD9]] = add nsw i32 [[SHL8]], [[RET_018]]
; NO_SC_SVE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; NO_SC_SVE-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; NO_SC_SVE-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; NO_SC_SVE:       for.end:
; NO_SC_SVE-NEXT:    [[RET_0_LCSSA:%.*]] = phi i32 [ [[ADD9]], [[FOR_BODY]] ], [ [[TMP19]], [[MIDDLE_BLOCK]] ]
; NO_SC_SVE-NEXT:    ret i32 [[RET_0_LCSSA]]
;
entry:
  %0 = sext i32 %lag to i64
  %wide.trip.count = zext i32 %n to i64
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %ret.018 = phi i32 [ 0, %entry ], [ %add9, %for.body ]
  %arrayidx = getelementptr inbounds [32 x i16], ptr @a, i64 0, i64 %indvars.iv
  %1 = load i16, ptr %arrayidx, align 2
  %conv = sext i16 %1 to i32
  %2 = trunc i64 %indvars.iv to i32
  %shr = ashr i32 %conv, %2
  %3 = add nsw i64 %indvars.iv, %0
  %arrayidx2 = getelementptr inbounds [32 x i16], ptr @b, i64 0, i64 %3
  %4 = load i16, ptr %arrayidx2, align 2
  %conv3 = sext i16 %4 to i32
  %shl = shl i32 %conv3, %2
  %mul = mul nsw i32 %shl, %shr
  %arrayidx5 = getelementptr inbounds [32 x i16], ptr @c, i64 0, i64 %indvars.iv
  %5 = load i16, ptr %arrayidx5, align 2
  %conv6 = sext i16 %5 to i32
  %add7 = add nsw i32 %mul, %conv6
  %shl8 = shl i32 %add7, %shift
  %add9 = add nsw i32 %shl8, %ret.018
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  %ret.0.lcssa = phi i32 [ %add9, %for.body ]
  ret i32 %ret.0.lcssa
}
