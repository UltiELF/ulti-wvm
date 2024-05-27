; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes=loop-vectorize,instcombine,simplifycfg -simplifycfg-require-and-preserve-domtree=1 -mtriple=x86_64-unknown-linux-gnu -mattr=avx512vl,avx512dq,avx512bw -S | FileCheck %s

@bytes = global [128 x i8] zeroinitializer, align 16

; Make sure we end up with vector code for this loop. We used to try to create
; a VF=64,UF=4 loop, but the scalar trip count is only 128 so
; the vector loop was dead code leaving only a scalar remainder.
define zeroext i8 @sum() {
; CHECK-LABEL: @sum(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <64 x i8>, ptr getelementptr inbounds ([128 x i8], ptr @bytes, i64 0, i64 64), align 1
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <64 x i8>, ptr @bytes, align 1
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <64 x i8> [[WIDE_LOAD2]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP0:%.*]] = call i8 @llvm.vector.reduce.add.v64i8(<64 x i8> [[BIN_RDX]])
; CHECK-NEXT:    ret i8 [[TMP0]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %r.010 = phi i8 [ 0, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds [128 x i8], ptr @bytes, i64 0, i64 %indvars.iv
  %0 = load i8, ptr %arrayidx, align 1
  %add = add i8 %0, %r.010
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  %add.lcssa = phi i8 [ %add, %for.body ]
  ret i8 %add.lcssa
}
