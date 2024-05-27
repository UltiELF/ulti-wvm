; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx --fp-contract=fast < %s \
; RUN:   | FileCheck %s --check-prefix=CONTRACT-FAST
; RUN: llc --mtriple=loongarch64 --mattr=+lasx --fp-contract=on < %s \
; RUN:   | FileCheck %s --check-prefix=CONTRACT-ON
; RUN: llc --mtriple=loongarch64 --mattr=+lasx --fp-contract=off < %s \
; RUN:   | FileCheck %s --check-prefix=CONTRACT-OFF

define void @xvfmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfadd.s $xr0, $xr0, $xr1
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfadd.s $xr0, $xr0, $xr1
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul<8 x float> %v0, %v1
  %add = fadd<8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

define void @xvfmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul<8 x float> %v0, %v1
  %sub = fsub<8 x float> %mul, %v2
  store <8 x float> %sub, ptr %res
  ret void
}

define void @xvfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfadd.s $xr0, $xr0, $xr1
; CONTRACT-ON-NEXT:    xvbitrevi.w $xr0, $xr0, 31
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfadd.s $xr0, $xr0, $xr1
; CONTRACT-OFF-NEXT:    xvbitrevi.w $xr0, $xr0, 31
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul<8 x float> %v0, %v1
  %add = fadd<8 x float> %mul, %v2
  %negadd = fneg<8 x float> %add
  store <8 x float> %negadd, ptr %res
  ret void
}

define void @xvfnmadd_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfnmadd_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfnmadd_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvbitrevi.w $xr1, $xr1, 31
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfnmadd_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvbitrevi.w $xr1, $xr1, 31
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg nsz<8 x float> %v0
  %negv2 = fneg nsz<8 x float> %v2
  %mul = fmul nsz<8 x float> %negv0, %v1
  %add = fadd nsz<8 x float> %mul, %negv2
  store <8 x float> %add, ptr %res
  ret void
}

;; Check that fnmadd.s is not emitted.
define void @not_xvfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_xvfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-FAST-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_xvfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvbitrevi.w $xr1, $xr1, 31
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_xvfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvbitrevi.w $xr1, $xr1, 31
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg<8 x float> %v0
  %negv2 = fneg<8 x float> %v2
  %mul = fmul<8 x float> %negv0, %v1
  %add = fadd<8 x float> %mul, %negv2
  store <8 x float> %add, ptr %res
  ret void
}

define void @xvfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-ON-NEXT:    xvbitrevi.w $xr0, $xr0, 31
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfsub.s $xr0, $xr0, $xr1
; CONTRACT-OFF-NEXT:    xvbitrevi.w $xr0, $xr0, 31
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv2 = fneg<8 x float> %v2
  %mul = fmul<8 x float> %v0, %v1
  %add = fadd<8 x float> %mul, %negv2
  %neg = fneg<8 x float> %add
  store <8 x float> %neg, ptr %res
  ret void
}

define void @xvfnmsub_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfnmsub_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfnmsub_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfsub.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfnmsub_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfsub.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg nsz<8 x float> %v0
  %mul = fmul nsz<8 x float> %negv0, %v1
  %add = fadd nsz<8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

;; Check that fnmsub.s is not emitted.
define void @not_xvfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_xvfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-FAST-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_xvfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-ON-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-ON-NEXT:    xvfsub.s $xr0, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_xvfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a3, 0
; CONTRACT-OFF-NEXT:    xvfsub.s $xr0, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg<8 x float> %v0
  %mul = fmul<8 x float> %negv0, %v1
  %add = fadd<8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

define void @contract_xvfmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_xvfmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_xvfmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_xvfmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %add = fadd contract <8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

define void @contract_xvfmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_xvfmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_xvfmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_xvfmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %sub = fsub contract <8 x float> %mul, %v2
  store <8 x float> %sub, ptr %res
  ret void
}

define void @contract_xvfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_xvfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_xvfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_xvfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %add = fadd contract <8 x float> %mul, %v2
  %negadd = fneg contract <8 x float> %add
  store <8 x float> %negadd, ptr %res
  ret void
}

define void @contract_xvfnmadd_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_xvfnmadd_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_xvfnmadd_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_xvfnmadd_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg contract nsz<8 x float> %v0
  %negv2 = fneg contract nsz<8 x float> %v2
  %mul = fmul contract nsz<8 x float> %negv0, %v1
  %add = fadd contract nsz<8 x float> %mul, %negv2
  store <8 x float> %add, ptr %res
  ret void
}

;; Check that fnmadd.s is not emitted.
define void @not_contract_xvfnmadd_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_contract_xvfnmadd_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-FAST-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_contract_xvfnmadd_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-ON-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_contract_xvfnmadd_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-OFF-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg contract <8 x float> %v0
  %negv2 = fneg contract <8 x float> %v2
  %mul = fmul contract <8 x float> %negv0, %v1
  %add = fadd contract <8 x float> %mul, %negv2
  store <8 x float> %add, ptr %res
  ret void
}

define void @contract_xvfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_xvfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_xvfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_xvfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv2 = fneg contract <8 x float> %v2
  %mul = fmul contract <8 x float> %v0, %v1
  %add = fadd contract <8 x float> %mul, %negv2
  %neg = fneg contract <8 x float> %add
  store <8 x float> %neg, ptr %res
  ret void
}

define void @contract_xvfnmsub_s_nsz(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: contract_xvfnmsub_s_nsz:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: contract_xvfnmsub_s_nsz:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: contract_xvfnmsub_s_nsz:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg contract nsz<8 x float> %v0
  %mul = fmul contract nsz<8 x float> %negv0, %v1
  %add = fadd contract nsz<8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

;; Check that fnmsub.s is not emitted.
define void @not_contract_xvfnmsub_s(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: not_contract_xvfnmsub_s:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-FAST-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: not_contract_xvfnmsub_s:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-ON-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: not_contract_xvfnmsub_s:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvbitrevi.w $xr2, $xr2, 31
; CONTRACT-OFF-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %negv0 = fneg contract <8 x float> %v0
  %mul = fmul contract <8 x float> %negv0, %v1
  %add = fadd contract <8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

define void @xvfmadd_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfmadd_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfmadd_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfmadd_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %add = fadd contract <8 x float> %mul, %v2
  store <8 x float> %add, ptr %res
  ret void
}

define void @xvfmsub_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfmsub_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfmsub_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfmsub_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %sub = fsub contract <8 x float> %mul, %v2
  store <8 x float> %sub, ptr %res
  ret void
}

define void @xvfnmadd_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfnmadd_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfnmadd_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfnmadd_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfnmadd.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %add = fadd contract <8 x float> %mul, %v2
  %negadd = fneg contract <8 x float> %add
  store <8 x float> %negadd, ptr %res
  ret void
}

define void @xvfnmsub_s_contract(ptr %res, ptr %a0, ptr %a1, ptr %a2) nounwind {
; CONTRACT-FAST-LABEL: xvfnmsub_s_contract:
; CONTRACT-FAST:       # %bb.0: # %entry
; CONTRACT-FAST-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-FAST-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-FAST-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-FAST-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-FAST-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-FAST-NEXT:    ret
;
; CONTRACT-ON-LABEL: xvfnmsub_s_contract:
; CONTRACT-ON:       # %bb.0: # %entry
; CONTRACT-ON-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-ON-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-ON-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-ON-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-ON-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-ON-NEXT:    ret
;
; CONTRACT-OFF-LABEL: xvfnmsub_s_contract:
; CONTRACT-OFF:       # %bb.0: # %entry
; CONTRACT-OFF-NEXT:    xvld $xr0, $a3, 0
; CONTRACT-OFF-NEXT:    xvld $xr1, $a2, 0
; CONTRACT-OFF-NEXT:    xvld $xr2, $a1, 0
; CONTRACT-OFF-NEXT:    xvfnmsub.s $xr0, $xr2, $xr1, $xr0
; CONTRACT-OFF-NEXT:    xvst $xr0, $a0, 0
; CONTRACT-OFF-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = load <8 x float>, ptr %a2
  %mul = fmul contract <8 x float> %v0, %v1
  %negv2 = fneg contract <8 x float> %v2
  %add = fadd contract <8 x float> %negv2, %mul
  %negadd = fneg contract <8 x float> %add
  store <8 x float> %negadd, ptr %res
  ret void
}
