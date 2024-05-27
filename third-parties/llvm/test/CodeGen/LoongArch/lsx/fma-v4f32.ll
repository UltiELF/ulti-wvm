; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx --fp-contract=fast < %s \
; RUN:   | FileCheck %s --check-prefix=CONTRACT-FAST
; RUN: llc --mtriple=loongarch64 --mattr=+lsx --fp-contract=on < %s \
; RUN:   | FileCheck %s --check-prefix=CONTRACT-ON
; RUN: llc --mtriple=loongarch64 --mattr=+lsx --fp-contract=off < %s \
; RUN:   | FileCheck %s --check-prefix=CONTRACT-OFF

define void @vfmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfadd.s $vr0, $vr0, $vr1
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfadd.s $vr0, $vr0, $vr1
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul<4 x float> %v0, %v1
  %add = fadd<4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

define void @vfmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul<4 x float> %v0, %v1
  %sub = fsub<4 x float> %mul, %v2
  store <4 x float> %sub, ptr %res
  ret void
}

define void @vfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfadd.s $vr0, $vr0, $vr1
; CONTRACT-ON-NEXT:    vbitrevi.w $vr0, $vr0, 31
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfadd.s $vr0, $vr0, $vr1
; CONTRACT-OFF-NEXT:    vbitrevi.w $vr0, $vr0, 31
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul<4 x float> %v0, %v1
  %add = fadd<4 x float> %mul, %v2
  %negadd = fneg<4 x float> %add
  store <4 x float> %negadd, ptr %res
  ret void
}

define void @vfnmadd_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfnmadd_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfnmadd_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vbitrevi.w $vr1, $vr1, 31
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfnmadd_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vbitrevi.w $vr1, $vr1, 31
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg nsz<4 x float> %v0
  %negv2 = fneg nsz<4 x float> %v2
  %mul = fmul nsz<4 x float> %negv0, %v1
  %add = fadd nsz<4 x float> %mul, %negv2
  store <4 x float> %add, ptr %res
  ret void
}

;; Check that vfnmadd.s is not emitted.
define void @not_vfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_vfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-FAST-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_vfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vbitrevi.w $vr1, $vr1, 31
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_vfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vbitrevi.w $vr1, $vr1, 31
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg<4 x float> %v0
  %negv2 = fneg<4 x float> %v2
  %mul = fmul<4 x float> %negv0, %v1
  %add = fadd<4 x float> %mul, %negv2
  store <4 x float> %add, ptr %res
  ret void
}

define void @vfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-ON-NEXT:    vbitrevi.w $vr0, $vr0, 31
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfsub.s $vr0, $vr0, $vr1
; CONTRACT-OFF-NEXT:    vbitrevi.w $vr0, $vr0, 31
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv2 = fneg<4 x float> %v2
  %mul = fmul<4 x float> %v0, %v1
  %add = fadd<4 x float> %mul, %negv2
  %neg = fneg<4 x float> %add
  store <4 x float> %neg, ptr %res
  ret void
}

define void @vfnmsub_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfnmsub_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfnmsub_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfsub.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfnmsub_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfsub.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg nsz<4 x float> %v0
  %mul = fmul nsz<4 x float> %negv0, %v1
  %add = fadd nsz<4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

;; Check that vfnmsub.s is not emitted.
define void @not_vfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_vfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-FAST-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_vfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a1, 0
; CONTRACT-ON-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vld $vr1, $a3, 0
; CONTRACT-ON-NEXT:    vfsub.s $vr0, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_vfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a1, 0
; CONTRACT-OFF-NEXT:    vfmul.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vld $vr1, $a3, 0
; CONTRACT-OFF-NEXT:    vfsub.s $vr0, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg<4 x float> %v0
  %mul = fmul<4 x float> %negv0, %v1
  %add = fadd<4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

define void @contract_vfmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_vfmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_vfmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_vfmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %add = fadd contract <4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

define void @contract_vfmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_vfmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_vfmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_vfmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %sub = fsub contract <4 x float> %mul, %v2
  store <4 x float> %sub, ptr %res
  ret void
}

define void @contract_vfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_vfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_vfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_vfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %add = fadd contract <4 x float> %mul, %v2
  %negadd = fneg contract <4 x float> %add
  store <4 x float> %negadd, ptr %res
  ret void
}

define void @contract_vfnmadd_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_vfnmadd_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_vfnmadd_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_vfnmadd_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg contract nsz<4 x float> %v0
  %negv2 = fneg contract nsz<4 x float> %v2
  %mul = fmul contract nsz<4 x float> %negv0, %v1
  %add = fadd contract nsz<4 x float> %mul, %negv2
  store <4 x float> %add, ptr %res
  ret void
}

;; Check that vfnmadd.s is not emitted.
define void @not_contract_vfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_contract_vfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-FAST-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_contract_vfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-ON-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_contract_vfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-OFF-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg contract <4 x float> %v0
  %negv2 = fneg contract <4 x float> %v2
  %mul = fmul contract <4 x float> %negv0, %v1
  %add = fadd contract <4 x float> %mul, %negv2
  store <4 x float> %add, ptr %res
  ret void
}

define void @contract_vfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_vfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_vfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_vfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv2 = fneg contract <4 x float> %v2
  %mul = fmul contract <4 x float> %v0, %v1
  %add = fadd contract <4 x float> %mul, %negv2
  %neg = fneg contract <4 x float> %add
  store <4 x float> %neg, ptr %res
  ret void
}

define void @contract_vfnmsub_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_vfnmsub_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_vfnmsub_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_vfnmsub_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg contract nsz<4 x float> %v0
  %mul = fmul contract nsz<4 x float> %negv0, %v1
  %add = fadd contract nsz<4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

;; Check that vfnmsub.s is not emitted.
define void @not_contract_vfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_contract_vfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-FAST-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_contract_vfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-ON-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_contract_vfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vbitrevi.w $vr2, $vr2, 31
; CONTRACT-OFF-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %negv0 = fneg contract <4 x float> %v0
  %mul = fmul contract <4 x float> %negv0, %v1
  %add = fadd contract <4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

define void @vfmadd_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfmadd_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfmadd_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfmadd_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %add = fadd contract <4 x float> %mul, %v2
  store <4 x float> %add, ptr %res
  ret void
}

define void @vfmsub_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfmsub_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfmsub_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfmsub_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %sub = fsub contract <4 x float> %mul, %v2
  store <4 x float> %sub, ptr %res
  ret void
}

define void @vfnmadd_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfnmadd_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfnmadd_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfnmadd_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfnmadd.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %add = fadd contract <4 x float> %mul, %v2
  %negadd = fneg contract <4 x float> %add
  store <4 x float> %negadd, ptr %res
  ret void
}

define void @vfnmsub_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: vfnmsub_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    vld $vr0, $a3, 0
; CONTRACT-FAST-NEXT:    vld $vr1, $a2, 0
; CONTRACT-FAST-NEXT:    vld $vr2, $a1, 0
; CONTRACT-FAST-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-FAST-NEXT:    vst $vr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: vfnmsub_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    vld $vr0, $a3, 0
; CONTRACT-ON-NEXT:    vld $vr1, $a2, 0
; CONTRACT-ON-NEXT:    vld $vr2, $a1, 0
; CONTRACT-ON-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-ON-NEXT:    vst $vr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: vfnmsub_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    vld $vr0, $a3, 0
; CONTRACT-OFF-NEXT:    vld $vr1, $a2, 0
; CONTRACT-OFF-NEXT:    vld $vr2, $a1, 0
; CONTRACT-OFF-NEXT:    vfnmsub.s $vr0, $vr2, $vr1, $vr0
; CONTRACT-OFF-NEXT:    vst $vr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = load <4 x float>, ptr %a2
  %mul = fmul contract <4 x float> %v0, %v1
  %negv2 = fneg contract <4 x float> %v2
  %add = fadd contract <4 x float> %negv2, %mul
  %negadd = fneg contract <4 x float> %add
  store <4 x float> %negadd, ptr %res
  ret void
}
