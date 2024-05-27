; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This checks that we are able to outline exactly the same structure without
; any other items to outline.

define void @outline_outputs1() #0 {
entry:
  br label %next
next:
  br label %next2
next2:
  br label %next3
next3:
  %a = alloca i32, align 4
  br label %next4
next4:
  br label %next5
next5:
  br label %next6
next6:
  %b = alloca i32, align 4
  ret void
}

; CHECK-LABEL: @outline_outputs1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @outlined_ir_func_0()
; CHECK-NEXT:    br label [[NEXT3:%.*]]
; CHECK:       next3:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0()
; CHECK-NEXT:    br label [[NEXT6:%.*]]
; CHECK:       next6:
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    ret void
;
;
; CHECK: define internal void @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[ENTRY_TO_OUTLINE:%.*]]
; CHECK:       entry_to_outline:
; CHECK-NEXT:    br label [[NEXT:%.*]]
; CHECK:       next:
; CHECK-NEXT:    br label [[NEXT2:%.*]]
; CHECK:       next2:
; CHECK-NEXT:    br label [[NEXT3_EXITSTUB:%.*]]
; CHECK:       next3.exitStub:
; CHECK-NEXT:    ret void
;
