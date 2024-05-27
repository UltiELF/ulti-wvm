; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+sve -o - | FileCheck %s

target triple = "aarch64"

; Expected to transform
define <vscale x 2 x double> @complex_add_v2f64(<vscale x 2 x double> %a, <vscale x 2 x double> %b) {
; CHECK-LABEL: complex_add_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fcadd z1.d, p0/m, z1.d, z0.d, #90
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
entry:
  %a.deinterleaved = tail call { <vscale x 1 x double>, <vscale x 1 x double> } @llvm.experimental.vector.deinterleave2.nxv2f64(<vscale x 2 x double> %a)
  %a.real = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } %a.deinterleaved, 0
  %a.imag = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } %a.deinterleaved, 1
  %b.deinterleaved = tail call { <vscale x 1 x double>, <vscale x 1 x double> } @llvm.experimental.vector.deinterleave2.nxv2f64(<vscale x 2 x double> %b)
  %b.real = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } %b.deinterleaved, 0
  %b.imag = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } %b.deinterleaved, 1
  %0 = fsub fast <vscale x 1 x double> %b.real, %a.imag
  %1 = fadd fast <vscale x 1 x double> %b.imag, %a.real
  %interleaved.vec = tail call <vscale x 2 x double> @llvm.experimental.vector.interleave2.nxv2f64(<vscale x 1 x double> %0, <vscale x 1 x double> %1)
  ret <vscale x 2 x double> %interleaved.vec
}

; Expected to transform
define <vscale x 4 x double> @complex_add_v4f64(<vscale x 4 x double> %a, <vscale x 4 x double> %b) {
; CHECK-LABEL: complex_add_v4f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fcadd z2.d, p0/m, z2.d, z0.d, #90
; CHECK-NEXT:    fcadd z3.d, p0/m, z3.d, z1.d, #90
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    mov z1.d, z3.d
; CHECK-NEXT:    ret
entry:
  %a.deinterleaved = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %a)
  %a.real = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %a.deinterleaved, 0
  %a.imag = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %a.deinterleaved, 1
  %b.deinterleaved = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %b)
  %b.real = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %b.deinterleaved, 0
  %b.imag = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %b.deinterleaved, 1
  %0 = fsub fast <vscale x 2 x double> %b.real, %a.imag
  %1 = fadd fast <vscale x 2 x double> %b.imag, %a.real
  %interleaved.vec = tail call <vscale x 4 x double> @llvm.experimental.vector.interleave2.nxv4f64(<vscale x 2 x double> %0, <vscale x 2 x double> %1)
  ret <vscale x 4 x double> %interleaved.vec
}

; Expected to transform
define <vscale x 8 x double> @complex_add_v8f64(<vscale x 8 x double> %a, <vscale x 8 x double> %b) {
; CHECK-LABEL: complex_add_v8f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fcadd z4.d, p0/m, z4.d, z0.d, #90
; CHECK-NEXT:    fcadd z5.d, p0/m, z5.d, z1.d, #90
; CHECK-NEXT:    fcadd z6.d, p0/m, z6.d, z2.d, #90
; CHECK-NEXT:    fcadd z7.d, p0/m, z7.d, z3.d, #90
; CHECK-NEXT:    mov z0.d, z4.d
; CHECK-NEXT:    mov z1.d, z5.d
; CHECK-NEXT:    mov z2.d, z6.d
; CHECK-NEXT:    mov z3.d, z7.d
; CHECK-NEXT:    ret
entry:
  %a.deinterleaved = tail call { <vscale x 4 x double>, <vscale x 4 x double> } @llvm.experimental.vector.deinterleave2.nxv8f64(<vscale x 8 x double> %a)
  %a.real = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } %a.deinterleaved, 0
  %a.imag = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } %a.deinterleaved, 1
  %b.deinterleaved = tail call { <vscale x 4 x double>, <vscale x 4 x double> } @llvm.experimental.vector.deinterleave2.nxv8f64(<vscale x 8 x double> %b)
  %b.real = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } %b.deinterleaved, 0
  %b.imag = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } %b.deinterleaved, 1
  %0 = fsub fast <vscale x 4 x double> %b.real, %a.imag
  %1 = fadd fast <vscale x 4 x double> %b.imag, %a.real
  %interleaved.vec = tail call <vscale x 8 x double> @llvm.experimental.vector.interleave2.nxv8f64(<vscale x 4 x double> %0, <vscale x 4 x double> %1)
  ret <vscale x 8 x double> %interleaved.vec
}

declare { <vscale x 1 x double>, <vscale x 1 x double> } @llvm.experimental.vector.deinterleave2.nxv2f64(<vscale x 2 x double>)
declare <vscale x 2 x double> @llvm.experimental.vector.interleave2.nxv2f64(<vscale x 1 x double>, <vscale x 1 x double>)

declare { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double>)
declare <vscale x 4 x double> @llvm.experimental.vector.interleave2.nxv4f64(<vscale x 2 x double>, <vscale x 2 x double>)

declare { <vscale x 4 x double>, <vscale x 4 x double> } @llvm.experimental.vector.deinterleave2.nxv8f64(<vscale x 8 x double>)
declare <vscale x 8 x double> @llvm.experimental.vector.interleave2.nxv8f64(<vscale x 4 x double>, <vscale x 4 x double>)
