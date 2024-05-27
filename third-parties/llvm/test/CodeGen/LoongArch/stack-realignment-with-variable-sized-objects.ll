; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 --verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 --verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=LA64

declare void @callee(ptr, ptr)

define void @caller(i32 %n) {
; LA32-LABEL: caller:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -64
; LA32-NEXT:    .cfi_def_cfa_offset 64
; LA32-NEXT:    st.w $ra, $sp, 60 # 4-byte Folded Spill
; LA32-NEXT:    st.w $fp, $sp, 56 # 4-byte Folded Spill
; LA32-NEXT:    st.w $s8, $sp, 52 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    .cfi_offset 22, -8
; LA32-NEXT:    .cfi_offset 31, -12
; LA32-NEXT:    addi.w $fp, $sp, 64
; LA32-NEXT:    .cfi_def_cfa 22, 0
; LA32-NEXT:    bstrins.w $sp, $zero, 5, 0
; LA32-NEXT:    move $s8, $sp
; LA32-NEXT:    addi.w $a0, $a0, 15
; LA32-NEXT:    bstrins.w $a0, $zero, 3, 0
; LA32-NEXT:    sub.w $a0, $sp, $a0
; LA32-NEXT:    move $sp, $a0
; LA32-NEXT:    addi.w $a1, $s8, 0
; LA32-NEXT:    bl %plt(callee)
; LA32-NEXT:    addi.w $sp, $fp, -64
; LA32-NEXT:    ld.w $s8, $sp, 52 # 4-byte Folded Reload
; LA32-NEXT:    ld.w $fp, $sp, 56 # 4-byte Folded Reload
; LA32-NEXT:    ld.w $ra, $sp, 60 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 64
; LA32-NEXT:    ret
;
; LA64-LABEL: caller:
; LA64:       # %bb.0:
; LA64-NEXT:    addi.d $sp, $sp, -64
; LA64-NEXT:    .cfi_def_cfa_offset 64
; LA64-NEXT:    st.d $ra, $sp, 56 # 8-byte Folded Spill
; LA64-NEXT:    st.d $fp, $sp, 48 # 8-byte Folded Spill
; LA64-NEXT:    st.d $s8, $sp, 40 # 8-byte Folded Spill
; LA64-NEXT:    .cfi_offset 1, -8
; LA64-NEXT:    .cfi_offset 22, -16
; LA64-NEXT:    .cfi_offset 31, -24
; LA64-NEXT:    addi.d $fp, $sp, 64
; LA64-NEXT:    .cfi_def_cfa 22, 0
; LA64-NEXT:    bstrins.d $sp, $zero, 5, 0
; LA64-NEXT:    move $s8, $sp
; LA64-NEXT:    bstrpick.d $a0, $a0, 31, 0
; LA64-NEXT:    addi.d $a0, $a0, 15
; LA64-NEXT:    bstrpick.d $a0, $a0, 32, 4
; LA64-NEXT:    slli.d $a0, $a0, 4
; LA64-NEXT:    sub.d $a0, $sp, $a0
; LA64-NEXT:    move $sp, $a0
; LA64-NEXT:    addi.d $a1, $s8, 0
; LA64-NEXT:    bl %plt(callee)
; LA64-NEXT:    addi.d $sp, $fp, -64
; LA64-NEXT:    ld.d $s8, $sp, 40 # 8-byte Folded Reload
; LA64-NEXT:    ld.d $fp, $sp, 48 # 8-byte Folded Reload
; LA64-NEXT:    ld.d $ra, $sp, 56 # 8-byte Folded Reload
; LA64-NEXT:    addi.d $sp, $sp, 64
; LA64-NEXT:    ret
  %1 = alloca i8, i32 %n
  %2 = alloca i32, align 64
  call void @callee(ptr %1, ptr %2)
  ret void
}
