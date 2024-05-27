; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+f -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32f | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+f -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64f | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+zfinx -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32 | FileCheck --check-prefixes=CHECKZFINX,RV32ZFINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zfinx -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64 | FileCheck --check-prefixes=CHECKZFINX,RV64ZFINX %s

; TODO: constant pool shouldn't be necessary for RV64IF.
define float @float_imm() nounwind {
; CHECK-LABEL: float_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECK-NEXT:    flw fa0, %lo(.LCPI0_0)(a0)
; CHECK-NEXT:    ret
;
; RV32ZFINX-LABEL: float_imm:
; RV32ZFINX:       # %bb.0:
; RV32ZFINX-NEXT:    lui a0, 263313
; RV32ZFINX-NEXT:    addi a0, a0, -37
; RV32ZFINX-NEXT:    ret
;
; RV64ZFINX-LABEL: float_imm:
; RV64ZFINX:       # %bb.0:
; RV64ZFINX-NEXT:    lui a0, %hi(.LCPI0_0)
; RV64ZFINX-NEXT:    lw a0, %lo(.LCPI0_0)(a0)
; RV64ZFINX-NEXT:    ret
  ret float 3.14159274101257324218750
}

define float @float_imm_op(float %a) nounwind {
; CHECK-LABEL: float_imm_op:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 260096
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    fadd.s fa0, fa0, fa5
; CHECK-NEXT:    ret
;
; CHECKZFINX-LABEL: float_imm_op:
; CHECKZFINX:       # %bb.0:
; CHECKZFINX-NEXT:    lui a1, 260096
; CHECKZFINX-NEXT:    fadd.s a0, a0, a1
; CHECKZFINX-NEXT:    ret
  %1 = fadd float %a, 1.0
  ret float %1
}

define float @float_positive_zero(ptr %pf) nounwind {
; CHECK-LABEL: float_positive_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.w.x fa0, zero
; CHECK-NEXT:    ret
;
; CHECKZFINX-LABEL: float_positive_zero:
; CHECKZFINX:       # %bb.0:
; CHECKZFINX-NEXT:    li a0, 0
; CHECKZFINX-NEXT:    ret
  ret float 0.0
}

define float @float_negative_zero(ptr %pf) nounwind {
; CHECK-LABEL: float_negative_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 524288
; CHECK-NEXT:    fmv.w.x fa0, a0
; CHECK-NEXT:    ret
;
; CHECKZFINX-LABEL: float_negative_zero:
; CHECKZFINX:       # %bb.0:
; CHECKZFINX-NEXT:    lui a0, 524288
; CHECKZFINX-NEXT:    ret
  ret float -0.0
}
