; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes='print<access-info>' -disable-output %s 2>&1 | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

; Test case for https://github.com/llvm/llvm-project/issues/82665.
define void @indirect_ptr_recurrences_read_write(ptr %A, ptr %B) {
; CHECK-LABEL: 'indirect_ptr_recurrences_read_write'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Unsafe indirect dependence.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        IndidrectUnsafe:
; CHECK-NEXT:            %l = load i32, ptr %ptr.recur, align 4, !tbaa !4 ->
; CHECK-NEXT:            store i32 %xor, ptr %ptr.recur, align 4, !tbaa !4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr.recur = phi ptr [ %A, %entry ], [ %ptr.next, %loop ]
  %gep.B = getelementptr inbounds ptr, ptr %B, i64 %iv
  %ptr.next = load ptr, ptr %gep.B, align 8, !tbaa !6
  %l = load i32, ptr %ptr.recur, align 4, !tbaa !10
  %xor = xor i32 %l, 1
  store i32 %xor, ptr %ptr.recur, align 4, !tbaa !10
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 5
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define i32 @indirect_ptr_recurrences_read_only_loop(ptr %A, ptr %B) {
; CHECK-LABEL: 'indirect_ptr_recurrences_read_only_loop'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Memory dependences are safe
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr.recur = phi ptr [ %A, %entry ], [ %ptr.next, %loop ]
  %red = phi i32 [ 0, %entry ], [ %xor, %loop ]
  %gep.B = getelementptr inbounds ptr, ptr %B, i64 %iv
  %ptr.next = load ptr, ptr %gep.B, align 8, !tbaa !6
  %l = load i32, ptr %ptr.recur, align 4, !tbaa !10
  %xor = xor i32 %l, 1
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 5
  br i1 %ec, label %exit, label %loop

exit:
  ret i32 %xor
}

define void @indirect_ptr_recurrences_read_write_may_alias_no_tbaa(ptr %A, ptr %B) {
; CHECK-LABEL: 'indirect_ptr_recurrences_read_write_may_alias_no_tbaa'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: cannot identify array bounds
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr.recur = phi ptr [ %A, %entry ], [ %ptr.next, %loop ]
  %gep.B = getelementptr inbounds ptr, ptr %B, i64 %iv
  %ptr.next = load ptr, ptr %gep.B, align 8, !tbaa !6
  %l = load i32, ptr %ptr.recur, align 4
  %xor = xor i32 %l, 1
  store i32 %xor, ptr %ptr.recur, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 5
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @indirect_ptr_recurrences_read_write_may_alias_different_obj(ptr %A, ptr %B, ptr %C) {
; CHECK-LABEL: 'indirect_ptr_recurrences_read_write_may_alias_different_obj'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: cannot identify array bounds
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr.recur = phi ptr [ %A, %entry ], [ %ptr.next, %loop ]
  %gep.B = getelementptr inbounds ptr, ptr %B, i64 %iv
  %ptr.next = load ptr, ptr %gep.B, align 8, !tbaa !6
  %l = load i32, ptr %ptr.recur, align 4
  %xor = xor i32 %l, 1
  %gep.C = getelementptr inbounds ptr, ptr %C, i64 %iv
  store i32 %xor, ptr %gep.C, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 5
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @indirect_ptr_recurrences_read_write_may_noalias_different_obj(ptr %A, ptr %B, ptr noalias %C) {
; CHECK-LABEL: 'indirect_ptr_recurrences_read_write_may_noalias_different_obj'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Memory dependences are safe
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr.recur = phi ptr [ %A, %entry ], [ %ptr.next, %loop ]
  %gep.B = getelementptr inbounds ptr, ptr %B, i64 %iv
  %ptr.next = load ptr, ptr %gep.B, align 8, !tbaa !6
  %l = load i32, ptr %ptr.recur, align 4
  %xor = xor i32 %l, 1
  %gep.C = getelementptr inbounds ptr, ptr %C, i64 %iv
  store i32 %xor, ptr %gep.C, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 5
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}


!6 = !{!7, !7, i64 0}
!7 = !{!"any pointer", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !8, i64 0}
