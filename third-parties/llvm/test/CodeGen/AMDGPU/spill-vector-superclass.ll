; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx908 -stop-after=greedy,1 -verify-machineinstrs -o - %s | FileCheck -check-prefix=GCN %s
; Convert AV spills into VGPR spills by introducing appropriate copies in between.

define amdgpu_kernel void @test_spill_av_class(<4 x i32> %arg) #0 {
  ; GCN-LABEL: name: test_spill_av_class
  ; GCN: bb.0 (%ir-block.0):
  ; GCN-NEXT:   liveins: $sgpr4_sgpr5
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   renamable $sgpr0_sgpr1_sgpr2_sgpr3 = S_LOAD_DWORDX4_IMM killed renamable $sgpr4_sgpr5, 0, 0 :: (dereferenceable invariant load (s128) from %ir.arg.kernarg.offset1, addrspace 4)
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:areg_128 = COPY killed renamable $sgpr0_sgpr1_sgpr2_sgpr3
  ; GCN-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 1, implicit $exec
  ; GCN-NEXT:   [[V_MOV_B32_e32_1:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 2, implicit $exec
  ; GCN-NEXT:   [[V_MFMA_I32_4X4X4I8_e64_:%[0-9]+]]:areg_128 = V_MFMA_I32_4X4X4I8_e64 [[V_MOV_B32_e32_]], [[V_MOV_B32_e32_1]], [[COPY]], 0, 0, 0, implicit $mode, implicit $exec
  ; GCN-NEXT:   INLINEASM &"; def $0", 1 /* sideeffect attdialect */, 2228234 /* regdef:VGPR_32 */, def undef %24.sub0
  ; GCN-NEXT:   SI_SPILL_V64_SAVE %24, %stack.0, $sgpr32, 0, implicit $exec :: (store (s64) into %stack.0, align 4, addrspace 5)
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vreg_128 = COPY [[V_MFMA_I32_4X4X4I8_e64_]]
  ; GCN-NEXT:   GLOBAL_STORE_DWORDX4 undef %16:vreg_64, [[COPY1]], 0, 0, implicit $exec :: (volatile store (s128) into `ptr addrspace(1) undef`, addrspace 1)
  ; GCN-NEXT:   [[SI_SPILL_V64_RESTORE:%[0-9]+]]:vreg_64 = SI_SPILL_V64_RESTORE %stack.0, $sgpr32, 0, implicit $exec :: (load (s64) from %stack.0, align 4, addrspace 5)
  ; GCN-NEXT:   INLINEASM &"; use $0", 1 /* sideeffect attdialect */, 3538953 /* reguse:VReg_64 */, [[SI_SPILL_V64_RESTORE]]
  ; GCN-NEXT:   S_ENDPGM 0
  %v0 = call i32 asm sideeffect "; def $0", "=v"()
  %tmp = insertelement <2 x i32> undef, i32 %v0, i32 0
  %mai = tail call <4 x i32> @llvm.amdgcn.mfma.i32.4x4x4i8(i32 1, i32 2, <4 x i32> %arg, i32 0, i32 0, i32 0)
  store volatile <4 x i32> %mai, ptr addrspace(1) undef
  call void asm sideeffect "; use $0", "v"(<2 x i32> %tmp);
  ret void
}

declare <4 x i32> @llvm.amdgcn.mfma.i32.4x4x4i8(i32, i32, <4 x i32>, i32, i32, i32)

attributes #0 = { nounwind "amdgpu-num-vgpr"="5" }
