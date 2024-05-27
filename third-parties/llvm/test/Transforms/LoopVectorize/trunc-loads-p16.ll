; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p loop-vectorize -force-vector-width=4 -force-vector-interleave=1 -S %s | FileCheck %s

target datalayout = "p:16:16"

define void @pr77468(ptr noalias %src, ptr noalias %dst, i1 %x) {
; CHECK-LABEL: define void @pr77468(
; CHECK-SAME: ptr noalias [[SRC:%.*]], ptr noalias [[DST:%.*]], i1 [[X:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i1> poison, i1 [[X]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i1> [[BROADCAST_SPLATINSERT]], <4 x i1> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = trunc i32 [[INDEX]] to i16
; CHECK-NEXT:    [[TMP0:%.*]] = add i16 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[SRC]], i16 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP2]], align 1
; CHECK-NEXT:    [[TMP3:%.*]] = zext <4 x i1> [[BROADCAST_SPLAT]] to <4 x i16>
; CHECK-NEXT:    [[TMP4:%.*]] = trunc <4 x i32> [[WIDE_LOAD]] to <4 x i16>
; CHECK-NEXT:    [[TMP5:%.*]] = and <4 x i16> [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr i16, ptr [[DST]], i16 [[TMP0]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i16, ptr [[TMP6]], i32 0
; CHECK-NEXT:    store <4 x i16> [[TMP5]], ptr [[TMP7]], align 2
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], 100
; CHECK-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i16 [ 100, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP_SRC:%.*]] = getelementptr i32, ptr [[SRC]], i16 [[IV]]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[GEP_SRC]], align 1
; CHECK-NEXT:    [[X_EXT:%.*]] = zext i1 [[X]] to i32
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X_EXT]], [[L]]
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr i16, ptr [[DST]], i16 [[IV]]
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[AND]] to i16
; CHECK-NEXT:    store i16 [[T]], ptr [[GEP_DST]], align 2
; CHECK-NEXT:    [[IV_NEXT]] = add i16 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i16 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i16 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr i32, ptr %src, i16 %iv
  %l = load i32, ptr %gep.src, align 1
  %x.ext = zext i1 %x to i32
  %and = and i32 %x.ext, %l
  %gep.dst = getelementptr i16, ptr %dst, i16 %iv
  %t = trunc i32 %and to i16
  store i16 %t, ptr %gep.dst
  %iv.next = add i16 %iv , 1
  %exitcond.not = icmp eq i16 %iv.next, 100
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.
