; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc %s -mtriple=aarch64-none-linux-gnu -aarch64-enable-global-merge -global-merge-on-external -disable-post-ra -o - | FileCheck %s
; RUN: llc %s -mtriple=aarch64-linux-gnuabi -aarch64-enable-global-merge -global-merge-on-external -disable-post-ra -o - | FileCheck %s
; RUN: llc %s -mtriple=aarch64-apple-ios -aarch64-enable-global-merge -global-merge-on-external -disable-post-ra -o - | FileCheck %s --check-prefix=CHECK-APPLE-IOS

@x = dso_local global [100 x i32] zeroinitializer, align 1
@y = dso_local global [100 x i32] zeroinitializer, align 1
@z = internal global i32 1, align 4

define dso_local void @f1(i32 %a1, i32 %a2, i32 %a3) {
; CHECK-LABEL: f1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .L_MergedGlobals+12
; CHECK-NEXT:    add x8, x8, :lo12:.L_MergedGlobals+12
; CHECK-NEXT:    str w0, [x8]
; CHECK-NEXT:    str w1, [x8, #400]
; CHECK-NEXT:    adrp x8, z
; CHECK-NEXT:    str w2, [x8, :lo12:z]
; CHECK-NEXT:    ret
;
; CHECK-APPLE-IOS-LABEL: f1:
; CHECK-APPLE-IOS:       ; %bb.0:
; CHECK-APPLE-IOS-NEXT:  Lloh0:
; CHECK-APPLE-IOS-NEXT:    adrp x8, __MergedGlobals_x@PAGE+12
; CHECK-APPLE-IOS-NEXT:  Lloh1:
; CHECK-APPLE-IOS-NEXT:    add x8, x8, __MergedGlobals_x@PAGEOFF+12
; CHECK-APPLE-IOS-NEXT:    str w0, [x8]
; CHECK-APPLE-IOS-NEXT:    str w1, [x8, #400]
; CHECK-APPLE-IOS-NEXT:    adrp x8, _z@PAGE
; CHECK-APPLE-IOS-NEXT:    str w2, [x8, _z@PAGEOFF]
; CHECK-APPLE-IOS-NEXT:    ret
; CHECK-APPLE-IOS-NEXT:    .loh AdrpAdd Lloh0, Lloh1
  %x3 = getelementptr inbounds [100 x i32], ptr @x, i32 0, i64 3
  %y3 = getelementptr inbounds [100 x i32], ptr @y, i32 0, i64 3
  store i32 %a1, ptr %x3, align 4
  store i32 %a2, ptr %y3, align 4
  store i32 %a3, ptr @z, align 4
  ret void
}

;CHECK-APPLE-IOS: .globl  __MergedGlobals_x
;CHECK-APPLE-IOS: .zerofill __DATA,__common,__MergedGlobals_x,800,2
;CHECK-APPLE-IOS: .set _x, __MergedGlobals_x
;CHECK-APPLE-IOS: .set _y, __MergedGlobals_x+400

;CHECK: .type   .L_MergedGlobals,@object // @_MergedGlobals
;CHECK: .local  .L_MergedGlobals
;CHECK: .comm   .L_MergedGlobals,800,4
;CHECK: globl  x
;CHECK: .set x, .L_MergedGlobals
;CHECK: globl  y
;CHECK: .set y, .L_MergedGlobals+400
;CHECK-NOT: .set z, .L_MergedGlobals
