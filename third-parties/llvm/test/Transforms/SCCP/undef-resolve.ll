; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=sccp -S < %s | FileCheck %s


; PR6940
define double @test1() {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[T:%.*]] = sitofp i32 undef to double
; CHECK-NEXT:    ret double [[T]]
;
  %t = sitofp i32 undef to double
  ret double %t
}


; rdar://7832370
; Check that lots of stuff doesn't get turned into undef.
define i32 @test2() nounwind readnone ssp {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  init:
; CHECK-NEXT:    br label [[CONTROL_OUTER_OUTER:%.*]]
; CHECK:       control.outer.loopexit.us-lcssa:
; CHECK-NEXT:    br label [[CONTROL_OUTER_LOOPEXIT:%.*]]
; CHECK:       control.outer.loopexit:
; CHECK-NEXT:    br label [[CONTROL_OUTER_OUTER_BACKEDGE:%.*]]
; CHECK:       control.outer.outer:
; CHECK-NEXT:    [[SWITCHCOND_0_PH_PH:%.*]] = phi i32 [ 2, [[INIT:%.*]] ], [ 3, [[CONTROL_OUTER_OUTER_BACKEDGE]] ]
; CHECK-NEXT:    [[I_0_PH_PH:%.*]] = phi i32 [ undef, [[INIT]] ], [ [[I_0_PH_PH_BE:%.*]], [[CONTROL_OUTER_OUTER_BACKEDGE]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i32 [[I_0_PH_PH]], 0
; CHECK-NEXT:    br i1 [[TMP4]], label [[CONTROL_OUTER_OUTER_SPLIT_US:%.*]], label [[CONTROL_OUTER_OUTER_CONTROL_OUTER_OUTER_SPLIT_CRIT_EDGE:%.*]]
; CHECK:       control.outer.outer.control.outer.outer.split_crit_edge:
; CHECK-NEXT:    br label [[CONTROL_OUTER:%.*]]
; CHECK:       control.outer.outer.split.us:
; CHECK-NEXT:    br label [[CONTROL_OUTER_US:%.*]]
; CHECK:       control.outer.us:
; CHECK-NEXT:    [[A_0_PH_US:%.*]] = phi i32 [ [[SWITCHCOND_0_US:%.*]], [[BB3_US:%.*]] ], [ 4, [[CONTROL_OUTER_OUTER_SPLIT_US]] ]
; CHECK-NEXT:    [[SWITCHCOND_0_PH_US:%.*]] = phi i32 [ [[A_0_PH_US]], [[BB3_US]] ], [ [[SWITCHCOND_0_PH_PH]], [[CONTROL_OUTER_OUTER_SPLIT_US]] ]
; CHECK-NEXT:    br label [[CONTROL_US:%.*]]
; CHECK:       bb3.us:
; CHECK-NEXT:    br label [[CONTROL_OUTER_US]]
; CHECK:       bb0.us:
; CHECK-NEXT:    br label [[CONTROL_US]]
; CHECK:       control.us:
; CHECK-NEXT:    [[SWITCHCOND_0_US]] = phi i32 [ [[A_0_PH_US]], [[BB0_US:%.*]] ], [ [[SWITCHCOND_0_PH_US]], [[CONTROL_OUTER_US]] ]
; CHECK-NEXT:    switch i32 [[SWITCHCOND_0_US]], label [[CONTROL_OUTER_LOOPEXIT_US_LCSSA_US:%.*]] [
; CHECK-NEXT:      i32 0, label [[BB0_US]]
; CHECK-NEXT:      i32 1, label [[BB1_US_LCSSA_US:%.*]]
; CHECK-NEXT:      i32 3, label [[BB3_US]]
; CHECK-NEXT:      i32 4, label [[BB4_US_LCSSA_US:%.*]]
; CHECK-NEXT:    ]
; CHECK:       control.outer.loopexit.us-lcssa.us:
; CHECK-NEXT:    br label [[CONTROL_OUTER_LOOPEXIT]]
; CHECK:       bb1.us-lcssa.us:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb4.us-lcssa.us:
; CHECK-NEXT:    br label [[BB4:%.*]]
; CHECK:       control.outer:
; CHECK-NEXT:    [[A_0_PH:%.*]] = phi i32 [ [[NEXTID17:%.*]], [[BB3:%.*]] ], [ 4, [[CONTROL_OUTER_OUTER_CONTROL_OUTER_OUTER_SPLIT_CRIT_EDGE]] ]
; CHECK-NEXT:    [[SWITCHCOND_0_PH:%.*]] = phi i32 [ 0, [[BB3]] ], [ [[SWITCHCOND_0_PH_PH]], [[CONTROL_OUTER_OUTER_CONTROL_OUTER_OUTER_SPLIT_CRIT_EDGE]] ]
; CHECK-NEXT:    br label [[CONTROL:%.*]]
; CHECK:       control:
; CHECK-NEXT:    [[SWITCHCOND_0:%.*]] = phi i32 [ [[A_0_PH]], [[BB0:%.*]] ], [ [[SWITCHCOND_0_PH]], [[CONTROL_OUTER]] ]
; CHECK-NEXT:    switch i32 [[SWITCHCOND_0]], label [[CONTROL_OUTER_LOOPEXIT_US_LCSSA:%.*]] [
; CHECK-NEXT:      i32 0, label [[BB0]]
; CHECK-NEXT:      i32 1, label [[BB1_US_LCSSA:%.*]]
; CHECK-NEXT:      i32 3, label [[BB3]]
; CHECK-NEXT:      i32 4, label [[BB4_US_LCSSA:%.*]]
; CHECK-NEXT:    ]
; CHECK:       bb4.us-lcssa:
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       bb4:
; CHECK-NEXT:    br label [[CONTROL_OUTER_OUTER_BACKEDGE]]
; CHECK:       control.outer.outer.backedge:
; CHECK-NEXT:    [[I_0_PH_PH_BE]] = phi i32 [ 1, [[BB4]] ], [ 0, [[CONTROL_OUTER_LOOPEXIT]] ]
; CHECK-NEXT:    br label [[CONTROL_OUTER_OUTER]]
; CHECK:       bb3:
; CHECK-NEXT:    [[NEXTID17]] = add i32 [[SWITCHCOND_0]], -2
; CHECK-NEXT:    br label [[CONTROL_OUTER]]
; CHECK:       bb0:
; CHECK-NEXT:    br label [[CONTROL]]
; CHECK:       bb1.us-lcssa:
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       bb1:
; CHECK-NEXT:    ret i32 0
;
init:
  br label %control.outer.outer

control.outer.loopexit.us-lcssa:                  ; preds = %control
  br label %control.outer.loopexit

control.outer.loopexit:                           ; preds = %control.outer.loopexit.us-lcssa.us, %control.outer.loopexit.us-lcssa
  br label %control.outer.outer.backedge

control.outer.outer:                              ; preds = %control.outer.outer.backedge, %init
  %switchCond.0.ph.ph = phi i32 [ 2, %init ], [ 3, %control.outer.outer.backedge ] ; <i32> [#uses=2]
  %i.0.ph.ph = phi i32 [ undef, %init ], [ %i.0.ph.ph.be, %control.outer.outer.backedge ] ; <i32> [#uses=1]
  %tmp4 = icmp eq i32 %i.0.ph.ph, 0               ; <i1> [#uses=1]
  br i1 %tmp4, label %control.outer.outer.split.us, label %control.outer.outer.control.outer.outer.split_crit_edge

control.outer.outer.control.outer.outer.split_crit_edge: ; preds = %control.outer.outer
  br label %control.outer

control.outer.outer.split.us:                     ; preds = %control.outer.outer
  br label %control.outer.us

control.outer.us:                                 ; preds = %bb3.us, %control.outer.outer.split.us
  %A.0.ph.us = phi i32 [ %switchCond.0.us, %bb3.us ], [ 4, %control.outer.outer.split.us ] ; <i32> [#uses=2]
  %switchCond.0.ph.us = phi i32 [ %A.0.ph.us, %bb3.us ], [ %switchCond.0.ph.ph, %control.outer.outer.split.us ] ; <i32> [#uses=1]
  br label %control.us

bb3.us:                                           ; preds = %control.us
  br label %control.outer.us

bb0.us:                                           ; preds = %control.us
  br label %control.us

control.us:                                       ; preds = %bb0.us, %control.outer.us
  %switchCond.0.us = phi i32 [ %A.0.ph.us, %bb0.us ], [ %switchCond.0.ph.us, %control.outer.us ] ; <i32> [#uses=2]
  switch i32 %switchCond.0.us, label %control.outer.loopexit.us-lcssa.us [
  i32 0, label %bb0.us
  i32 1, label %bb1.us-lcssa.us
  i32 3, label %bb3.us
  i32 4, label %bb4.us-lcssa.us
  ]

control.outer.loopexit.us-lcssa.us:               ; preds = %control.us
  br label %control.outer.loopexit

bb1.us-lcssa.us:                                  ; preds = %control.us
  br label %bb1

bb4.us-lcssa.us:                                  ; preds = %control.us
  br label %bb4

control.outer:                                    ; preds = %bb3, %control.outer.outer.control.outer.outer.split_crit_edge
  %A.0.ph = phi i32 [ %nextId17, %bb3 ], [ 4, %control.outer.outer.control.outer.outer.split_crit_edge ] ; <i32> [#uses=1]
  %switchCond.0.ph = phi i32 [ 0, %bb3 ], [ %switchCond.0.ph.ph, %control.outer.outer.control.outer.outer.split_crit_edge ] ; <i32> [#uses=1]
  br label %control

control:                                          ; preds = %bb0, %control.outer
  %switchCond.0 = phi i32 [ %A.0.ph, %bb0 ], [ %switchCond.0.ph, %control.outer ] ; <i32> [#uses=2]
  switch i32 %switchCond.0, label %control.outer.loopexit.us-lcssa [
  i32 0, label %bb0
  i32 1, label %bb1.us-lcssa
  i32 3, label %bb3
  i32 4, label %bb4.us-lcssa
  ]

bb4.us-lcssa:                                     ; preds = %control
  br label %bb4

bb4:                                              ; preds = %bb4.us-lcssa, %bb4.us-lcssa.us
  br label %control.outer.outer.backedge

control.outer.outer.backedge:                     ; preds = %bb4, %control.outer.loopexit
  %i.0.ph.ph.be = phi i32 [ 1, %bb4 ], [ 0, %control.outer.loopexit ] ; <i32> [#uses=1]
  br label %control.outer.outer

bb3:                                              ; preds = %control
  %nextId17 = add i32 %switchCond.0, -2           ; <i32> [#uses=1]
  br label %control.outer

bb0:                                              ; preds = %control
  br label %control

bb1.us-lcssa:                                     ; preds = %control
  br label %bb1

bb1:                                              ; preds = %bb1.us-lcssa, %bb1.us-lcssa.us
  ret i32 0
}

; Make sure SCCP honors the xor "idiom"
; rdar://9956541
define i32 @test3() {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[T:%.*]] = xor i32 undef, undef
; CHECK-NEXT:    ret i32 [[T]]
;
  %t = xor i32 undef, undef
  ret i32 %t
}

; Be conservative with FP ops
define double @test4(double %x) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[T:%.*]] = fadd double [[X:%.*]], undef
; CHECK-NEXT:    ret double [[T]]
;
  %t = fadd double %x, undef
  ret double %t
}

; Make sure casts produce a possible value
define i32 @test5() {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[T:%.*]] = sext i8 undef to i32
; CHECK-NEXT:    ret i32 [[T]]
;
  %t = sext i8 undef to i32
  ret i32 %t
}

; Make sure ashr produces a possible value
define i32 @test6() {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[T:%.*]] = ashr i32 undef, 31
; CHECK-NEXT:    ret i32 [[T]]
;
  %t = ashr i32 undef, 31
  ret i32 %t
}

; Make sure lshr produces a possible value
define i32 @test7() {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[T:%.*]] = lshr i32 undef, 31
; CHECK-NEXT:    ret i32 [[T]]
;
  %t = lshr i32 undef, 31
  ret i32 %t
}

; icmp eq with undef simplifies to undef
define i1 @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[T:%.*]] = icmp eq i32 undef, -1
; CHECK-NEXT:    ret i1 [[T]]
;
  %t = icmp eq i32 undef, -1
  ret i1 %t
}

; Make sure we don't conclude that relational comparisons simplify to undef
define i1 @test9() {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[T:%.*]] = icmp ugt i32 undef, -1
; CHECK-NEXT:    ret i1 [[T]]
;
  %t = icmp ugt i32 undef, -1
  ret i1 %t
}

; Make sure we handle extractvalue
define i64 @test10() {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 undef
;
entry:
  %e = extractvalue { i64, i64 } undef, 1
  ret i64 %e
}

@GV = common global i32 0, align 4

define i32 @test11(i1 %tobool) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[EXT:%.*]] = zext i1 icmp eq (ptr @test11, ptr @GV) to i32
; CHECK-NEXT:    [[SHR4:%.*]] = ashr i32 undef, [[EXT]]
; CHECK-NEXT:    ret i32 [[SHR4]]
;
entry:
  %ext = zext i1 icmp eq (ptr @test11, ptr @GV) to i32
  %shr4 = ashr i32 undef, %ext
  ret i32 %shr4
}

; Test unary ops
define double @test12(double %x) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[T:%.*]] = fneg double undef
; CHECK-NEXT:    ret double [[T]]
;
  %t = fneg double undef
  ret double %t
}
