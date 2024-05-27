; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -stop-after=irtranslator -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs -o - %s | FileCheck -enable-var-scope %s

; Test that we don't insert code to pass implicit arguments we know
; the callee does not need.

declare hidden void @extern()

define amdgpu_kernel void @kernel_call_no_workitem_ids() {
  ; CHECK-LABEL: name: kernel_call_no_workitem_ids
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr12, $sgpr13, $sgpr14, $sgpr4_sgpr5, $sgpr6_sgpr7, $sgpr8_sgpr9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_32 = COPY $sgpr14
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr13
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr12
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sgpr_64 = COPY $sgpr8_sgpr9
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sgpr_64 = COPY $sgpr4_sgpr5
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(p4) = COPY $sgpr6_sgpr7
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @extern
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(p4) = COPY [[COPY4]]
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(p4) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(p4) = COPY [[COPY5]](p4)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p4) = G_PTR_ADD [[COPY7]], [[C]](s64)
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(s64) = COPY [[COPY3]]
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY [[COPY2]]
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY [[COPY]]
  ; CHECK-NEXT:   [[DEF1:%[0-9]+]]:_(s32) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:_(<4 x s32>) = COPY $private_rsrc_reg
  ; CHECK-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY12]](<4 x s32>)
  ; CHECK-NEXT:   $sgpr4_sgpr5 = COPY [[COPY6]](p4)
  ; CHECK-NEXT:   $sgpr6_sgpr7 = COPY [[DEF]](p4)
  ; CHECK-NEXT:   $sgpr8_sgpr9 = COPY [[PTR_ADD]](p4)
  ; CHECK-NEXT:   $sgpr10_sgpr11 = COPY [[COPY8]](s64)
  ; CHECK-NEXT:   $sgpr12 = COPY [[COPY9]](s32)
  ; CHECK-NEXT:   $sgpr13 = COPY [[COPY10]](s32)
  ; CHECK-NEXT:   $sgpr14 = COPY [[COPY11]](s32)
  ; CHECK-NEXT:   $sgpr15 = COPY [[DEF1]](s32)
  ; CHECK-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @extern, csr_amdgpu, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr4_sgpr5, implicit $sgpr6_sgpr7, implicit $sgpr8_sgpr9, implicit $sgpr10_sgpr11, implicit $sgpr12, implicit $sgpr13, implicit $sgpr14, implicit $sgpr15
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $scc
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @extern() "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z"
  ret void
}

define amdgpu_kernel void @kernel_call_no_workgroup_ids() {
  ; CHECK-LABEL: name: kernel_call_no_workgroup_ids
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $sgpr4_sgpr5, $sgpr6_sgpr7, $sgpr8_sgpr9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sgpr_64 = COPY $sgpr8_sgpr9
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sgpr_64 = COPY $sgpr4_sgpr5
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(p4) = COPY $sgpr6_sgpr7
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @extern
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(p4) = COPY [[COPY4]]
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(p4) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(p4) = COPY [[COPY5]](p4)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p4) = G_PTR_ADD [[COPY7]], [[C]](s64)
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(s64) = COPY [[COPY3]]
  ; CHECK-NEXT:   [[DEF1:%[0-9]+]]:_(s32) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY [[COPY2]](s32)
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY [[COPY1]](s32)
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 10
  ; CHECK-NEXT:   [[SHL:%[0-9]+]]:_(s32) = G_SHL [[COPY10]], [[C1]](s32)
  ; CHECK-NEXT:   [[OR:%[0-9]+]]:_(s32) = G_OR [[COPY9]], [[SHL]]
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY [[COPY]](s32)
  ; CHECK-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 20
  ; CHECK-NEXT:   [[SHL1:%[0-9]+]]:_(s32) = G_SHL [[COPY11]], [[C2]](s32)
  ; CHECK-NEXT:   [[OR1:%[0-9]+]]:_(s32) = G_OR [[OR]], [[SHL1]]
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:_(<4 x s32>) = COPY $private_rsrc_reg
  ; CHECK-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY12]](<4 x s32>)
  ; CHECK-NEXT:   $sgpr4_sgpr5 = COPY [[COPY6]](p4)
  ; CHECK-NEXT:   $sgpr6_sgpr7 = COPY [[DEF]](p4)
  ; CHECK-NEXT:   $sgpr8_sgpr9 = COPY [[PTR_ADD]](p4)
  ; CHECK-NEXT:   $sgpr10_sgpr11 = COPY [[COPY8]](s64)
  ; CHECK-NEXT:   $sgpr15 = COPY [[DEF1]](s32)
  ; CHECK-NEXT:   $vgpr31 = COPY [[OR1]](s32)
  ; CHECK-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @extern, csr_amdgpu, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr4_sgpr5, implicit $sgpr6_sgpr7, implicit $sgpr8_sgpr9, implicit $sgpr10_sgpr11, implicit $sgpr15, implicit $vgpr31
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $scc
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @extern() "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z"
  ret void
}

define amdgpu_kernel void @kernel_call_no_other_sgprs() {
  ; CHECK-LABEL: name: kernel_call_no_other_sgprs
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $sgpr6_sgpr7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p4) = COPY $sgpr6_sgpr7
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @extern
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(p4) = COPY [[COPY3]](p4)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p4) = G_PTR_ADD [[COPY4]], [[C]](s64)
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(s32) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY [[COPY2]](s32)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY [[COPY1]](s32)
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 10
  ; CHECK-NEXT:   [[SHL:%[0-9]+]]:_(s32) = G_SHL [[COPY6]], [[C1]](s32)
  ; CHECK-NEXT:   [[OR:%[0-9]+]]:_(s32) = G_OR [[COPY5]], [[SHL]]
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY [[COPY]](s32)
  ; CHECK-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 20
  ; CHECK-NEXT:   [[SHL1:%[0-9]+]]:_(s32) = G_SHL [[COPY7]], [[C2]](s32)
  ; CHECK-NEXT:   [[OR1:%[0-9]+]]:_(s32) = G_OR [[OR]], [[SHL1]]
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(<4 x s32>) = COPY $private_rsrc_reg
  ; CHECK-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY8]](<4 x s32>)
  ; CHECK-NEXT:   $sgpr8_sgpr9 = COPY [[PTR_ADD]](p4)
  ; CHECK-NEXT:   $sgpr15 = COPY [[DEF]](s32)
  ; CHECK-NEXT:   $vgpr31 = COPY [[OR1]](s32)
  ; CHECK-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @extern, csr_amdgpu, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr8_sgpr9, implicit $sgpr15, implicit $vgpr31
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $scc
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @extern() "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z"
  ret void
}

define void @func_call_no_workitem_ids() {
  ; CHECK-LABEL: name: func_call_no_workitem_ids
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr12, $sgpr13, $sgpr14, $sgpr15, $sgpr4_sgpr5, $sgpr6_sgpr7, $sgpr8_sgpr9, $sgpr10_sgpr11
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_32 = COPY $sgpr15
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr14
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr13
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sgpr_32 = COPY $sgpr12
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sgpr_64 = COPY $sgpr10_sgpr11
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:sgpr_64 = COPY $sgpr8_sgpr9
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr6_sgpr7
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:sgpr_64 = COPY $sgpr4_sgpr5
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @extern
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(p4) = COPY [[COPY7]]
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:_(p4) = COPY [[COPY6]](p4)
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:_(p4) = COPY [[COPY5]]
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:_(s64) = COPY [[COPY4]]
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY [[COPY3]]
  ; CHECK-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY [[COPY2]]
  ; CHECK-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY [[COPY]]
  ; CHECK-NEXT:   [[COPY16:%[0-9]+]]:_(<4 x s32>) = COPY $sgpr0_sgpr1_sgpr2_sgpr3
  ; CHECK-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY16]](<4 x s32>)
  ; CHECK-NEXT:   $sgpr4_sgpr5 = COPY [[COPY8]](p4)
  ; CHECK-NEXT:   $sgpr6_sgpr7 = COPY [[COPY9]](p4)
  ; CHECK-NEXT:   $sgpr8_sgpr9 = COPY [[COPY10]](p4)
  ; CHECK-NEXT:   $sgpr10_sgpr11 = COPY [[COPY11]](s64)
  ; CHECK-NEXT:   $sgpr12 = COPY [[COPY12]](s32)
  ; CHECK-NEXT:   $sgpr13 = COPY [[COPY13]](s32)
  ; CHECK-NEXT:   $sgpr14 = COPY [[COPY14]](s32)
  ; CHECK-NEXT:   $sgpr15 = COPY [[COPY15]](s32)
  ; CHECK-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @extern, csr_amdgpu, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr4_sgpr5, implicit $sgpr6_sgpr7, implicit $sgpr8_sgpr9, implicit $sgpr10_sgpr11, implicit $sgpr12, implicit $sgpr13, implicit $sgpr14, implicit $sgpr15
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $scc
  ; CHECK-NEXT:   SI_RETURN
  call void @extern() "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z"
  ret void
}

define void @func_call_no_workgroup_ids() {
  ; CHECK-LABEL: name: func_call_no_workgroup_ids
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr15, $vgpr31, $sgpr4_sgpr5, $sgpr6_sgpr7, $sgpr8_sgpr9, $sgpr10_sgpr11
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr31
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr15
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sgpr_64 = COPY $sgpr10_sgpr11
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sgpr_64 = COPY $sgpr8_sgpr9
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr6_sgpr7
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:sgpr_64 = COPY $sgpr4_sgpr5
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @extern
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(p4) = COPY [[COPY5]]
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(p4) = COPY [[COPY4]](p4)
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(p4) = COPY [[COPY3]]
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:_(s64) = COPY [[COPY2]]
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY [[COPY]](s32)
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:_(<4 x s32>) = COPY $sgpr0_sgpr1_sgpr2_sgpr3
  ; CHECK-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY12]](<4 x s32>)
  ; CHECK-NEXT:   $sgpr4_sgpr5 = COPY [[COPY6]](p4)
  ; CHECK-NEXT:   $sgpr6_sgpr7 = COPY [[COPY7]](p4)
  ; CHECK-NEXT:   $sgpr8_sgpr9 = COPY [[COPY8]](p4)
  ; CHECK-NEXT:   $sgpr10_sgpr11 = COPY [[COPY9]](s64)
  ; CHECK-NEXT:   $sgpr15 = COPY [[COPY10]](s32)
  ; CHECK-NEXT:   $vgpr31 = COPY [[COPY11]](s32)
  ; CHECK-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @extern, csr_amdgpu, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr4_sgpr5, implicit $sgpr6_sgpr7, implicit $sgpr8_sgpr9, implicit $sgpr10_sgpr11, implicit $sgpr15, implicit $vgpr31
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $scc
  ; CHECK-NEXT:   SI_RETURN
  call void @extern() "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z"
  ret void
}

define void @func_call_no_other_sgprs() {
  ; CHECK-LABEL: name: func_call_no_other_sgprs
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr15, $vgpr31, $sgpr8_sgpr9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr31
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr15
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sgpr_64 = COPY $sgpr8_sgpr9
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @extern
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p4) = COPY [[COPY2]]
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY [[COPY]](s32)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(<4 x s32>) = COPY $sgpr0_sgpr1_sgpr2_sgpr3
  ; CHECK-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY6]](<4 x s32>)
  ; CHECK-NEXT:   $sgpr8_sgpr9 = COPY [[COPY3]](p4)
  ; CHECK-NEXT:   $sgpr15 = COPY [[COPY4]](s32)
  ; CHECK-NEXT:   $vgpr31 = COPY [[COPY5]](s32)
  ; CHECK-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @extern, csr_amdgpu, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr8_sgpr9, implicit $sgpr15, implicit $vgpr31
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $scc
  ; CHECK-NEXT:   SI_RETURN
  call void @extern() "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z"
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdgpu_code_object_version", i32 500}
