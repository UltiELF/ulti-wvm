; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=loop-rotate -o - -verify-loop-info -verify-dom-info | FileCheck %s

@d = external global i64, align 8
@f = external global i32, align 4
@g = external global i32, align 4
@i = external global i32, align 4
@h = external global i32, align 4

define i32 @o() #0 {
; CHECK-LABEL: @o(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = alloca [1 x i32], align 4
; CHECK-NEXT:    [[I1:%.*]] = load ptr, ptr @d, align 8
; CHECK-NEXT:    [[I33:%.*]] = load i32, ptr @f, align 4
; CHECK-NEXT:    [[I44:%.*]] = icmp eq i32 [[I33]], 0
; CHECK-NEXT:    br i1 [[I44]], label [[BB15:%.*]], label [[BB5_LR_PH:%.*]]
; CHECK:       bb5.lr.ph:
; CHECK-NEXT:    br label [[BB5:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    [[I35:%.*]] = phi i32 [ [[I33]], [[BB5_LR_PH]] ], [ [[I3:%.*]], [[M_EXIT:%.*]] ]
; CHECK-NEXT:    [[I6:%.*]] = icmp ult i32 [[I35]], 4
; CHECK-NEXT:    [[I7:%.*]] = zext i1 [[I6]] to i32
; CHECK-NEXT:    store i32 [[I7]], ptr @g, align 4
; CHECK-NEXT:    [[I9:%.*]] = call i32 @n(ptr nonnull [[I]], ptr [[I1]])
; CHECK-NEXT:    [[I10:%.*]] = icmp eq i32 [[I9]], 0
; CHECK-NEXT:    br i1 [[I10]], label [[THREAD_PRE_SPLIT:%.*]], label [[BB5_BB15_CRIT_EDGE:%.*]]
; CHECK:       thread-pre-split:
; CHECK-NEXT:    [[DOTPR:%.*]] = load i32, ptr @i, align 4
; CHECK-NEXT:    [[I12:%.*]] = icmp eq i32 [[DOTPR]], 0
; CHECK-NEXT:    br i1 [[I12]], label [[M_EXIT]], label [[BB13_LR_PH:%.*]]
; CHECK:       bb13.lr.ph:
; CHECK-NEXT:    br label [[BB13:%.*]]
; CHECK:       bb13:
; CHECK-NEXT:    [[DOT11:%.*]] = phi i32 [ undef, [[BB13_LR_PH]] ], [ [[I14:%.*]], [[J_EXIT_I:%.*]] ]
; CHECK-NEXT:    callbr void asm sideeffect "", "!i,~{dirflag},~{fpsr},~{flags}"() #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    to label [[J_EXIT_I]] [label %bb13.m.exit_crit_edge]
; CHECK:       j.exit.i:
; CHECK-NEXT:    [[I14]] = tail call i32 asm "", "={ax},~{dirflag},~{fpsr},~{flags}"() #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    br i1 [[I12]], label [[BB11_M_EXIT_CRIT_EDGE:%.*]], label [[BB13]]
; CHECK:       bb13.m.exit_crit_edge:
; CHECK-NEXT:    [[SPLIT:%.*]] = phi i32 [ [[DOT11]], [[BB13]] ]
; CHECK-NEXT:    br label [[M_EXIT]]
; CHECK:       bb11.m.exit_crit_edge:
; CHECK-NEXT:    [[SPLIT2:%.*]] = phi i32 [ [[I14]], [[J_EXIT_I]] ]
; CHECK-NEXT:    br label [[M_EXIT]]
; CHECK:       m.exit:
; CHECK-NEXT:    [[DOT1_LCSSA:%.*]] = phi i32 [ [[SPLIT]], [[BB13_M_EXIT_CRIT_EDGE:%.*]] ], [ [[SPLIT2]], [[BB11_M_EXIT_CRIT_EDGE]] ], [ undef, [[THREAD_PRE_SPLIT]] ]
; CHECK-NEXT:    store i32 [[DOT1_LCSSA]], ptr @h, align 4
; CHECK-NEXT:    [[I3]] = load i32, ptr @f, align 4
; CHECK-NEXT:    [[I4:%.*]] = icmp eq i32 [[I3]], 0
; CHECK-NEXT:    br i1 [[I4]], label [[BB2_BB15_CRIT_EDGE:%.*]], label [[BB5]]
; CHECK:       bb5.bb15_crit_edge:
; CHECK-NEXT:    br label [[BB15]]
; CHECK:       bb2.bb15_crit_edge:
; CHECK-NEXT:    br label [[BB15]]
; CHECK:       bb15:
; CHECK-NEXT:    ret i32 undef
;
bb:
  %i = alloca [1 x i32], align 4
  %i1 = load ptr, ptr @d, align 8
  br label %bb2

bb2:                                              ; preds = %m.exit, %bb
  %i3 = load i32, ptr @f, align 4
  %i4 = icmp eq i32 %i3, 0
  br i1 %i4, label %bb15, label %bb5

bb5:                                              ; preds = %bb2
  %i6 = icmp ult i32 %i3, 4
  %i7 = zext i1 %i6 to i32
  store i32 %i7, ptr @g, align 4
  %i9 = call i32 @n(ptr nonnull %i, ptr %i1)
  %i10 = icmp eq i32 %i9, 0
  br i1 %i10, label %thread-pre-split, label %bb15

thread-pre-split:                                 ; preds = %bb5
  %.pr = load i32, ptr @i, align 4
  br label %bb11

bb11:                                             ; preds = %j.exit.i, %thread-pre-split
  %.1 = phi i32 [ %i14, %j.exit.i ], [ undef, %thread-pre-split ]
  %i12 = icmp eq i32 %.pr, 0
  br i1 %i12, label %m.exit, label %bb13

bb13:                                             ; preds = %bb11
  callbr void asm sideeffect "", "!i,~{dirflag},~{fpsr},~{flags}"() #1
  to label %j.exit.i [label %m.exit]

j.exit.i:                                         ; preds = %bb13
  %i14 = tail call i32 asm "", "={ax},~{dirflag},~{fpsr},~{flags}"() #2
  br label %bb11

m.exit:                                           ; preds = %bb13, %bb11
  %.1.lcssa = phi i32 [ %.1, %bb13 ], [ %.1, %bb11 ]
  store i32 %.1.lcssa, ptr @h, align 4
  br label %bb2

bb15:                                             ; preds = %bb5, %bb2
  ret i32 undef
}

declare i32 @n(ptr, ptr)  #0

attributes #0 = { "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }
