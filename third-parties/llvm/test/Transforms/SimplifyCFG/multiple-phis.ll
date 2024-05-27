; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2

; RUN: opt -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -keep-loops=false -S < %s | FileCheck %s
; RUN: opt -passes='simplifycfg<no-keep-loops>' -S < %s | FileCheck %s

; It's not worthwhile to if-convert one of the phi nodes and leave
; the other behind, because that still requires a branch. If
; SimplifyCFG if-converts one of the phis, it should do both.

define i32 @upper_bound(ptr %r, i32 %high, i32 %k) nounwind {
; CHECK-LABEL: define i32 @upper_bound
; CHECK-SAME: (ptr [[R:%.*]], i32 [[HIGH:%.*]], i32 [[K:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[HIGH_ADDR_0:%.*]] = phi i32 [ [[HIGH]], [[ENTRY:%.*]] ], [ [[SPEC_SELECT:%.*]], [[WHILE_BODY:%.*]] ]
; CHECK-NEXT:    [[LOW_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[SPEC_SELECT1:%.*]], [[WHILE_BODY]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[LOW_0]], [[HIGH_ADDR_0]]
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_BODY]], label [[WHILE_END:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LOW_0]], [[HIGH_ADDR_0]]
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 [[ADD]], 2
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[DIV]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[R]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[K]], [[TMP0]]
; CHECK-NEXT:    [[ADD2:%.*]] = add i32 [[DIV]], 1
; CHECK-NEXT:    [[SPEC_SELECT]] = select i1 [[CMP1]], i32 [[DIV]], i32 [[HIGH_ADDR_0]]
; CHECK-NEXT:    [[SPEC_SELECT1]] = select i1 [[CMP1]], i32 [[LOW_0]], i32 [[ADD2]]
; CHECK-NEXT:    br label [[WHILE_COND]]
; CHECK:       while.end:
; CHECK-NEXT:    ret i32 [[LOW_0]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %if.then, %if.else, %entry
  %high.addr.0 = phi i32 [ %high, %entry ], [ %div, %if.then ], [ %high.addr.0, %if.else ]
  %low.0 = phi i32 [ 0, %entry ], [ %low.0, %if.then ], [ %add2, %if.else ]
  %cmp = icmp ult i32 %low.0, %high.addr.0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %add = add i32 %low.0, %high.addr.0
  %div = udiv i32 %add, 2
  %idxprom = zext i32 %div to i64
  %arrayidx = getelementptr inbounds i32, ptr %r, i64 %idxprom
  %0 = load i32, ptr %arrayidx
  %cmp1 = icmp ult i32 %k, %0
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  br label %while.cond

if.else:                                          ; preds = %while.body
  %add2 = add i32 %div, 1
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %low.0
}

define i32 @merge0(i1 %c1, i1 %c2, i1 %c3) {
; CHECK-LABEL: define i32 @merge0
; CHECK-SAME: (i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]]) {
; CHECK-NEXT:  j2:
; CHECK-NEXT:    [[DOT:%.*]] = select i1 [[C2]], i32 0, i32 1
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[C3]], i32 2, i32 3
; CHECK-NEXT:    [[PHI2:%.*]] = select i1 [[C1]], i32 [[DOT]], i32 [[SPEC_SELECT]]
; CHECK-NEXT:    ret i32 [[PHI2]]
;
  br i1 %c1, label %if1, label %else1

if1:
  br i1 %c2, label %if2, label %else2

if2:
  br label %j1 else2:
  br label %j1

else1:
  br i1 %c3, label %j1, label %j2

j1:
  %phi1 = phi i32 [ 0, %if2 ], [ 1, %else2 ], [ 2, %else1 ]
  br label %j2

j2:
  %phi2 = phi i32 [ %phi1, %j1 ], [ 3, %else1 ]
  ret i32 %phi2
}

define i8 @merge1(i8 noundef %arg, i1 %c1, i1 %c2) {
; CHECK-LABEL: define i8 @merge1
; CHECK-SAME: (i8 noundef [[ARG:%.*]], i1 [[C1:%.*]], i1 [[C2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[ARG]], label [[UNREACHABLE:%.*]] [
; CHECK-NEXT:    i8 -123, label [[CASE0:%.*]]
; CHECK-NEXT:    i8 66, label [[SUCC:%.*]]
; CHECK-NEXT:    i8 123, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
; CHECK:       case0:
; CHECK-NEXT:    [[C1_NOT:%.*]] = xor i1 [[C1]], true
; CHECK-NEXT:    [[C2_NOT:%.*]] = xor i1 [[C2]], true
; CHECK-NEXT:    [[BRMERGE:%.*]] = select i1 [[C1_NOT]], i1 true, i1 [[C2_NOT]]
; CHECK-NEXT:    [[DOTMUX:%.*]] = select i1 [[C1_NOT]], i8 0, i8 3
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[BRMERGE]], i8 [[DOTMUX]], i8 4
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       Succ:
; CHECK-NEXT:    [[PHI2:%.*]] = phi i8 [ 2, [[CASE2]] ], [ 1, [[ENTRY:%.*]] ], [ [[SPEC_SELECT]], [[CASE0]] ]
; CHECK-NEXT:    ret i8 [[PHI2]]
;
entry:
  switch i8 %arg, label %unreachable [
  i8 -123, label %case0
  i8 66, label %case1
  i8 123, label %case2
  ]

unreachable:
  unreachable

case0:
  br i1 %c1, label %CommonPred, label %BB

case1:
  br label %BB

case2:
  br label %BB

CommonPred:
  br i1 %c2, label %Succ, label %BB

BB:
  %phi1 = phi i8 [ 0, %case0 ], [1, %case1],[2, %case2],[3,%CommonPred]
  br label %Succ

Succ:
  %phi2 = phi i8 [ %phi1, %BB ], [ 4, %CommonPred ]
  ret i8 %phi2
}

define i8 @merge1_unfoldable_one_block(i8 noundef %arg, i1 %c1, i1 %c2) {
; CHECK-LABEL: define i8 @merge1_unfoldable_one_block
; CHECK-SAME: (i8 noundef [[ARG:%.*]], i1 [[C1:%.*]], i1 [[C2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[ARG]], label [[UNREACHABLE:%.*]] [
; CHECK-NEXT:    i8 -123, label [[CASE0:%.*]]
; CHECK-NEXT:    i8 66, label [[SUCC:%.*]]
; CHECK-NEXT:    i8 123, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
; CHECK:       case0:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    [[C1_NOT:%.*]] = xor i1 [[C1]], true
; CHECK-NEXT:    [[C2_NOT:%.*]] = xor i1 [[C2]], true
; CHECK-NEXT:    [[BRMERGE:%.*]] = select i1 [[C1_NOT]], i1 true, i1 [[C2_NOT]]
; CHECK-NEXT:    [[DOTMUX:%.*]] = select i1 [[C1_NOT]], i8 0, i8 3
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[BRMERGE]], i8 [[DOTMUX]], i8 4
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       Succ:
; CHECK-NEXT:    [[PHI2:%.*]] = phi i8 [ 2, [[CASE2]] ], [ 1, [[ENTRY:%.*]] ], [ [[SPEC_SELECT]], [[CASE0]] ]
; CHECK-NEXT:    ret i8 [[PHI2]]
;
entry:
  switch i8 %arg, label %unreachable [
  i8 -123, label %case0
  i8 66, label %case1
  i8 123, label %case2
  ]

unreachable:
  unreachable

case0:
  call void @dummy()
  br i1 %c1, label %CommonPred, label %BB

case1:
  br label %BB

case2:
  br label %BB

CommonPred:
  br i1 %c2, label %Succ, label %BB

BB:
  %phi1 = phi i8 [ 0, %case0 ], [1, %case1],[2, %case2],[3,%CommonPred]
  br label %Succ

Succ:
  %phi2 = phi i8 [ %phi1, %BB ], [ 4, %CommonPred ]
  ret i8 %phi2
}

define i8 @merge1_unfoldable_two_block(i8 noundef %arg, i1 %c1, i1 %c2) {
; CHECK-LABEL: define i8 @merge1_unfoldable_two_block
; CHECK-SAME: (i8 noundef [[ARG:%.*]], i1 [[C1:%.*]], i1 [[C2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[ARG]], label [[UNREACHABLE:%.*]] [
; CHECK-NEXT:    i8 -123, label [[CASE0:%.*]]
; CHECK-NEXT:    i8 66, label [[CASE1:%.*]]
; CHECK-NEXT:    i8 123, label [[SUCC:%.*]]
; CHECK-NEXT:    ]
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
; CHECK:       case0:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    [[C1_NOT:%.*]] = xor i1 [[C1]], true
; CHECK-NEXT:    [[C2_NOT:%.*]] = xor i1 [[C2]], true
; CHECK-NEXT:    [[BRMERGE:%.*]] = select i1 [[C1_NOT]], i1 true, i1 [[C2_NOT]]
; CHECK-NEXT:    [[DOTMUX:%.*]] = select i1 [[C1_NOT]], i8 0, i8 3
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[BRMERGE]], i8 [[DOTMUX]], i8 4
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       case1:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       Succ:
; CHECK-NEXT:    [[PHI2:%.*]] = phi i8 [ 1, [[CASE1]] ], [ 2, [[ENTRY:%.*]] ], [ [[SPEC_SELECT]], [[CASE0]] ]
; CHECK-NEXT:    ret i8 [[PHI2]]
;
entry:
  switch i8 %arg, label %unreachable [
  i8 -123, label %case0
  i8 66, label %case1
  i8 123, label %case2
  ]

unreachable:
  unreachable

case0:
call void @dummy()
  br i1 %c1, label %CommonPred, label %BB

case1:
call void @dummy()
  br label %BB

case2:
  br label %BB

CommonPred:
  br i1 %c2, label %Succ, label %BB

BB:
  %phi1 = phi i8 [ 0, %case0 ], [1, %case1],[2, %case2],[3,%CommonPred]
  br label %Succ

Succ:
  %phi2 = phi i8 [ %phi1, %BB ], [ 4, %CommonPred ]
  ret i8 %phi2
}

define i8 @merge1_unfoldable_all_block(i8 noundef %arg, i1 %c1, i1 %c2) {
; CHECK-LABEL: define i8 @merge1_unfoldable_all_block
; CHECK-SAME: (i8 noundef [[ARG:%.*]], i1 [[C1:%.*]], i1 [[C2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[ARG]], label [[UNREACHABLE:%.*]] [
; CHECK-NEXT:    i8 -123, label [[CASE0:%.*]]
; CHECK-NEXT:    i8 66, label [[CASE1:%.*]]
; CHECK-NEXT:    i8 123, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
; CHECK:       case0:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    br i1 [[C1]], label [[COMMONPRED:%.*]], label [[SUCC:%.*]]
; CHECK:       case1:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       case2:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       CommonPred:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[C2]], i8 4, i8 3
; CHECK-NEXT:    br label [[SUCC]]
; CHECK:       Succ:
; CHECK-NEXT:    [[PHI2:%.*]] = phi i8 [ 0, [[CASE0]] ], [ 1, [[CASE1]] ], [ 2, [[CASE2]] ], [ [[SPEC_SELECT]], [[COMMONPRED]] ]
; CHECK-NEXT:    ret i8 [[PHI2]]
;
entry:
  switch i8 %arg, label %unreachable [
  i8 -123, label %case0
  i8 66, label %case1
  i8 123, label %case2
  ]

unreachable:
  unreachable

case0:
call void @dummy()
  br i1 %c1, label %CommonPred, label %BB

case1:
call void @dummy()
  br label %BB

case2:
call void @dummy()
  br label %BB

CommonPred:
call void @dummy()
  br i1 %c2, label %Succ, label %BB

BB:
  %phi1 = phi i8 [ 0, %case0 ], [1, %case1],[2, %case2],[3,%CommonPred]
  br label %Succ

Succ:
  %phi2 = phi i8 [ %phi1, %BB ], [ 4, %CommonPred ]
  ret i8 %phi2
}

declare void @dummy()

