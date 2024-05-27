; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=riscv32 -global-isel -stop-after=irtranslator \
; RUN:    -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV32I,ILP32 %s
; RUN: llc -mtriple=riscv32 -mattr=+f -target-abi ilp32f \
; RUN:    -global-isel -stop-after=irtranslator -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV32I,ILP32F %s

; This file contains tests that should have identical output for the ilp32,
; and ilp32f.

; Check that on RV32 ilp32[f], double is passed in a pair of registers. Unlike
; the convention for varargs, this need not be an aligned pair.

define i32 @callee_double_in_regs(i32 %a, double %b) nounwind {
  ; RV32I-LABEL: name: callee_double_in_regs
  ; RV32I: bb.1 (%ir-block.0):
  ; RV32I-NEXT:   liveins: $x10, $x11, $x12
  ; RV32I-NEXT: {{  $}}
  ; RV32I-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $x10
  ; RV32I-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $x11
  ; RV32I-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $x12
  ; RV32I-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; RV32I-NEXT:   [[FPTOSI:%[0-9]+]]:_(s32) = G_FPTOSI [[MV]](s64)
  ; RV32I-NEXT:   [[ADD:%[0-9]+]]:_(s32) = G_ADD [[COPY]], [[FPTOSI]]
  ; RV32I-NEXT:   $x10 = COPY [[ADD]](s32)
  ; RV32I-NEXT:   PseudoRET implicit $x10
  %b_fptosi = fptosi double %b to i32
  %1 = add i32 %a, %b_fptosi
  ret i32 %1
}

define i32 @caller_double_in_regs() nounwind {
  ; ILP32-LABEL: name: caller_double_in_regs
  ; ILP32: bb.1 (%ir-block.0):
  ; ILP32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; ILP32-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_FCONSTANT double 2.000000e+00
  ; ILP32-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; ILP32-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[C1]](s64)
  ; ILP32-NEXT:   $x10 = COPY [[C]](s32)
  ; ILP32-NEXT:   $x11 = COPY [[UV]](s32)
  ; ILP32-NEXT:   $x12 = COPY [[UV1]](s32)
  ; ILP32-NEXT:   PseudoCALL target-flags(riscv-call) @callee_double_in_regs, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit-def $x10
  ; ILP32-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; ILP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $x10
  ; ILP32-NEXT:   $x10 = COPY [[COPY]](s32)
  ; ILP32-NEXT:   PseudoRET implicit $x10
  ;
  ; ILP32F-LABEL: name: caller_double_in_regs
  ; ILP32F: bb.1 (%ir-block.0):
  ; ILP32F-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; ILP32F-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_FCONSTANT double 2.000000e+00
  ; ILP32F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; ILP32F-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[C1]](s64)
  ; ILP32F-NEXT:   $x10 = COPY [[C]](s32)
  ; ILP32F-NEXT:   $x11 = COPY [[UV]](s32)
  ; ILP32F-NEXT:   $x12 = COPY [[UV1]](s32)
  ; ILP32F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_double_in_regs, csr_ilp32f_lp64f, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit-def $x10
  ; ILP32F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; ILP32F-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $x10
  ; ILP32F-NEXT:   $x10 = COPY [[COPY]](s32)
  ; ILP32F-NEXT:   PseudoRET implicit $x10
  %1 = call i32 @callee_double_in_regs(i32 1, double 2.0)
  ret i32 %1
}

define double @callee_small_scalar_ret() nounwind {
  ; RV32I-LABEL: name: callee_small_scalar_ret
  ; RV32I: bb.1 (%ir-block.0):
  ; RV32I-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 1.000000e+00
  ; RV32I-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[C]](s64)
  ; RV32I-NEXT:   $x10 = COPY [[UV]](s32)
  ; RV32I-NEXT:   $x11 = COPY [[UV1]](s32)
  ; RV32I-NEXT:   PseudoRET implicit $x10, implicit $x11
  ret double 1.0
}

define i64 @caller_small_scalar_ret() nounwind {
  ; ILP32-LABEL: name: caller_small_scalar_ret
  ; ILP32: bb.1 (%ir-block.0):
  ; ILP32-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; ILP32-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_scalar_ret, csr_ilp32_lp64, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; ILP32-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; ILP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $x10
  ; ILP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $x11
  ; ILP32-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; ILP32-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[MV]](s64)
  ; ILP32-NEXT:   $x10 = COPY [[UV]](s32)
  ; ILP32-NEXT:   $x11 = COPY [[UV1]](s32)
  ; ILP32-NEXT:   PseudoRET implicit $x10, implicit $x11
  ;
  ; ILP32F-LABEL: name: caller_small_scalar_ret
  ; ILP32F: bb.1 (%ir-block.0):
  ; ILP32F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; ILP32F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_scalar_ret, csr_ilp32f_lp64f, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; ILP32F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; ILP32F-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $x10
  ; ILP32F-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $x11
  ; ILP32F-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; ILP32F-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[MV]](s64)
  ; ILP32F-NEXT:   $x10 = COPY [[UV]](s32)
  ; ILP32F-NEXT:   $x11 = COPY [[UV1]](s32)
  ; ILP32F-NEXT:   PseudoRET implicit $x10, implicit $x11
  %1 = call double @callee_small_scalar_ret()
  %2 = bitcast double %1 to i64
  ret i64 %2
}
