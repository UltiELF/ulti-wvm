; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=hawaii -stop-after=instruction-select -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

; NOTE: llvm.amdgcn.wwm is deprecated, use llvm.amdgcn.strict.wwm instead.

define amdgpu_ps float @wwm_f32(float %val) {
  ; GCN-LABEL: name: wwm_f32
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vgpr_32 = STRICT_WWM [[COPY]], implicit $exec
  ; GCN-NEXT:   $vgpr0 = COPY [[STRICT_WWM]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call float @llvm.amdgcn.wwm.f32(float %val)
  ret float %ret
}

define amdgpu_ps float @wwm_v2f16(float %arg) {
  ; GCN-LABEL: name: wwm_v2f16
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vgpr_32 = STRICT_WWM [[COPY]], implicit $exec
  ; GCN-NEXT:   $vgpr0 = COPY [[STRICT_WWM]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = bitcast float %arg to <2 x half>
  %ret = call <2 x half> @llvm.amdgcn.wwm.v2f16(<2 x half> %val)
  %bc = bitcast <2 x half> %ret to float
  ret float %bc
}

define amdgpu_ps <2 x float> @wwm_f64(double %val) {
  ; GCN-LABEL: name: wwm_f64
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0, $vgpr1
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GCN-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vreg_64 = STRICT_WWM [[REG_SEQUENCE]], implicit $exec
  ; GCN-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub0
  ; GCN-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub1
  ; GCN-NEXT:   $vgpr0 = COPY [[COPY2]]
  ; GCN-NEXT:   $vgpr1 = COPY [[COPY3]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %ret = call double @llvm.amdgcn.wwm.f64(double %val)
  %bitcast = bitcast double %ret to <2 x float>
  ret <2 x float> %bitcast
}

; TODO
; define amdgpu_ps float @wwm_i1_vcc(float %val) {
;   %vcc = fcmp oeq float %val, 0.0
;   %ret = call i1 @llvm.amdgcn.wwm.i1(i1 %vcc)
;   %select = select i1 %ret, float 1.0, float 0.0
;   ret float %select
; }

define amdgpu_ps <3 x float> @wwm_v3f32(<3 x float> %val) {
  ; GCN-LABEL: name: wwm_v3f32
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GCN-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GCN-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_96 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vreg_96 = STRICT_WWM [[REG_SEQUENCE]], implicit $exec
  ; GCN-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub0
  ; GCN-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub1
  ; GCN-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub2
  ; GCN-NEXT:   $vgpr0 = COPY [[COPY3]]
  ; GCN-NEXT:   $vgpr1 = COPY [[COPY4]]
  ; GCN-NEXT:   $vgpr2 = COPY [[COPY5]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2
  %ret = call <3 x float> @llvm.amdgcn.wwm.v3f32(<3 x float> %val)
  ret <3 x float> %ret
}

define amdgpu_ps float @strict_wwm_f32(float %val) {
  ; GCN-LABEL: name: strict_wwm_f32
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vgpr_32 = STRICT_WWM [[COPY]], implicit $exec
  ; GCN-NEXT:   $vgpr0 = COPY [[STRICT_WWM]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call float @llvm.amdgcn.strict.wwm.f32(float %val)
  ret float %ret
}

define amdgpu_ps float @strict_wwm_v2f16(float %arg) {
  ; GCN-LABEL: name: strict_wwm_v2f16
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vgpr_32 = STRICT_WWM [[COPY]], implicit $exec
  ; GCN-NEXT:   $vgpr0 = COPY [[STRICT_WWM]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = bitcast float %arg to <2 x half>
  %ret = call <2 x half> @llvm.amdgcn.strict.wwm.v2f16(<2 x half> %val)
  %bc = bitcast <2 x half> %ret to float
  ret float %bc
}

define amdgpu_ps <2 x float> @strict_wwm_f64(double %val) {
  ; GCN-LABEL: name: strict_wwm_f64
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0, $vgpr1
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GCN-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vreg_64 = STRICT_WWM [[REG_SEQUENCE]], implicit $exec
  ; GCN-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub0
  ; GCN-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub1
  ; GCN-NEXT:   $vgpr0 = COPY [[COPY2]]
  ; GCN-NEXT:   $vgpr1 = COPY [[COPY3]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %ret = call double @llvm.amdgcn.strict.wwm.f64(double %val)
  %bitcast = bitcast double %ret to <2 x float>
  ret <2 x float> %bitcast
}

; TODO
; define amdgpu_ps float @strict_wwm_i1_vcc(float %val) {
;   %vcc = fcmp oeq float %val, 0.0
;   %ret = call i1 @llvm.amdgcn.strict.wwm.i1(i1 %vcc)
;   %select = select i1 %ret, float 1.0, float 0.0
;   ret float %select
; }

define amdgpu_ps <3 x float> @strict_wwm_v3f32(<3 x float> %val) {
  ; GCN-LABEL: name: strict_wwm_v3f32
  ; GCN: bb.1 (%ir-block.0):
  ; GCN-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GCN-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GCN-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_96 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2
  ; GCN-NEXT:   [[STRICT_WWM:%[0-9]+]]:vreg_96 = STRICT_WWM [[REG_SEQUENCE]], implicit $exec
  ; GCN-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub0
  ; GCN-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub1
  ; GCN-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[STRICT_WWM]].sub2
  ; GCN-NEXT:   $vgpr0 = COPY [[COPY3]]
  ; GCN-NEXT:   $vgpr1 = COPY [[COPY4]]
  ; GCN-NEXT:   $vgpr2 = COPY [[COPY5]]
  ; GCN-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2
  %ret = call <3 x float> @llvm.amdgcn.strict.wwm.v3f32(<3 x float> %val)
  ret <3 x float> %ret
}

declare i1 @llvm.amdgcn.wwm.i1(i1) #0
declare float @llvm.amdgcn.wwm.f32(float) #0
declare <2 x half> @llvm.amdgcn.wwm.v2f16(<2 x half>) #0
declare <3 x float> @llvm.amdgcn.wwm.v3f32(<3 x float>) #0
declare double @llvm.amdgcn.wwm.f64(double) #0
declare i1 @llvm.amdgcn.strict.wwm.i1(i1) #0
declare float @llvm.amdgcn.strict.wwm.f32(float) #0
declare <2 x half> @llvm.amdgcn.strict.wwm.v2f16(<2 x half>) #0
declare <3 x float> @llvm.amdgcn.strict.wwm.v3f32(<3 x float>) #0
declare double @llvm.amdgcn.strict.wwm.f64(double) #0

attributes #0 = { nounwind readnone speculatable }
