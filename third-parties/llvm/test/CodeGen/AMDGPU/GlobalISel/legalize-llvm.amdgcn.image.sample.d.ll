; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 -stop-after=legalizer -o - %s | FileCheck -check-prefix=GFX10 %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1100 -stop-after=legalizer -o - %s | FileCheck -check-prefix=GFX11 %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1200 -stop-after=legalizer -o - %s | FileCheck -check-prefix=GFX12 %s

define amdgpu_ps <4 x float> @sample_d_3d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r) {
  ; GFX10-LABEL: name: sample_d_3d
  ; GFX10: bb.1.main_body:
  ; GFX10-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8
  ; GFX10-NEXT: {{  $}}
  ; GFX10-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX10-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX10-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX10-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX10-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX10-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX10-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX10-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX10-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX10-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX10-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX10-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX10-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX10-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX10-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX10-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX10-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX10-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX10-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX10-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX10-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX10-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX10-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX10-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<9 x s32>) = G_BUILD_VECTOR [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32)
  ; GFX10-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.d.3d), 15, [[BUILD_VECTOR2]](<9 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX10-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX10-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX10-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX10-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX10-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX10-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX11-LABEL: name: sample_d_3d
  ; GFX11: bb.1.main_body:
  ; GFX11-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX11-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX11-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX11-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX11-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX11-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX11-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX11-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX11-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX11-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX11-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX11-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX11-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX11-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX11-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX11-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX11-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX11-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<5 x s32>) = G_BUILD_VECTOR [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32)
  ; GFX11-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.d.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[BUILD_VECTOR2]](<5 x s32>), $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX11-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX11-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX11-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX11-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX11-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX12-LABEL: name: sample_d_3d
  ; GFX12: bb.1.main_body:
  ; GFX12-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8
  ; GFX12-NEXT: {{  $}}
  ; GFX12-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX12-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX12-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX12-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX12-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX12-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX12-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX12-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX12-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX12-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX12-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX12-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX12-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX12-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX12-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX12-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX12-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX12-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX12-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX12-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX12-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX12-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX12-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX12-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<6 x s32>) = G_BUILD_VECTOR [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32)
  ; GFX12-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.d.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[BUILD_VECTOR2]](<6 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX12-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX12-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX12-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX12-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX12-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX12-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.d.3d.v4f32.f32.f32(i32 15, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

define amdgpu_ps <4 x float> @sample_c_d_3d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r) {
  ; GFX10-LABEL: name: sample_c_d_3d
  ; GFX10: bb.1.main_body:
  ; GFX10-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9
  ; GFX10-NEXT: {{  $}}
  ; GFX10-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX10-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX10-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX10-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX10-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX10-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX10-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX10-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX10-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX10-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX10-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX10-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX10-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX10-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX10-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX10-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX10-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX10-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX10-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX10-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX10-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX10-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX10-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX10-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX10-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<10 x s32>) = G_BUILD_VECTOR [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32)
  ; GFX10-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.3d), 15, [[BUILD_VECTOR2]](<10 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX10-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX10-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX10-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX10-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX10-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX10-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX11-LABEL: name: sample_c_d_3d
  ; GFX11: bb.1.main_body:
  ; GFX11-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX11-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX11-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX11-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX11-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX11-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX11-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX11-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX11-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX11-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX11-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX11-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX11-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX11-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX11-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX11-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX11-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX11-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX11-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<6 x s32>) = G_BUILD_VECTOR [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32)
  ; GFX11-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[BUILD_VECTOR2]](<6 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX11-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX11-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX11-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX11-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX11-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX12-LABEL: name: sample_c_d_3d
  ; GFX12: bb.1.main_body:
  ; GFX12-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9
  ; GFX12-NEXT: {{  $}}
  ; GFX12-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX12-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX12-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX12-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX12-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX12-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX12-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX12-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX12-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX12-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX12-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX12-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX12-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX12-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX12-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX12-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX12-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX12-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX12-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX12-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX12-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX12-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX12-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX12-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX12-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<7 x s32>) = G_BUILD_VECTOR [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32)
  ; GFX12-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[BUILD_VECTOR2]](<7 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX12-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX12-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX12-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX12-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX12-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX12-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.3d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

define amdgpu_ps <4 x float> @sample_c_d_cl_3d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r, float %clamp) {
  ; GFX10-LABEL: name: sample_c_d_cl_3d
  ; GFX10: bb.1.main_body:
  ; GFX10-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9, $vgpr10
  ; GFX10-NEXT: {{  $}}
  ; GFX10-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX10-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX10-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX10-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX10-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX10-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX10-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX10-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX10-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX10-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX10-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX10-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX10-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX10-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX10-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX10-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX10-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX10-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX10-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX10-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX10-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX10-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX10-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX10-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX10-NEXT:   [[COPY22:%[0-9]+]]:_(s32) = COPY $vgpr10
  ; GFX10-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<11 x s32>) = G_BUILD_VECTOR [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32), [[COPY22]](s32)
  ; GFX10-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.cl.3d), 15, [[BUILD_VECTOR2]](<11 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX10-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX10-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX10-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX10-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX10-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX10-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX11-LABEL: name: sample_c_d_cl_3d
  ; GFX11: bb.1.main_body:
  ; GFX11-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9, $vgpr10
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX11-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX11-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX11-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX11-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX11-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX11-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX11-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX11-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX11-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX11-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX11-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX11-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX11-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX11-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX11-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX11-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX11-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX11-NEXT:   [[COPY22:%[0-9]+]]:_(s32) = COPY $vgpr10
  ; GFX11-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<7 x s32>) = G_BUILD_VECTOR [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32), [[COPY22]](s32)
  ; GFX11-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.cl.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[BUILD_VECTOR2]](<7 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX11-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX11-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX11-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX11-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX11-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX12-LABEL: name: sample_c_d_cl_3d
  ; GFX12: bb.1.main_body:
  ; GFX12-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9, $vgpr10
  ; GFX12-NEXT: {{  $}}
  ; GFX12-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX12-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX12-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX12-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX12-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX12-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX12-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX12-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX12-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX12-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX12-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX12-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX12-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX12-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX12-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX12-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX12-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX12-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX12-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX12-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX12-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX12-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX12-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX12-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX12-NEXT:   [[COPY22:%[0-9]+]]:_(s32) = COPY $vgpr10
  ; GFX12-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32), [[COPY22]](s32)
  ; GFX12-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.cl.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[BUILD_VECTOR2]](<8 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX12-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX12-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX12-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX12-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX12-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX12-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.cl.3d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

define amdgpu_ps <4 x float> @sample_c_d_cl_o_3d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, i32 %offset, float %zcompare, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r, float %clamp) {
  ; GFX10-LABEL: name: sample_c_d_cl_o_3d
  ; GFX10: bb.1.main_body:
  ; GFX10-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9, $vgpr10, $vgpr11
  ; GFX10-NEXT: {{  $}}
  ; GFX10-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX10-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX10-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX10-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX10-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX10-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX10-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX10-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX10-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX10-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX10-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX10-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX10-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX10-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX10-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX10-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX10-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX10-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX10-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX10-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX10-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX10-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX10-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX10-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX10-NEXT:   [[COPY22:%[0-9]+]]:_(s32) = COPY $vgpr10
  ; GFX10-NEXT:   [[COPY23:%[0-9]+]]:_(s32) = COPY $vgpr11
  ; GFX10-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<12 x s32>) = G_BUILD_VECTOR [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32), [[COPY22]](s32), [[COPY23]](s32)
  ; GFX10-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.cl.o.3d), 15, [[BUILD_VECTOR2]](<12 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX10-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX10-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX10-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX10-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX10-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX10-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX11-LABEL: name: sample_c_d_cl_o_3d
  ; GFX11: bb.1.main_body:
  ; GFX11-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9, $vgpr10, $vgpr11
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX11-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX11-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX11-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX11-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX11-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX11-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX11-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX11-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX11-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX11-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX11-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX11-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX11-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX11-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX11-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX11-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX11-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX11-NEXT:   [[COPY22:%[0-9]+]]:_(s32) = COPY $vgpr10
  ; GFX11-NEXT:   [[COPY23:%[0-9]+]]:_(s32) = COPY $vgpr11
  ; GFX11-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32), [[COPY22]](s32), [[COPY23]](s32)
  ; GFX11-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.cl.o.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[COPY15]](s32), [[BUILD_VECTOR2]](<8 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX11-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX11-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX11-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX11-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX11-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX12-LABEL: name: sample_c_d_cl_o_3d
  ; GFX12: bb.1.main_body:
  ; GFX12-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $sgpr12, $sgpr13, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8, $vgpr9, $vgpr10, $vgpr11
  ; GFX12-NEXT: {{  $}}
  ; GFX12-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX12-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX12-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX12-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX12-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX12-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX12-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX12-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX12-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX12-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX12-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX12-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $sgpr12
  ; GFX12-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $sgpr13
  ; GFX12-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX12-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX12-NEXT:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX12-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX12-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX12-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; GFX12-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; GFX12-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; GFX12-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; GFX12-NEXT:   [[COPY20:%[0-9]+]]:_(s32) = COPY $vgpr8
  ; GFX12-NEXT:   [[COPY21:%[0-9]+]]:_(s32) = COPY $vgpr9
  ; GFX12-NEXT:   [[COPY22:%[0-9]+]]:_(s32) = COPY $vgpr10
  ; GFX12-NEXT:   [[COPY23:%[0-9]+]]:_(s32) = COPY $vgpr11
  ; GFX12-NEXT:   [[BUILD_VECTOR2:%[0-9]+]]:_(<9 x s32>) = G_BUILD_VECTOR [[COPY15]](s32), [[COPY16]](s32), [[COPY17]](s32), [[COPY18]](s32), [[COPY19]](s32), [[COPY20]](s32), [[COPY21]](s32), [[COPY22]](s32), [[COPY23]](s32)
  ; GFX12-NEXT:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.sample.c.d.cl.o.3d), 15, [[COPY12]](s32), [[COPY13]](s32), [[COPY14]](s32), [[BUILD_VECTOR2]](<9 x s32>), $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), [[BUILD_VECTOR1]](<4 x s32>), 0, 0, 0, 0 :: (dereferenceable load (<4 x s32>), addrspace 8)
  ; GFX12-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX12-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; GFX12-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX12-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX12-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX12-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.cl.o.3d.v4f32.f32.f32(i32 15, i32 %offset, float %zcompare, float %dsdh, float %dtdh, float %drdh, float %dsdv, float %dtdv, float %drdv, float %s, float %t, float %r, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

declare <4 x float> @llvm.amdgcn.image.sample.d.3d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32)
declare <4 x float> @llvm.amdgcn.image.sample.c.d.3d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32)
declare <4 x float> @llvm.amdgcn.image.sample.c.d.cl.3d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32)
declare <4 x float> @llvm.amdgcn.image.sample.c.d.cl.o.3d.v4f32.f32.f32(i32, i32, float, float, float, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32)
