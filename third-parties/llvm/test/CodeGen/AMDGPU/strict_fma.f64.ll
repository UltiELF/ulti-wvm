; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx900 < %s | FileCheck -check-prefix=GCN %s
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 < %s | FileCheck -check-prefix=GFX10 %s
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 < %s | FileCheck -check-prefix=GFX10 %s

define double @v_constained_fma_f64_fpexcept_strict(double %x, double %y, double %z) #0 {
; GCN-LABEL: v_constained_fma_f64_fpexcept_strict:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f64_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %val = call double @llvm.experimental.constrained.fma.f64(double %x, double %y, double %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret double %val
}

define <2 x double> @v_constained_fma_v2f64_fpexcept_strict(<2 x double> %x, <2 x double> %y, <2 x double> %z) #0 {
; GCN-LABEL: v_constained_fma_v2f64_fpexcept_strict:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], v[0:1], v[4:5], v[8:9]
; GCN-NEXT:    v_fma_f64 v[2:3], v[2:3], v[6:7], v[10:11]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v2f64_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], v[0:1], v[4:5], v[8:9]
; GFX10-NEXT:    v_fma_f64 v[2:3], v[2:3], v[6:7], v[10:11]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %val = call <2 x double> @llvm.experimental.constrained.fma.v2f64(<2 x double> %x, <2 x double> %y, <2 x double> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <2 x double> %val
}

define <3 x double> @v_constained_fma_v3f64_fpexcept_strict(<3 x double> %x, <3 x double> %y, <3 x double> %z) #0 {
; GCN-LABEL: v_constained_fma_v3f64_fpexcept_strict:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], v[0:1], v[6:7], v[12:13]
; GCN-NEXT:    v_fma_f64 v[2:3], v[2:3], v[8:9], v[14:15]
; GCN-NEXT:    v_fma_f64 v[4:5], v[4:5], v[10:11], v[16:17]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v3f64_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], v[0:1], v[6:7], v[12:13]
; GFX10-NEXT:    v_fma_f64 v[2:3], v[2:3], v[8:9], v[14:15]
; GFX10-NEXT:    v_fma_f64 v[4:5], v[4:5], v[10:11], v[16:17]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %val = call <3 x double> @llvm.experimental.constrained.fma.v3f64(<3 x double> %x, <3 x double> %y, <3 x double> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <3 x double> %val
}

define <4 x double> @v_constained_fma_v4f64_fpexcept_strict(<4 x double> %x, <4 x double> %y, <4 x double> %z) #0 {
; GCN-LABEL: v_constained_fma_v4f64_fpexcept_strict:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GCN-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GCN-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GCN-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v4f64_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX10-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX10-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX10-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %val = call <4 x double> @llvm.experimental.constrained.fma.v4f64(<4 x double> %x, <4 x double> %y, <4 x double> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <4 x double> %val
}

define double @v_constained_fma_f64_fpexcept_strict_fneg(double %x, double %y, double %z) #0 {
; GCN-LABEL: v_constained_fma_f64_fpexcept_strict_fneg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], -v[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f64_fpexcept_strict_fneg:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], -v[4:5]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.z = fneg double %z
  %val = call double @llvm.experimental.constrained.fma.f64(double %x, double %y, double %neg.z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret double %val
}

define double @v_constained_fma_f64_fpexcept_strict_fneg_fneg(double %x, double %y, double %z) #0 {
; GCN-LABEL: v_constained_fma_f64_fpexcept_strict_fneg_fneg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], -v[0:1], -v[2:3], v[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f64_fpexcept_strict_fneg_fneg:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], -v[0:1], -v[2:3], v[4:5]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = fneg double %x
  %neg.y = fneg double %y
  %val = call double @llvm.experimental.constrained.fma.f64(double %neg.x, double %neg.y, double %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret double %val
}

define double @v_constained_fma_f64_fpexcept_strict_fabs_fabs(double %x, double %y, double %z) #0 {
; GCN-LABEL: v_constained_fma_f64_fpexcept_strict_fabs_fabs:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], |v[0:1]|, |v[2:3]|, v[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f64_fpexcept_strict_fabs_fabs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], |v[0:1]|, |v[2:3]|, v[4:5]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = call double @llvm.fabs.f64(double %x) #0
  %neg.y = call double @llvm.fabs.f64(double %y) #0
  %val = call double @llvm.experimental.constrained.fma.f64(double %neg.x, double %neg.y, double %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret double %val
}

define <2 x double> @v_constained_fma_v2f64_fpexcept_strict_fneg_fneg(<2 x double> %x, <2 x double> %y, <2 x double> %z) #0 {
; GCN-LABEL: v_constained_fma_v2f64_fpexcept_strict_fneg_fneg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f64 v[0:1], -v[0:1], -v[4:5], v[8:9]
; GCN-NEXT:    v_fma_f64 v[2:3], -v[2:3], -v[6:7], v[10:11]
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v2f64_fpexcept_strict_fneg_fneg:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f64 v[0:1], -v[0:1], -v[4:5], v[8:9]
; GFX10-NEXT:    v_fma_f64 v[2:3], -v[2:3], -v[6:7], v[10:11]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = fneg <2 x double> %x
  %neg.y = fneg <2 x double> %y
  %val = call <2 x double> @llvm.experimental.constrained.fma.v2f64(<2 x double> %neg.x, <2 x double> %neg.y, <2 x double> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <2 x double> %val
}

declare double @llvm.fabs.f64(double)
declare double @llvm.experimental.constrained.fma.f64(double, double, double, metadata, metadata)
declare <2 x double> @llvm.experimental.constrained.fma.v2f64(<2 x double>, <2 x double>, <2 x double>, metadata, metadata)
declare <3 x double> @llvm.experimental.constrained.fma.v3f64(<3 x double>, <3 x double>, <3 x double>, metadata, metadata)
declare <4 x double> @llvm.experimental.constrained.fma.v4f64(<4 x double>, <4 x double>, <4 x double>, metadata, metadata)

attributes #0 = { strictfp }
