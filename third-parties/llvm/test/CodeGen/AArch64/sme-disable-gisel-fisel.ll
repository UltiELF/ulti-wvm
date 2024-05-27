; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -fast-isel=true -global-isel=false -fast-isel-abort=0 -mtriple=aarch64-linux-gnu -mattr=+sme < %s \
; RUN:     | FileCheck %s --check-prefixes=CHECK-COMMON,CHECK-FISEL
; RUN: llc -fast-isel=false -global-isel=true -global-isel-abort=0 -mtriple=aarch64-linux-gnu -mattr=+sme < %s \
; RUN:     | FileCheck %s --check-prefixes=CHECK-COMMON,CHECK-GISEL


declare double @streaming_callee(double) "aarch64_pstate_sm_enabled"
declare double @normal_callee(double)

define double @nonstreaming_caller_streaming_callee(double %x) nounwind noinline optnone {
; CHECK-FISEL-LABEL: nonstreaming_caller_streaming_callee:
; CHECK-FISEL:       // %bb.0: // %entry
; CHECK-FISEL-NEXT:    sub sp, sp, #96
; CHECK-FISEL-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-FISEL-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-FISEL-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-FISEL-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-FISEL-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-FISEL-NEXT:    str d0, [sp] // 8-byte Folded Spill
; CHECK-FISEL-NEXT:    smstart sm
; CHECK-FISEL-NEXT:    ldr d0, [sp] // 8-byte Folded Reload
; CHECK-FISEL-NEXT:    bl streaming_callee
; CHECK-FISEL-NEXT:    str d0, [sp, #8] // 8-byte Folded Spill
; CHECK-FISEL-NEXT:    smstop sm
; CHECK-FISEL-NEXT:    ldr d1, [sp, #8] // 8-byte Folded Reload
; CHECK-FISEL-NEXT:    adrp x8, .LCPI0_0
; CHECK-FISEL-NEXT:    ldr d0, [x8, :lo12:.LCPI0_0]
; CHECK-FISEL-NEXT:    fadd d0, d1, d0
; CHECK-FISEL-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-FISEL-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-FISEL-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-FISEL-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-FISEL-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-FISEL-NEXT:    add sp, sp, #96
; CHECK-FISEL-NEXT:    ret
;
; CHECK-GISEL-LABEL: nonstreaming_caller_streaming_callee:
; CHECK-GISEL:       // %bb.0: // %entry
; CHECK-GISEL-NEXT:    sub sp, sp, #96
; CHECK-GISEL-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-GISEL-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-GISEL-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-GISEL-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-GISEL-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-GISEL-NEXT:    str d0, [sp] // 8-byte Folded Spill
; CHECK-GISEL-NEXT:    smstart sm
; CHECK-GISEL-NEXT:    ldr d0, [sp] // 8-byte Folded Reload
; CHECK-GISEL-NEXT:    bl streaming_callee
; CHECK-GISEL-NEXT:    str d0, [sp, #8] // 8-byte Folded Spill
; CHECK-GISEL-NEXT:    smstop sm
; CHECK-GISEL-NEXT:    ldr d1, [sp, #8] // 8-byte Folded Reload
; CHECK-GISEL-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-GISEL-NEXT:    fmov d0, x8
; CHECK-GISEL-NEXT:    fadd d0, d1, d0
; CHECK-GISEL-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-GISEL-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-GISEL-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-GISEL-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-GISEL-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-GISEL-NEXT:    add sp, sp, #96
; CHECK-GISEL-NEXT:    ret
entry:
  %call = call double @streaming_callee(double %x) "aarch64_pstate_sm_enabled"
  %add = fadd double %call, 4.200000e+01
  ret double %add
}


define double @streaming_caller_nonstreaming_callee(double %x) nounwind noinline optnone "aarch64_pstate_sm_enabled" {
; CHECK-COMMON-LABEL: streaming_caller_nonstreaming_callee:
; CHECK-COMMON:       // %bb.0: // %entry
; CHECK-COMMON-NEXT:    sub sp, sp, #96
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    str d0, [sp] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldr d0, [sp] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    bl normal_callee
; CHECK-COMMON-NEXT:    str d0, [sp, #8] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    ldr d1, [sp, #8] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-COMMON-NEXT:    fmov d0, x8
; CHECK-COMMON-NEXT:    fadd d0, d1, d0
; CHECK-COMMON-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    add sp, sp, #96
; CHECK-COMMON-NEXT:    ret
entry:
  %call = call double @normal_callee(double %x)
  %add = fadd double %call, 4.200000e+01
  ret double %add
}

define double @locally_streaming_caller_normal_callee(double %x) nounwind noinline optnone "aarch64_pstate_sm_body" {
; CHECK-COMMON-LABEL: locally_streaming_caller_normal_callee:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    sub sp, sp, #112
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #64] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #80] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    str x30, [sp, #96] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    str d0, [sp, #24] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    ldr d0, [sp, #24] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    str d0, [sp, #24] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldr d0, [sp, #24] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    bl normal_callee
; CHECK-COMMON-NEXT:    str d0, [sp, #16] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    ldr d1, [sp, #16] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-COMMON-NEXT:    fmov d0, x8
; CHECK-COMMON-NEXT:    fadd d0, d1, d0
; CHECK-COMMON-NEXT:    str d0, [sp, #8] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldr d0, [sp, #8] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldr x30, [sp, #96] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #80] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #64] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    add sp, sp, #112
; CHECK-COMMON-NEXT:    ret
  %call = call double  @normal_callee(double %x);
  %add = fadd double %call, 4.200000e+01
  ret double %add;
}

define double @normal_caller_to_locally_streaming_callee(double %x) nounwind noinline optnone {
; CHECK-FISEL-LABEL: normal_caller_to_locally_streaming_callee:
; CHECK-FISEL:       // %bb.0:
; CHECK-FISEL-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-FISEL-NEXT:    bl locally_streaming_caller_normal_callee
; CHECK-FISEL-NEXT:    adrp x8, .LCPI3_0
; CHECK-FISEL-NEXT:    ldr d1, [x8, :lo12:.LCPI3_0]
; CHECK-FISEL-NEXT:    fadd d0, d0, d1
; CHECK-FISEL-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-FISEL-NEXT:    ret
;
; CHECK-GISEL-LABEL: normal_caller_to_locally_streaming_callee:
; CHECK-GISEL:       // %bb.0:
; CHECK-GISEL-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-GISEL-NEXT:    bl locally_streaming_caller_normal_callee
; CHECK-GISEL-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-GISEL-NEXT:    fmov d1, x8
; CHECK-GISEL-NEXT:    fadd d0, d0, d1
; CHECK-GISEL-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-GISEL-NEXT:    ret
  %call = call double  @locally_streaming_caller_normal_callee(double %x) "aarch64_pstate_sm_body";
  %add = fadd double %call, 4.200000e+01
  ret double %add;
}

; Check attribute in the call itself

define void @locally_streaming_caller_streaming_callee_ptr(ptr %p) nounwind noinline optnone "aarch64_pstate_sm_body" {
; CHECK-COMMON-LABEL: locally_streaming_caller_streaming_callee_ptr:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    str x30, [sp, #64] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    blr x0
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ret
 call void %p() "aarch64_pstate_sm_enabled"
  ret void
}

define void @normal_call_to_streaming_callee_ptr(ptr %p) nounwind noinline optnone {
; CHECK-COMMON-LABEL: normal_call_to_streaming_callee_ptr:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    str x30, [sp, #64] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    blr x0
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ret
  call void %p() "aarch64_pstate_sm_enabled"
  ret void
}

;
; Check ZA state
;

declare double @za_shared_callee(double) "aarch64_pstate_za_shared"

define double  @za_new_caller_to_za_shared_callee(double %x) nounwind noinline optnone "aarch64_pstate_za_new"{
; CHECK-COMMON-LABEL: za_new_caller_to_za_shared_callee:
; CHECK-COMMON:       // %bb.0: // %prelude
; CHECK-COMMON-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    mov x29, sp
; CHECK-COMMON-NEXT:    sub sp, sp, #16
; CHECK-COMMON-NEXT:    rdsvl x8, #1
; CHECK-COMMON-NEXT:    mov x9, sp
; CHECK-COMMON-NEXT:    msub x8, x8, x8, x9
; CHECK-COMMON-NEXT:    mov sp, x8
; CHECK-COMMON-NEXT:    stur x8, [x29, #-16]
; CHECK-COMMON-NEXT:    sturh wzr, [x29, #-6]
; CHECK-COMMON-NEXT:    stur wzr, [x29, #-4]
; CHECK-COMMON-NEXT:    mrs x8, TPIDR2_EL0
; CHECK-COMMON-NEXT:    cbz x8, .LBB6_2
; CHECK-COMMON-NEXT:    b .LBB6_1
; CHECK-COMMON-NEXT:  .LBB6_1: // %save.za
; CHECK-COMMON-NEXT:    bl __arm_tpidr2_save
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, xzr
; CHECK-COMMON-NEXT:    b .LBB6_2
; CHECK-COMMON-NEXT:  .LBB6_2: // %entry
; CHECK-COMMON-NEXT:    smstart za
; CHECK-COMMON-NEXT:    zero {za}
; CHECK-COMMON-NEXT:    bl za_shared_callee
; CHECK-COMMON-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-COMMON-NEXT:    fmov d1, x8
; CHECK-COMMON-NEXT:    fadd d0, d0, d1
; CHECK-COMMON-NEXT:    smstop za
; CHECK-COMMON-NEXT:    mov sp, x29
; CHECK-COMMON-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ret
entry:
  %call = call double @za_shared_callee(double %x)
  %add = fadd double %call, 4.200000e+01
  ret double %add;
}

define double  @za_shared_caller_to_za_none_callee(double %x) nounwind noinline optnone "aarch64_pstate_za_shared"{
; CHECK-COMMON-LABEL: za_shared_caller_to_za_none_callee:
; CHECK-COMMON:       // %bb.0: // %entry
; CHECK-COMMON-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    mov x29, sp
; CHECK-COMMON-NEXT:    sub sp, sp, #16
; CHECK-COMMON-NEXT:    rdsvl x8, #1
; CHECK-COMMON-NEXT:    mov x9, sp
; CHECK-COMMON-NEXT:    msub x9, x8, x8, x9
; CHECK-COMMON-NEXT:    mov sp, x9
; CHECK-COMMON-NEXT:    stur x9, [x29, #-16]
; CHECK-COMMON-NEXT:    sturh wzr, [x29, #-6]
; CHECK-COMMON-NEXT:    stur wzr, [x29, #-4]
; CHECK-COMMON-NEXT:    sturh w8, [x29, #-8]
; CHECK-COMMON-NEXT:    sub x8, x29, #16
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, x8
; CHECK-COMMON-NEXT:    bl normal_callee
; CHECK-COMMON-NEXT:    smstart za
; CHECK-COMMON-NEXT:    mrs x8, TPIDR2_EL0
; CHECK-COMMON-NEXT:    sub x0, x29, #16
; CHECK-COMMON-NEXT:    cbz x8, .LBB7_1
; CHECK-COMMON-NEXT:    b .LBB7_2
; CHECK-COMMON-NEXT:  .LBB7_1: // %entry
; CHECK-COMMON-NEXT:    bl __arm_tpidr2_restore
; CHECK-COMMON-NEXT:    b .LBB7_2
; CHECK-COMMON-NEXT:  .LBB7_2: // %entry
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, xzr
; CHECK-COMMON-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-COMMON-NEXT:    fmov d1, x8
; CHECK-COMMON-NEXT:    fadd d0, d0, d1
; CHECK-COMMON-NEXT:    mov sp, x29
; CHECK-COMMON-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ret
entry:
  %call = call double @normal_callee(double %x)
  %add = fadd double %call, 4.200000e+01
  ret double %add;
}

; Ensure we set up and restore the lazy save correctly for instructions which are lowered to lib calls.
define fp128 @f128_call_za(fp128 %a, fp128 %b) "aarch64_pstate_za_shared" nounwind {
; CHECK-COMMON-LABEL: f128_call_za:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    mov x29, sp
; CHECK-COMMON-NEXT:    sub sp, sp, #16
; CHECK-COMMON-NEXT:    rdsvl x8, #1
; CHECK-COMMON-NEXT:    mov x9, sp
; CHECK-COMMON-NEXT:    msub x9, x8, x8, x9
; CHECK-COMMON-NEXT:    mov sp, x9
; CHECK-COMMON-NEXT:    sub x10, x29, #16
; CHECK-COMMON-NEXT:    stur wzr, [x29, #-4]
; CHECK-COMMON-NEXT:    sturh wzr, [x29, #-6]
; CHECK-COMMON-NEXT:    stur x9, [x29, #-16]
; CHECK-COMMON-NEXT:    sturh w8, [x29, #-8]
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, x10
; CHECK-COMMON-NEXT:    bl __addtf3
; CHECK-COMMON-NEXT:    smstart za
; CHECK-COMMON-NEXT:    mrs x8, TPIDR2_EL0
; CHECK-COMMON-NEXT:    sub x0, x29, #16
; CHECK-COMMON-NEXT:    cbnz x8, .LBB8_2
; CHECK-COMMON-NEXT:  // %bb.1:
; CHECK-COMMON-NEXT:    bl __arm_tpidr2_restore
; CHECK-COMMON-NEXT:  .LBB8_2:
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, xzr
; CHECK-COMMON-NEXT:    mov sp, x29
; CHECK-COMMON-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ret
  %res = fadd fp128 %a, %b
  ret fp128 %res
}


; Ensure we fall back to SelectionDAG isel here so that we temporarily disable streaming mode to lower the fadd (with function calls).
define fp128 @f128_call_sm(fp128 %a, fp128 %b) "aarch64_pstate_sm_enabled" nounwind {
; CHECK-COMMON-LABEL: f128_call_sm:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    sub sp, sp, #112
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #64] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #80] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    str x30, [sp, #96] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    stp q1, q0, [sp] // 32-byte Folded Spill
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldp q1, q0, [sp] // 32-byte Folded Reload
; CHECK-COMMON-NEXT:    bl __addtf3
; CHECK-COMMON-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #80] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #64] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldr x30, [sp, #96] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    add sp, sp, #112
; CHECK-COMMON-NEXT:    ret
  %res = fadd fp128 %a, %b
  ret fp128 %res
}

; As above this should use Selection DAG to make sure the libcall call is lowered correctly.
define double @frem_call_za(double %a, double %b) "aarch64_pstate_za_shared" nounwind {
; CHECK-COMMON-LABEL: frem_call_za:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    mov x29, sp
; CHECK-COMMON-NEXT:    sub sp, sp, #16
; CHECK-COMMON-NEXT:    rdsvl x8, #1
; CHECK-COMMON-NEXT:    mov x9, sp
; CHECK-COMMON-NEXT:    msub x9, x8, x8, x9
; CHECK-COMMON-NEXT:    mov sp, x9
; CHECK-COMMON-NEXT:    sub x10, x29, #16
; CHECK-COMMON-NEXT:    stur wzr, [x29, #-4]
; CHECK-COMMON-NEXT:    sturh wzr, [x29, #-6]
; CHECK-COMMON-NEXT:    stur x9, [x29, #-16]
; CHECK-COMMON-NEXT:    sturh w8, [x29, #-8]
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, x10
; CHECK-COMMON-NEXT:    bl fmod
; CHECK-COMMON-NEXT:    smstart za
; CHECK-COMMON-NEXT:    mrs x8, TPIDR2_EL0
; CHECK-COMMON-NEXT:    sub x0, x29, #16
; CHECK-COMMON-NEXT:    cbnz x8, .LBB10_2
; CHECK-COMMON-NEXT:  // %bb.1:
; CHECK-COMMON-NEXT:    bl __arm_tpidr2_restore
; CHECK-COMMON-NEXT:  .LBB10_2:
; CHECK-COMMON-NEXT:    msr TPIDR2_EL0, xzr
; CHECK-COMMON-NEXT:    mov sp, x29
; CHECK-COMMON-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ret
  %res = frem double %a, %b
  ret double %res
}

; As above this should use Selection DAG to make sure the libcall is lowered correctly.
define float @frem_call_sm(float %a, float %b) "aarch64_pstate_sm_enabled" nounwind {
; CHECK-COMMON-LABEL: frem_call_sm:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    sub sp, sp, #96
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    stp s1, s0, [sp, #8] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:    ldp s1, s0, [sp, #8] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    bl fmodf
; CHECK-COMMON-NEXT:    str s0, [sp, #12] // 4-byte Folded Spill
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldr s0, [sp, #12] // 4-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    add sp, sp, #96
; CHECK-COMMON-NEXT:    ret
  %res = frem float %a, %b
  ret float %res
}

; As above this should use Selection DAG to make sure the libcall is lowered correctly.
define float @frem_call_sm_compat(float %a, float %b) "aarch64_pstate_sm_compatible" nounwind {
; CHECK-COMMON-LABEL: frem_call_sm_compat:
; CHECK-COMMON:       // %bb.0:
; CHECK-COMMON-NEXT:    sub sp, sp, #96
; CHECK-COMMON-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp x30, x19, [sp, #80] // 16-byte Folded Spill
; CHECK-COMMON-NEXT:    stp s0, s1, [sp, #8] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    bl __arm_sme_state
; CHECK-COMMON-NEXT:    ldp s2, s0, [sp, #8] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    and x19, x0, #0x1
; CHECK-COMMON-NEXT:    stp s2, s0, [sp, #8] // 8-byte Folded Spill
; CHECK-COMMON-NEXT:    tbz w19, #0, .LBB12_2
; CHECK-COMMON-NEXT:  // %bb.1:
; CHECK-COMMON-NEXT:    smstop sm
; CHECK-COMMON-NEXT:  .LBB12_2:
; CHECK-COMMON-NEXT:    ldp s0, s1, [sp, #8] // 8-byte Folded Reload
; CHECK-COMMON-NEXT:    bl fmodf
; CHECK-COMMON-NEXT:    str s0, [sp, #12] // 4-byte Folded Spill
; CHECK-COMMON-NEXT:    tbz w19, #0, .LBB12_4
; CHECK-COMMON-NEXT:  // %bb.3:
; CHECK-COMMON-NEXT:    smstart sm
; CHECK-COMMON-NEXT:  .LBB12_4:
; CHECK-COMMON-NEXT:    ldp x30, x19, [sp, #80] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldr s0, [sp, #12] // 4-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-COMMON-NEXT:    add sp, sp, #96
; CHECK-COMMON-NEXT:    ret
  %res = frem float %a, %b
  ret float %res
}
