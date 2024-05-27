; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s
; rdar://7527734

define i32 @test1(i32 %x) nounwind ssp {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    shll $5, %edi
; CHECK-NEXT:    leal 3(%rdi), %eax
; CHECK-NEXT:    retq
  %t0 = shl i32 %x, 5
  %t1 = or i32 %t0, 3
  ret i32 %t1
}

; This test no longer requires or to be converted to 3 addr form because we are
; are able to use a zero extend instead of an 'and' which gives the register
; allocator freedom.
define i64 @test2(i8 %A, i8 %B) nounwind {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    shll $4, %edi
; CHECK-NEXT:    andl $48, %edi
; CHECK-NEXT:    movzbl %sil, %eax
; CHECK-NEXT:    shrl $4, %eax
; CHECK-NEXT:    orl %edi, %eax
; CHECK-NEXT:    retq
  %C = zext i8 %A to i64
  %D = shl i64 %C, 4
  %E = and i64 %D, 48
  %F = zext i8 %B to i64
  %G = lshr i64 %F, 4
  %H = or i64 %G, %E
  ret i64 %H
}

;; Test that OR is only emitted as LEA, not as ADD.

; No reason to emit an add here, should be an or.
define void @test3(i32 %x, ptr %P) nounwind readnone ssp {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    shll $5, %edi
; CHECK-NEXT:    orl $3, %edi
; CHECK-NEXT:    movl %edi, (%rsi)
; CHECK-NEXT:    retq
  %t0 = shl i32 %x, 5
  %t1 = or i32 %t0, 3
  store i32 %t1, ptr %P
  ret void
}

define i32 @test4(i32 %a, i32 %b) nounwind readnone ssp {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $esi killed $esi def $rsi
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    andl $6, %edi
; CHECK-NEXT:    andl $16, %esi
; CHECK-NEXT:    leal (%rsi,%rdi), %eax
; CHECK-NEXT:    retq
  %and = and i32 %a, 6
  %and2 = and i32 %b, 16
  %or = or i32 %and2, %and
  ret i32 %or
}

define void @test5(i32 %a, i32 %b, ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andl $6, %edi
; CHECK-NEXT:    andl $16, %esi
; CHECK-NEXT:    orl %edi, %esi
; CHECK-NEXT:    movl %esi, (%rdx)
; CHECK-NEXT:    retq
  %and = and i32 %a, 6
  %and2 = and i32 %b, 16
  %or = or i32 %and2, %and
  store i32 %or, ptr %P, align 4
  ret void
}

