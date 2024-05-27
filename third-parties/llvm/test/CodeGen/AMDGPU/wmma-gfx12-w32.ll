; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck %s --check-prefix=GFX12

define amdgpu_ps void @test_wmma_f32_16x16x16_f16(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f32.v8f16.v8f16.v8f32(<8 x half> %A, <8 x half> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf16(<8 x i16> %A, <8 x i16> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf16 v[8:15], v[0:3], v[4:7], v[8:15]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16.v8f32.v8i16.v8i16.v8f32(<8 x i16> %A, <8 x i16> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[8:11], v[0:3], v[4:7], v[8:11]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16.v8f16.v8f16(<8 x half> %A, <8 x half> %B, <8 x half> %C, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_bf16_16x16x16_bf16(<8 x i16> %A, <8 x i16> %B, <8 x i16> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_bf16_16x16x16_bf16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_bf16_16x16x16_bf16 v[8:11], v[0:3], v[4:7], v[8:11]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16.v8i16.v8i16.v8i16.v8i16(<8 x i16> %A, <8 x i16> %B, <8 x i16> %C, i1 0)
  store <8 x i16> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_iu8(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu8 v[4:11], v[0:1], v[2:3], v[4:11]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v8i32.v2i32.v2i32.v8i32(i1 0, <2 x i32> %A, i1 0, <2 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_iu4(i32 %A, i32 %B, <8 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu4:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu4 v[2:9], v0, v1, v[2:9]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[10:11], v[6:9], off offset:16
; GFX12-NEXT:    global_store_b128 v[10:11], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v8i32.i32.i32.v8i32(i1 0, i32 %A, i1 0, i32 %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_fp8_fp8(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_fp8_fp8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_fp8_fp8 v[4:11], v[0:1], v[2:3], v[4:11]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.fp8.v8f32.v2i32.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf8_fp8(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf8_fp8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf8_fp8 v[4:11], v[0:1], v[2:3], v[4:11]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.fp8.v8f32.v2i32.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_fp8_bf8(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_fp8_bf8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_fp8_bf8 v[4:11], v[0:1], v[2:3], v[4:11]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.bf8.v8f32.v2i32.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf8_bf8(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf8_bf8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf8_bf8 v[4:11], v[0:1], v[2:3], v[4:11]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.bf8.v8f32.v2i32.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x32_iu4(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x32_iu4:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x32_iu4 v[4:11], v[0:1], v[2:3], v[4:11]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v8i32.v2i32.v2i32.v8i32(i1 0, <2 x i32> %A, i1 0, <2 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out
  ret void
}


define amdgpu_ps void @test_swmmac_f32_16x16x32_f16(<8 x half> %A, <16 x half> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_f16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[12:19], v[0:3], v[4:11], v20
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[21:22], v[16:19], off offset:16
; GFX12-NEXT:    global_store_b128 v[21:22], v[12:15], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f32.v8f16.v16f16.v8f32.i16(<8 x half> %A, <16 x half> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf16(<8 x i16> %A, <16 x i16> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[12:19], v[0:3], v[4:11], v20
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[21:22], v[16:19], off offset:16
; GFX12-NEXT:    global_store_b128 v[21:22], v[12:15], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v8f32.v8i16.v16i16.v8f32.i16(<8 x i16> %A, <16 x i16> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f16_16x16x32_f16(<8 x half> %A, <16 x half> %B, <8 x half> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f16_16x16x32_f16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[12:15], v[0:3], v[4:11], v16
; GFX12-NEXT:    global_store_b128 v[17:18], v[12:15], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v8f16.v16f16.v8f16.i16(<8 x half> %A, <16 x half> %B, <8 x half> %C, i16 %Index)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_bf16_16x16x32_bf16(<8 x i16> %A, <16 x i16> %B, <8 x i16> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_bf16_16x16x32_bf16:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[12:15], v[0:3], v[4:11], v16
; GFX12-NEXT:    global_store_b128 v[17:18], v[12:15], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v8i16.v8i16.v16i16.v8i16.i16(<8 x i16> %A, <16 x i16> %B, <8 x i16> %C, i16 %Index)
  store <8 x i16> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu8(<2 x i32> %A, <4 x i32> %B, <8 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[6:13], v[0:1], v[2:5], v14
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[10:13], off offset:16
; GFX12-NEXT:    global_store_b128 v[15:16], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v8i32.v2i32.v4i32.v8i32.i16(i1 0, <2 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i16 %Index, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu4(i32 %A, <2 x i32> %B, <8 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu4:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[3:10], v0, v[1:2], v11
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[7:10], off offset:16
; GFX12-NEXT:    global_store_b128 v[12:13], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v8i32.i32.v2i32.v8i32.i16(i1 0, i32 %A, i1 0, <2 x i32> %B, <8 x i32> %C, i16 %Index, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x64_iu4(<2 x i32> %A, <4 x i32> %B, <8 x i32> %C, i32 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x64_iu4:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x64_iu4 v[6:13], v[0:1], v[2:5], v14
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[10:13], off offset:16
; GFX12-NEXT:    global_store_b128 v[15:16], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v8i32.v2i32.v4i32.v8i32.i32(i1 0, <2 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i32 %Index, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_fp8_fp8(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_fp8_fp8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[6:13], v[0:1], v[2:5], v14
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[10:13], off offset:16
; GFX12-NEXT:    global_store_b128 v[15:16], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_fp8_bf8(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_fp8_bf8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[6:13], v[0:1], v[2:5], v14
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[10:13], off offset:16
; GFX12-NEXT:    global_store_b128 v[15:16], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf8_fp8(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf8_fp8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[6:13], v[0:1], v[2:5], v14
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[10:13], off offset:16
; GFX12-NEXT:    global_store_b128 v[15:16], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf8_bf8(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf8_bf8:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[6:13], v[0:1], v[2:5], v14
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[10:13], off offset:16
; GFX12-NEXT:    global_store_b128 v[15:16], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f32.v8f16.v8f16.v8f32(<8 x half>, <8 x half>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16.v8f32.v8i16.v8i16.v8f32(<8 x i16>, <8 x i16>, <8 x float>)
declare <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16.v8f16.v8f16(<8 x half>, <8 x half>, <8 x half>, i1 immarg)
declare <8 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16.v8i16.v8i16.v8i16.v8i16(<8 x i16>, <8 x i16>, <8 x i16>, i1 immarg)
declare <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v8i32.v2i32.v2i32.v8i32(i1 immarg, <2 x i32>, i1 immarg, <2 x i32>, <8 x i32>, i1 immarg)
declare <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v8i32.i32.i32.v8i32(i1 immarg, i32, i1 immarg, i32, <8 x i32>, i1 immarg)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.fp8.v8f32.v2i32.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.bf8.v8f32.v2i32.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.fp8.v8f32.v2i32.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.bf8.v8f32.v2i32.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v8i32.v2i32.v2i32.v8i32(i1 immarg, <2 x i32>, i1 immarg, <2 x i32>, <8 x i32>, i1 immarg)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f32.v8f16.v16f16.v8f32.i16(<8 x half>, <16 x half>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v8f32.v8i16.v16i16.v8f32.i16(<8 x i16>, <16 x i16>, <8 x float>, i16)
declare <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v8f16.v16f16.v8f16.i16(<8 x half>, <16 x half>, <8 x half>, i16)
declare <8 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v8i16.v8i16.v16i16.v8i16.i16(<8 x i16>, <16 x i16>, <8 x i16>, i16)
declare <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v8i32.v2i32.v4i32.v8i32.i16(i1 immarg, <2 x i32>, i1 immarg, <4 x i32>, <8 x i32>, i16 %Index, i1 immarg)
declare <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v8i32.i32.v2i32.v8i32.i16(i1 immarg, i32, i1 immarg, <2 x i32>, <8 x i32>, i16 %Index, i1 immarg)
declare <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v8i32.v2i32.v4i32.v8i32.i32(i1 immarg, <2 x i32>, i1 immarg, <4 x i32>, <8 x i32>, i32 %Index, i1 immarg)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
