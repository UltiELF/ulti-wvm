; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown < %s | FileCheck %s

define float @fadd_zero_f32(float %x) #0 {
; CHECK-LABEL: fadd_zero_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %y = fadd float %x, 0.0
  ret float %y
}

define <4 x float> @fadd_zero_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_zero_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, zeroinitializer
  ret <4 x float> %y
}

define <4 x float> @fadd_zero_4f32_undef(<4 x float> %x) {
; CHECK-LABEL: fadd_zero_4f32_undef:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %y = fadd nsz <4 x float> %x, <float 0.0, float undef, float 0.0, float undef>
  ret <4 x float> %y
}

; CHECK: float 3
define float @fadd_2const_f32(float %x) #0 {
; CHECK-LABEL: fadd_2const_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd float %x, 1.0
  %z = fadd float %y, 2.0
  ret float %z
}

; CHECK: float 5
; CHECK: float 5
; CHECK: float 5
; CHECK: float 5
define <4 x float> @fadd_2const_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_2const_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, <float 1.0, float 2.0, float 3.0, float 4.0>
  %z = fadd <4 x float> %y, <float 4.0, float 3.0, float 2.0, float 1.0>
  ret <4 x float> %z
}

; CHECK: float 3
define float @fadd_x_fmul_x_c_f32(float %x) #0 {
; CHECK-LABEL: fadd_x_fmul_x_c_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fmul float %x, 2.0
  %z = fadd float %x, %y
  ret float %z
}

; CHECK: float 2
; CHECK: float 3
; CHECK: float 4
; CHECK: float 5
define <4 x float> @fadd_x_fmul_x_c_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_x_fmul_x_c_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fmul <4 x float> %x, <float 1.0, float 2.0, float 3.0, float 4.0>
  %z = fadd <4 x float> %x, %y
  ret <4 x float> %z
}

; CHECK: float 3
define float @fadd_fmul_x_c_x_f32(float %x) #0 {
; CHECK-LABEL: fadd_fmul_x_c_x_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fmul float %x, 2.0
  %z = fadd float %y, %x
  ret float %z
}

; CHECK: float 2
; CHECK: float 3
; CHECK: float 4
; CHECK: float 5
define <4 x float> @fadd_fmul_x_c_x_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_fmul_x_c_x_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fmul <4 x float> %x, <float 1.0, float 2.0, float 3.0, float 4.0>
  %z = fadd <4 x float> %y, %x
  ret <4 x float> %z
}

; CHECK: float 4
define float @fadd_fadd_x_x_fmul_x_c_f32(float %x) #0 {
; CHECK-LABEL: fadd_fadd_x_x_fmul_x_c_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd float %x, %x
  %z = fmul float %x, 2.0
  %w = fadd float %y, %z
  ret float %w
}

; CHECK: float 3
; CHECK: float 4
; CHECK: float 5
; CHECK: float 6
define <4 x float> @fadd_fadd_x_x_fmul_x_c_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_fadd_x_x_fmul_x_c_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, %x
  %z = fmul <4 x float> %x, <float 1.0, float 2.0, float 3.0, float 4.0>
  %w = fadd <4 x float> %y, %z
  ret <4 x float> %w
}

; CHECK: float 4
define float @fadd_fmul_x_c_fadd_x_x_f32(float %x) #0 {
; CHECK-LABEL: fadd_fmul_x_c_fadd_x_x_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd float %x, %x
  %z = fmul float %x, 2.0
  %w = fadd float %z, %y
  ret float %w
}

; CHECK: float 3
; CHECK: float 4
; CHECK: float 5
; CHECK: float 6
define <4 x float> @fadd_fmul_x_c_fadd_x_x_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_fmul_x_c_fadd_x_x_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, %x
  %z = fmul <4 x float> %x, <float 1.0, float 2.0, float 3.0, float 4.0>
  %w = fadd <4 x float> %z, %y
  ret <4 x float> %w
}

; CHECK: float 3
define float @fadd_x_fadd_x_x_f32(float %x) #0 {
; CHECK-LABEL: fadd_x_fadd_x_x_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd float %x, %x
  %z = fadd float %x, %y
  ret float %z
}

; CHECK: float 3
; CHECK: float 3
; CHECK: float 3
; CHECK: float 3
define <4 x float> @fadd_x_fadd_x_x_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_x_fadd_x_x_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, %x
  %z = fadd <4 x float> %x, %y
  ret <4 x float> %z
}

; CHECK: float 3
define float @fadd_fadd_x_x_x_f32(float %x) #0 {
; CHECK-LABEL: fadd_fadd_x_x_x_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd float %x, %x
  %z = fadd float %y, %x
  ret float %z
}

; CHECK: float 3
; CHECK: float 3
; CHECK: float 3
; CHECK: float 3
define <4 x float> @fadd_fadd_x_x_x_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_fadd_x_x_x_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, %x
  %z = fadd <4 x float> %y, %x
  ret <4 x float> %z
}

; CHECK: float 4
define float @fadd_fadd_x_x_fadd_x_x_f32(float %x) #0 {
; CHECK-LABEL: fadd_fadd_x_x_fadd_x_x_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd float %x, %x
  %z = fadd float %y, %y
  ret float %z
}

; CHECK: float 4
; CHECK: float 4
; CHECK: float 4
; CHECK: float 4
define <4 x float> @fadd_fadd_x_x_fadd_x_x_4f32(<4 x float> %x) #0 {
; CHECK-LABEL: fadd_fadd_x_x_fadd_x_x_4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %y = fadd <4 x float> %x, %x
  %z = fadd <4 x float> %y, %y
  ret <4 x float> %z
}

; ((x + 42.0) + 17.0) + (x + 42.0) --> (x + 59.0) + (x + 17.0)
; It's still 3 adds, but the first 2 are independent.
; More reassocation could get this to 2 adds or 1 FMA (that's done in IR, but not in the DAG).

define float @fadd_const_multiuse_attr(float %x) #0 {
; CHECK-LABEL: fadd_const_multiuse_attr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movss {{.*#+}} xmm1 = [4.2E+1,0.0E+0,0.0E+0,0.0E+0]
; CHECK-NEXT:    addss %xmm0, %xmm1
; CHECK-NEXT:    addss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    addss %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a1 = fadd float %x, 42.0
  %a2 = fadd float %a1, 17.0
  %a3 = fadd float %a1, %a2
  ret float %a3
}

; PR32939 - https://bugs.llvm.org/show_bug.cgi?id=32939

define double @fmul2_negated(double %a, double %b, double %c) {
; CHECK-LABEL: fmul2_negated:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addsd %xmm1, %xmm1
; CHECK-NEXT:    mulsd %xmm2, %xmm1
; CHECK-NEXT:    subsd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %mul = fmul double %b, 2.0
  %mul1 = fmul double %mul, %c
  %sub = fsub double %a, %mul1
  ret double %sub
}

define <2 x double> @fmul2_negated_vec(<2 x double> %a, <2 x double> %b, <2 x double> %c) {
; CHECK-LABEL: fmul2_negated_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addpd %xmm1, %xmm1
; CHECK-NEXT:    mulpd %xmm2, %xmm1
; CHECK-NEXT:    subpd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %mul = fmul <2 x double> %b, <double 2.0, double 2.0>
  %mul1 = fmul <2 x double> %mul, %c
  %sub = fsub <2 x double> %a, %mul1
  ret <2 x double> %sub
}

attributes #0 = { "less-precise-fpmad"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "unsafe-fp-math"="true" "no-signed-zeros-fp-math"="true" }
