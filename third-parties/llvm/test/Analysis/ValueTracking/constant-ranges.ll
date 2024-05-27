; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instsimplify < %s -S | FileCheck %s

define i1 @shl_C_X_ugt(i8 %x) {
; CHECK-LABEL: @shl_C_X_ugt(
; CHECK-NEXT:    ret i1 false
;
  %shl = shl i8 7, %x
  %r = icmp ugt i8 %shl, 224
  ret i1 %r
}

define i1 @shl_C_X_ugt2(i8 %x) {
; CHECK-LABEL: @shl_C_X_ugt2(
; CHECK-NEXT:    ret i1 false
;
  %shl = shl i8 5, %x
  %r = icmp ugt i8 %shl, 192
  ret i1 %r
}

define i1 @shl_C_X_ugt_fail(i8 %x) {
; CHECK-LABEL: @shl_C_X_ugt_fail(
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 1, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[SHL]], 127
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 1, %x
  %r = icmp ugt i8 %shl, 127
  ret i1 %r
}

define i1 @shl_C_X_ugt_fail2(i8 %x) {
; CHECK-LABEL: @shl_C_X_ugt_fail2(
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 3, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[SHL]], -66
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 3, %x
  %r = icmp ugt i8 %shl, 190
  ret i1 %r
}

define i1 @shl_C_X_ugt_fail3(i8 %x) {
; CHECK-LABEL: @shl_C_X_ugt_fail3(
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 -1, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[SHL]], -2
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 -1, %x
  %r = icmp ugt i8 %shl, 254
  ret i1 %r
}

define i1 @shl_C_X_ugt_todo(i8 %x) {
; CHECK-LABEL: @shl_C_X_ugt_todo(
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 -127, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[SHL]], -116
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 129, %x
  %r = icmp ugt i8 %shl, 140
  ret i1 %r
}

define i1 @shl_X_C_ugt(i8 %x) {
; CHECK-LABEL: @shl_X_C_ugt(
; CHECK-NEXT:    ret i1 false
;
  %shl = shl i8 %x, 6
  %r = icmp ugt i8 %shl, 192
  ret i1 %r
}

define i1 @shl_X_C_ugt_fail(i8 %x) {
; CHECK-LABEL: @shl_X_C_ugt_fail(
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 [[X:%.*]], 6
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[SHL]], -65
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 %x, 6
  %r = icmp ugt i8 %shl, 191
  ret i1 %r
}

define i1 @shl_X_C_ugt_fail2(i8 %x) {
; CHECK-LABEL: @shl_X_C_ugt_fail2(
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 [[X:%.*]], 5
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[SHL]], -64
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 %x, 5
  %r = icmp ugt i8 %shl, 192
  ret i1 %r
}

define i1 @and_ugt(i8 %xx) {
; CHECK-LABEL: @and_ugt(
; CHECK-NEXT:    ret i1 false
;
  %x = mul i8 %xx, %xx  ; thwart complexity-based canonicalization
  %negx = sub i8 0, %x
  %x_p2 = and i8 %negx, %x
  %r = icmp ugt i8 %x_p2, 128
  ret i1 %r
}

define i1 @and_ugt2(i8 %xx) {
; CHECK-LABEL: @and_ugt2(
; CHECK-NEXT:    ret i1 false
;
  %x = mul i8 %xx, %xx  ; thwart complexity-based canonicalization
  %negx = sub i8 0, %x
  %x_p2 = and i8 %x, %negx
  %r = icmp ugt i8 %x_p2, 128
  ret i1 %r
}

define i1 @and_ugt_fail(i8 %xx) {
; CHECK-LABEL: @and_ugt_fail(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[XX:%.*]], [[XX]]
; CHECK-NEXT:    [[NEGX:%.*]] = sub i8 0, [[X]]
; CHECK-NEXT:    [[X_P2:%.*]] = and i8 [[X]], [[NEGX]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[X_P2]], 127
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = mul i8 %xx, %xx  ; thwart complexity-based canonicalization
  %negx = sub i8 0, %x
  %x_p2 = and i8 %x, %negx
  %r = icmp ugt i8 %x_p2, 127
  ret i1 %r
}
