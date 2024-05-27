; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=avr | FileCheck %s

define i8 @loadx(i8* %0) {
; CHECK-LABEL: loadx:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov r26, r24
; CHECK-NEXT:    mov r27, r25
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ld r24, X
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ret
  %2 = tail call i8 asm sideeffect "ld $0, ${1:a}", "=r,x"(i8* %0)
  ret i8 %2
}

define i8 @loady(i8* %0) {
; CHECK-LABEL: loady:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    push r28
; CHECK-NEXT:    push r29
; CHECK-NEXT:    mov r28, r24
; CHECK-NEXT:    mov r29, r25
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ld r24, Y
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    pop r29
; CHECK-NEXT:    pop r28
; CHECK-NEXT:    ret
  %2 = tail call i8 asm sideeffect "ld $0, ${1:a}", "=r,y"(i8* %0)
  ret i8 %2
}

define i8 @loadz(i8* %0) {
; CHECK-LABEL: loadz:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov r30, r24
; CHECK-NEXT:    mov r31, r25
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ld r24, Z
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ret
  %2 = tail call i8 asm sideeffect "ld $0, ${1:a}", "=r,z"(i8* %0)
  ret i8 %2
}

define void @storex(i8* %0, i8 %1) {
; CHECK-LABEL: storex:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov r26, r24
; CHECK-NEXT:    mov r27, r25
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    st X, r22
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ret
  tail call void asm sideeffect "st ${0:a}, $1", "x,r"(i8* %0, i8 %1)
  ret void
}

define void @storey(i8* %0, i8 %1) {
; CHECK-LABEL: storey:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    push r28
; CHECK-NEXT:    push r29
; CHECK-NEXT:    mov r28, r24
; CHECK-NEXT:    mov r29, r25
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    st Y, r22
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    pop r29
; CHECK-NEXT:    pop r28
; CHECK-NEXT:    ret
  tail call void asm sideeffect "st ${0:a}, $1", "y,r"(i8* %0, i8 %1)
  ret void
}

define void @storez(i8* %0, i8 %1) {
; CHECK-LABEL: storez:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov r30, r24
; CHECK-NEXT:    mov r31, r25
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    st Z, r22
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ret
  tail call void asm sideeffect "st ${0:a}, $1", "z,r"(i8* %0, i8 %1)
  ret void
}
