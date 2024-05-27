; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+sme --pass-remarks-analysis=sme -o /dev/null < %s 2>&1 | FileCheck %s

declare void @private_za_callee()
declare float @llvm.cos.f32(float)

define void @test_lazy_save_1_callee() nounwind "aarch64_pstate_za_shared" {
; CHECK: remark: <unknown>:0:0: call from 'test_lazy_save_1_callee' to 'private_za_callee' sets up a lazy save for ZA
  call void @private_za_callee()
  ret void
}

define void @test_lazy_save_2_callees() nounwind "aarch64_pstate_za_shared" {
; CHECK: remark: <unknown>:0:0: call from 'test_lazy_save_2_callees' to 'private_za_callee' sets up a lazy save for ZA
  call void @private_za_callee()
; CHECK: remark: <unknown>:0:0: call from 'test_lazy_save_2_callees' to 'private_za_callee' sets up a lazy save for ZA
  call void @private_za_callee()
  ret void
}

define float @test_lazy_save_expanded_intrinsic(float %a) nounwind "aarch64_pstate_za_shared" {
; CHECK: remark: <unknown>:0:0: call from 'test_lazy_save_expanded_intrinsic' to 'cosf' sets up a lazy save for ZA
  %res = call float @llvm.cos.f32(float %a)
  ret float %res
}
