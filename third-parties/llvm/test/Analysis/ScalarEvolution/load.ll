; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -disable-output "-passes=print<scalar-evolution>" < %s 2>&1 | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-pc-linux-gnu"

@arr1 = internal unnamed_addr constant [50 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50], align 4
@arr2 = internal unnamed_addr constant [50 x i32] [i32 49, i32 48, i32 47, i32 46, i32 45, i32 44, i32 43, i32 42, i32 41, i32 40, i32 39, i32 38, i32 37, i32 36, i32 35, i32 34, i32 33, i32 32, i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0], align 4

; PR11034
define i32 @test1() nounwind readnone {
; CHECK-LABEL: 'test1'
; CHECK-NEXT:  Classifying expressions for: @test1
; CHECK-NEXT:    %sum.04 = phi i32 [ 0, %entry ], [ %add2, %for.body ]
; CHECK-NEXT:    --> %sum.04 U: full-set S: full-set Exits: 2450 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,50) S: [0,50) Exits: 49 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %arrayidx = getelementptr inbounds [50 x i32], ptr @arr1, i32 0, i32 %i.03
; CHECK-NEXT:    --> {@arr1,+,4}<nuw><%for.body> U: [4,-7) S: [-2147483648,2147483645) Exits: (196 + @arr1)<nuw> LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %0 = load i32, ptr %arrayidx, align 4
; CHECK-NEXT:    --> %0 U: full-set S: full-set Exits: 50 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %arrayidx1 = getelementptr inbounds [50 x i32], ptr @arr2, i32 0, i32 %i.03
; CHECK-NEXT:    --> {@arr2,+,4}<nuw><%for.body> U: [4,-7) S: [-2147483648,2147483645) Exits: (196 + @arr2)<nuw> LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %1 = load i32, ptr %arrayidx1, align 4
; CHECK-NEXT:    --> %1 U: full-set S: full-set Exits: 0 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %add = add i32 %0, %sum.04
; CHECK-NEXT:    --> (%0 + %sum.04) U: full-set S: full-set Exits: 2500 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %add2 = add i32 %add, %1
; CHECK-NEXT:    --> (%1 + %0 + %sum.04) U: full-set S: full-set Exits: 2500 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %inc = add nsw i32 %i.03, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,51) S: [1,51) Exits: 50 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test1
; CHECK-NEXT:  Loop %for.body: backedge-taken count is 49
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 49
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is 49
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is 49
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 50
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %sum.04 = phi i32 [ 0, %entry ], [ %add2, %for.body ]
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds [50 x i32], ptr @arr1, i32 0, i32 %i.03
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [50 x i32], ptr @arr2, i32 0, i32 %i.03
  %1 = load i32, ptr %arrayidx1, align 4
  %add = add i32 %0, %sum.04
  %add2 = add i32 %add, %1
  %inc = add nsw i32 %i.03, 1
  %cmp = icmp eq i32 %inc, 50
  br i1 %cmp, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret i32 %add2
}


%struct.ListNode = type { ptr, i32 }

@node5 = internal constant { ptr, i32, [4 x i8] } { ptr @node4, i32 4, [4 x i8] undef }, align 8
@node4 = internal constant { ptr, i32, [4 x i8] } { ptr @node3, i32 3, [4 x i8] undef }, align 8
@node3 = internal constant { ptr, i32, [4 x i8] } { ptr @node2, i32 2, [4 x i8] undef }, align 8
@node2 = internal constant { ptr, i32, [4 x i8] } { ptr @node1, i32 1, [4 x i8] undef }, align 8
@node1 = internal constant { ptr, i32, [4 x i8] } { ptr null, i32 0, [4 x i8] undef }, align 8

define i32 @test2() nounwind uwtable readonly {
; CHECK-LABEL: 'test2'
; CHECK-NEXT:  Classifying expressions for: @test2
; CHECK-NEXT:    %sum.02 = phi i32 [ 0, %entry ], [ %add, %for.body ]
; CHECK-NEXT:    --> %sum.02 U: full-set S: full-set Exits: 10 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %n.01 = phi ptr [ @node5, %entry ], [ %1, %for.body ]
; CHECK-NEXT:    --> %n.01 U: full-set S: full-set Exits: @node1 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %i = getelementptr inbounds %struct.ListNode, ptr %n.01, i64 0, i32 1
; CHECK-NEXT:    --> (4 + %n.01)<nuw> U: [4,0) S: [4,0) Exits: (4 + @node1)<nuw><nsw> LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %0 = load i32, ptr %i, align 4
; CHECK-NEXT:    --> %0 U: full-set S: full-set Exits: 0 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %add = add nsw i32 %0, %sum.02
; CHECK-NEXT:    --> (%0 + %sum.02) U: full-set S: full-set Exits: 10 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %next = getelementptr inbounds %struct.ListNode, ptr %n.01, i64 0, i32 0
; CHECK-NEXT:    --> %n.01 U: full-set S: full-set Exits: @node1 LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:    %1 = load ptr, ptr %next, align 8
; CHECK-NEXT:    --> %1 U: full-set S: full-set Exits: null LoopDispositions: { %for.body: Variant }
; CHECK-NEXT:  Determining loop execution counts for: @test2
; CHECK-NEXT:  Loop %for.body: backedge-taken count is 4
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 4
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is 4
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is 4
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 5
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %sum.02 = phi i32 [ 0, %entry ], [ %add, %for.body ]
  %n.01 = phi ptr [ @node5, %entry ], [ %1, %for.body ]
  %i = getelementptr inbounds %struct.ListNode, ptr %n.01, i64 0, i32 1
  %0 = load i32, ptr %i, align 4
  %add = add nsw i32 %0, %sum.02
  %next = getelementptr inbounds %struct.ListNode, ptr %n.01, i64 0, i32 0
  %1 = load ptr, ptr %next, align 8
  %cmp = icmp eq ptr %1, null
  br i1 %cmp, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret i32 %add
}
