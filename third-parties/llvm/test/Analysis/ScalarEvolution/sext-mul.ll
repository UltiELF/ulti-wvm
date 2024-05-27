; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>" 2>&1 | FileCheck %s

define void @foo(ptr nocapture %arg, i32 %arg1, i32 %arg2) {
; CHECK-LABEL: 'foo'
; CHECK-NEXT:  Classifying expressions for: @foo
; CHECK-NEXT:    %tmp4 = zext i32 %arg2 to i64
; CHECK-NEXT:    --> (zext i32 %arg2 to i64) U: [0,4294967296) S: [0,4294967296)
; CHECK-NEXT:    %tmp8 = phi i64 [ %tmp18, %bb7 ], [ 0, %bb3 ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%bb7> U: [0,2147483647) S: [0,2147483647) Exits: (-1 + (zext i32 %arg2 to i64))<nsw> LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %tmp9 = shl i64 %tmp8, 33
; CHECK-NEXT:    --> {0,+,8589934592}<nuw><%bb7> U: [0,-17179869183) S: [-9223372036854775808,9223372028264841217) Exits: (-8589934592 + (8589934592 * (zext i32 %arg2 to i64))) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %tmp10 = ashr exact i64 %tmp9, 32
; CHECK-NEXT:    --> (sext i32 {0,+,2}<%bb7> to i64) U: [0,-1) S: [-2147483648,2147483647) Exits: (sext i32 (-2 + (2 * %arg2)) to i64) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %tmp11 = getelementptr inbounds i32, ptr %arg, i64 %tmp10
; CHECK-NEXT:    --> ((4 * (sext i32 {0,+,2}<%bb7> to i64))<nsw> + %arg) U: full-set S: full-set Exits: ((4 * (sext i32 (-2 + (2 * %arg2)) to i64))<nsw> + %arg) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %tmp12 = load i32, ptr %tmp11, align 4
; CHECK-NEXT:    --> %tmp12 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %tmp13 = sub nsw i32 %tmp12, %arg1
; CHECK-NEXT:    --> ((-1 * %arg1) + %tmp12) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %tmp14 = or disjoint i64 %tmp10, 1
; CHECK-NEXT:    --> (1 + (sext i32 {0,+,2}<%bb7> to i64))<nuw><nsw> U: [1,0) S: [-2147483647,2147483648) Exits: (1 + (sext i32 (-2 + (2 * %arg2)) to i64))<nuw><nsw> LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %tmp15 = getelementptr inbounds i32, ptr %arg, i64 %tmp14
; CHECK-NEXT:    --> (4 + (4 * (sext i32 {0,+,2}<%bb7> to i64))<nsw> + %arg) U: full-set S: full-set Exits: (4 + (4 * (sext i32 (-2 + (2 * %arg2)) to i64))<nsw> + %arg) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %tmp16 = load i32, ptr %tmp15, align 4
; CHECK-NEXT:    --> %tmp16 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %tmp17 = mul nsw i32 %tmp16, %arg1
; CHECK-NEXT:    --> (%arg1 * %tmp16) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %tmp18 = add nuw nsw i64 %tmp8, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%bb7> U: [1,2147483648) S: [1,2147483648) Exits: (zext i32 %arg2 to i64) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @foo
; CHECK-NEXT:  Loop %bb7: backedge-taken count is (-1 + (zext i32 %arg2 to i64))<nsw>
; CHECK-NEXT:  Loop %bb7: constant max backedge-taken count is 2147483646
; CHECK-NEXT:  Loop %bb7: symbolic max backedge-taken count is (-1 + (zext i32 %arg2 to i64))<nsw>
; CHECK-NEXT:  Loop %bb7: Predicated backedge-taken count is (-1 + (zext i32 %arg2 to i64))<nsw>
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %bb7: Trip multiple is 1
;
bb:
  %tmp = icmp sgt i32 %arg2, 0
  br i1 %tmp, label %bb3, label %bb6

bb3:                                              ; preds = %bb
  %tmp4 = zext i32 %arg2 to i64
  br label %bb7

bb5:                                              ; preds = %bb7
  br label %bb6

bb6:                                              ; preds = %bb5, %bb
  ret void

bb7:                                              ; preds = %bb7, %bb3
  %tmp8 = phi i64 [ %tmp18, %bb7 ], [ 0, %bb3 ]
  %tmp9 = shl i64 %tmp8, 33
  %tmp10 = ashr exact i64 %tmp9, 32
  %tmp11 = getelementptr inbounds i32, ptr %arg, i64 %tmp10
  %tmp12 = load i32, ptr %tmp11, align 4
  %tmp13 = sub nsw i32 %tmp12, %arg1
  store i32 %tmp13, ptr %tmp11, align 4
  %tmp14 = or disjoint i64 %tmp10, 1
  %tmp15 = getelementptr inbounds i32, ptr %arg, i64 %tmp14
  %tmp16 = load i32, ptr %tmp15, align 4
  %tmp17 = mul nsw i32 %tmp16, %arg1
  store i32 %tmp17, ptr %tmp15, align 4
  %tmp18 = add nuw nsw i64 %tmp8, 1
  %tmp19 = icmp eq i64 %tmp18, %tmp4
  br i1 %tmp19, label %bb5, label %bb7
}

define void @goo(ptr nocapture %arg3, i32 %arg4, i32 %arg5) {
; CHECK-LABEL: 'goo'
; CHECK-NEXT:  Classifying expressions for: @goo
; CHECK-NEXT:    %t4 = zext i32 %arg5 to i128
; CHECK-NEXT:    --> (zext i32 %arg5 to i128) U: [0,4294967296) S: [0,4294967296)
; CHECK-NEXT:    %t8 = phi i128 [ %t18, %bb7 ], [ 0, %bb3 ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%bb7> U: [0,2147483647) S: [0,2147483647) Exits: (-1 + (zext i32 %arg5 to i128))<nsw> LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %t9 = shl i128 %t8, 100
; CHECK-NEXT:    --> {0,+,1267650600228229401496703205376}<%bb7> U: [0,-1267650600228229401496703205375) S: [-170141183460469231731687303715884105728,170141182192818631503457902219180900353) Exits: (-1267650600228229401496703205376 + (1267650600228229401496703205376 * (zext i32 %arg5 to i128))) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %t10 = ashr exact i128 %t9, 1
; CHECK-NEXT:    --> (sext i127 {0,+,633825300114114700748351602688}<%bb7> to i128) U: [0,-633825300114114700748351602687) S: [-85070591730234615865843651857942052864,85070591096409315751728951109590450177) Exits: (sext i127 (-633825300114114700748351602688 + (633825300114114700748351602688 * (zext i32 %arg5 to i127))) to i128) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %t11 = getelementptr inbounds i32, ptr %arg3, i128 %t10
; CHECK-NEXT:    --> %arg3 U: full-set S: full-set Exits: %arg3 LoopDispositions: { %bb7: Invariant }
; CHECK-NEXT:    %t12 = load i32, ptr %t11, align 4
; CHECK-NEXT:    --> %t12 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %t13 = sub nsw i32 %t12, %arg4
; CHECK-NEXT:    --> ((-1 * %arg4) + %t12) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %t14 = or disjoint i128 %t10, 1
; CHECK-NEXT:    --> (1 + (sext i127 {0,+,633825300114114700748351602688}<%bb7> to i128))<nuw><nsw> U: [1,-633825300114114700748351602686) S: [-85070591730234615865843651857942052863,85070591096409315751728951109590450178) Exits: (1 + (sext i127 (-633825300114114700748351602688 + (633825300114114700748351602688 * (zext i32 %arg5 to i127))) to i128))<nuw><nsw> LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:    %t15 = getelementptr inbounds i32, ptr %arg3, i128 %t14
; CHECK-NEXT:    --> (4 + %arg3)<nuw> U: [4,0) S: [4,0) Exits: (4 + %arg3)<nuw> LoopDispositions: { %bb7: Invariant }
; CHECK-NEXT:    %t16 = load i32, ptr %t15, align 4
; CHECK-NEXT:    --> %t16 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %t17 = mul nsw i32 %t16, %arg4
; CHECK-NEXT:    --> (%arg4 * %t16) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %bb7: Variant }
; CHECK-NEXT:    %t18 = add nuw nsw i128 %t8, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%bb7> U: [1,2147483648) S: [1,2147483648) Exits: (zext i32 %arg5 to i128) LoopDispositions: { %bb7: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @goo
; CHECK-NEXT:  Loop %bb7: backedge-taken count is (-1 + (zext i32 %arg5 to i128))<nsw>
; CHECK-NEXT:  Loop %bb7: constant max backedge-taken count is 2147483646
; CHECK-NEXT:  Loop %bb7: symbolic max backedge-taken count is (-1 + (zext i32 %arg5 to i128))<nsw>
; CHECK-NEXT:  Loop %bb7: Predicated backedge-taken count is (-1 + (zext i32 %arg5 to i128))<nsw>
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %bb7: Trip multiple is 1
;
bb:
  %t = icmp sgt i32 %arg5, 0
  br i1 %t, label %bb3, label %bb6

bb3:                                              ; preds = %bb
  %t4 = zext i32 %arg5 to i128
  br label %bb7

bb5:                                              ; preds = %bb7
  br label %bb6

bb6:                                              ; preds = %bb5, %bb
  ret void

bb7:                                              ; preds = %bb7, %bb3
  %t8 = phi i128 [ %t18, %bb7 ], [ 0, %bb3 ]
  %t9 = shl i128 %t8, 100
  %t10 = ashr exact i128 %t9, 1
  %t11 = getelementptr inbounds i32, ptr %arg3, i128 %t10
  %t12 = load i32, ptr %t11, align 4
  %t13 = sub nsw i32 %t12, %arg4
  store i32 %t13, ptr %t11, align 4
  %t14 = or disjoint i128 %t10, 1
  %t15 = getelementptr inbounds i32, ptr %arg3, i128 %t14
  %t16 = load i32, ptr %t15, align 4
  %t17 = mul nsw i32 %t16, %arg4
  store i32 %t17, ptr %t15, align 4
  %t18 = add nuw nsw i128 %t8, 1
  %t19 = icmp eq i128 %t18, %t4
  br i1 %t19, label %bb5, label %bb7
}
