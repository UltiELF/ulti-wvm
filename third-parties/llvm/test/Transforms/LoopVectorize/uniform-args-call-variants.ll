; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=loop-vectorize,instcombine -force-vector-width=2 -force-vector-interleave=1 -S | FileCheck %s

; A call whose argument can remain a scalar for a vectorized function variant
; with a uniform argument because it's loop invariant
define void @test_uniform(ptr noalias %dst, ptr readonly %src, i64 %uniform , i64 %n) {
; CHECK-LABEL: define void @test_uniform
; CHECK-SAME: (ptr noalias [[DST:%.*]], ptr readonly [[SRC:%.*]], i64 [[UNIFORM:%.*]], i64 [[N:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], -2
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr double, ptr [[SRC]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x double>, ptr [[TMP0]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x double> @foo_uniform(<2 x double> [[WIDE_LOAD]], i64 [[UNIFORM]])
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds double, ptr [[DST]], i64 [[INDEX]]
; CHECK-NEXT:    store <2 x double> [[TMP1]], ptr [[TMP2]], align 8
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[N]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[GEPSRC:%.*]] = getelementptr double, ptr [[SRC]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[DATA:%.*]] = load double, ptr [[GEPSRC]], align 8
; CHECK-NEXT:    [[CALL:%.*]] = call double @foo(double [[DATA]], i64 [[UNIFORM]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[GEPDST:%.*]] = getelementptr inbounds double, ptr [[DST]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store double [[CALL]], ptr [[GEPDST]], align 8
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepsrc = getelementptr double, ptr %src, i64 %indvars.iv
  %data = load double, ptr %gepsrc, align 8
  %call = call double @foo(double %data, i64 %uniform) #0
  %gepdst = getelementptr inbounds double, ptr %dst, i64 %indvars.iv
  store double %call, ptr %gepdst
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; If the parameter is not uniform, then we can't use the vector variant and
; must fall back to scalarization.
define void @test_uniform_not_invariant(ptr noalias %dst, ptr readonly %src, i64 %n) {
; CHECK-LABEL: define void @test_uniform_not_invariant
; CHECK-SAME: (ptr noalias [[DST:%.*]], ptr readonly [[SRC:%.*]], i64 [[N:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], -2
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = or disjoint i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr double, ptr [[SRC]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x double>, ptr [[TMP1]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[WIDE_LOAD]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo(double [[TMP2]], i64 [[INDEX]]) #[[ATTR0]]
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[WIDE_LOAD]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = call double @foo(double [[TMP4]], i64 [[TMP0]]) #[[ATTR0]]
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <2 x double> poison, double [[TMP3]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <2 x double> [[TMP6]], double [[TMP5]], i64 1
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds double, ptr [[DST]], i64 [[INDEX]]
; CHECK-NEXT:    store <2 x double> [[TMP7]], ptr [[TMP8]], align 8
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP9]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[N]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[GEPSRC:%.*]] = getelementptr double, ptr [[SRC]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[DATA:%.*]] = load double, ptr [[GEPSRC]], align 8
; CHECK-NEXT:    [[CALL:%.*]] = call double @foo(double [[DATA]], i64 [[INDVARS_IV]]) #[[ATTR0]]
; CHECK-NEXT:    [[GEPDST:%.*]] = getelementptr inbounds double, ptr [[DST]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store double [[CALL]], ptr [[GEPDST]], align 8
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gepsrc = getelementptr double, ptr %src, i64 %indvars.iv
  %data = load double, ptr %gepsrc, align 8
  %call = call double @foo(double %data, i64 %indvars.iv) #0
  %gepdst = getelementptr inbounds double, ptr %dst, i64 %indvars.iv
  store double %call, ptr %gepdst
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; Scalar functions
declare double @foo(double, i64)

; Vector variants
declare <2 x double> @foo_uniform(<2 x double>, i64)

; Mappings
attributes #0 = { nounwind "vector-function-abi-variant"="_ZGV_LLVM_N2vu_foo(foo_uniform)" }
