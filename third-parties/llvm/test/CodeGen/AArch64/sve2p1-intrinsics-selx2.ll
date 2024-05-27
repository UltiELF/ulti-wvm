; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -verify-machineinstrs < %s | FileCheck %s

; == 8 to 64-bit elements ==

define { <vscale x 16 x i8>, <vscale x 16 x i8> } @sel_x2_i8(target("aarch64.svcount") %pn, <vscale x 16 x i8> %unused, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zm1, <vscale x 16 x i8> %zm2) nounwind {
; CHECK-LABEL: sel_x2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.b, z1.b }, pn8, { z6.b, z7.b }, { z4.b, z5.b }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.sel.x2.nxv16i8(target("aarch64.svcount") %pn, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zm1, <vscale x 16 x i8> %zm2)
  ret { <vscale x 16 x i8>, <vscale x 16 x i8> } %res
}

define { <vscale x 8 x i16>, <vscale x 8 x i16> } @sel_x2_i16(target("aarch64.svcount") %pn, <vscale x 8 x i16> %unused, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm1, <vscale x 8 x i16> %zm2) nounwind {
; CHECK-LABEL: sel_x2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.h, z1.h }, pn8, { z6.h, z7.h }, { z4.h, z5.h }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.sel.x2.nxv8i16(target("aarch64.svcount") %pn, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm1, <vscale x 8 x i16> %zm2)
  ret { <vscale x 8 x i16>, <vscale x 8 x i16> } %res
}

define { <vscale x 8 x half>, <vscale x 8 x half> } @sel_x2_f16(target("aarch64.svcount") %pn, <vscale x 8 x half> %unused, <vscale x 8 x half> %zn1, <vscale x 8 x half> %zn2, <vscale x 8 x half> %zm1, <vscale x 8 x half> %zm2) nounwind {
; CHECK-LABEL: sel_x2_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.h, z1.h }, pn8, { z6.h, z7.h }, { z4.h, z5.h }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sve.sel.x2.nxv8f16(target("aarch64.svcount") %pn, <vscale x 8 x half> %zn1, <vscale x 8 x half> %zn2, <vscale x 8 x half> %zm1, <vscale x 8 x half> %zm2)
  ret { <vscale x 8 x half>, <vscale x 8 x half> } %res
}

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @sel_x2_bf16(target("aarch64.svcount") %pn, <vscale x 8 x bfloat> %unused, <vscale x 8 x bfloat> %zn1, <vscale x 8 x bfloat> %zn2, <vscale x 8 x bfloat> %zm1, <vscale x 8 x bfloat> %zm2) nounwind {
; CHECK-LABEL: sel_x2_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.h, z1.h }, pn8, { z6.h, z7.h }, { z4.h, z5.h }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.sel.x2.nxv8bf16(target("aarch64.svcount") %pn, <vscale x 8 x bfloat> %zn1, <vscale x 8 x bfloat> %zn2, <vscale x 8 x bfloat> %zm1, <vscale x 8 x bfloat> %zm2)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res
}

define { <vscale x 4 x i32>, <vscale x 4 x i32> } @sel_x2_i32(target("aarch64.svcount") %pn, <vscale x 4 x i32> %unused, <vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2, <vscale x 4 x i32> %zm1, <vscale x 4 x i32> %zm2) nounwind {
; CHECK-LABEL: sel_x2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.s, z1.s }, pn8, { z6.s, z7.s }, { z4.s, z5.s }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.sel.x2.nxv4i32(target("aarch64.svcount") %pn, <vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2, <vscale x 4 x i32> %zm1, <vscale x 4 x i32> %zm2)
  ret { <vscale x 4 x i32>, <vscale x 4 x i32> } %res
}

define { <vscale x 4 x float>, <vscale x 4 x float> } @sel_x2_f32(target("aarch64.svcount") %pn, <vscale x 4 x float> %unused, <vscale x 4 x float> %zn1, <vscale x 4 x float> %zn2, <vscale x 4 x float> %zm1, <vscale x 4 x float> %zm2) nounwind {
; CHECK-LABEL: sel_x2_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.s, z1.s }, pn8, { z6.s, z7.s }, { z4.s, z5.s }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sve.sel.x2.nxv4f32(target("aarch64.svcount") %pn, <vscale x 4 x float> %zn1, <vscale x 4 x float> %zn2, <vscale x 4 x float> %zm1, <vscale x 4 x float> %zm2)
  ret { <vscale x 4 x float>, <vscale x 4 x float> } %res
}

define { <vscale x 2 x i64>, <vscale x 2 x i64> } @sel_x2_i64(target("aarch64.svcount") %pn, <vscale x 2 x i64> %unused, <vscale x 2 x i64> %zn1, <vscale x 2 x i64> %zn2, <vscale x 2 x i64> %zm1, <vscale x 2 x i64> %zm2) nounwind {
; CHECK-LABEL: sel_x2_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.d, z1.d }, pn8, { z6.d, z7.d }, { z4.d, z5.d }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.sel.x2.nxv2i64(target("aarch64.svcount") %pn, <vscale x 2 x i64> %zn1, <vscale x 2 x i64> %zn2, <vscale x 2 x i64> %zm1, <vscale x 2 x i64> %zm2)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64> } %res
}

define { <vscale x 2 x double>, <vscale x 2 x double> } @sel_x2_f64(target("aarch64.svcount") %pn, <vscale x 2 x double> %unused, <vscale x 2 x double> %zn1, <vscale x 2 x double> %zn2, <vscale x 2 x double> %zm1, <vscale x 2 x double> %zm2) nounwind {
; CHECK-LABEL: sel_x2_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    mov p8.b, p0.b
; CHECK-NEXT:    mov z5.d, z4.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z4.d, z3.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    sel { z0.d, z1.d }, pn8, { z6.d, z7.d }, { z4.d, z5.d }
; CHECK-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sve.sel.x2.nxv2f64(target("aarch64.svcount") %pn, <vscale x 2 x double> %zn1, <vscale x 2 x double> %zn2, <vscale x 2 x double> %zm1, <vscale x 2 x double> %zm2)
  ret { <vscale x 2 x double>, <vscale x 2 x double> } %res
}

; == 8 to 64-bit elements ==
declare { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.sel.x2.nxv16i8(target("aarch64.svcount") %pn, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zm1, <vscale x 16 x i8> %zm2)
declare { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.sel.x2.nxv8i16(target("aarch64.svcount") %pn, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm1, <vscale x 8 x i16> %zm2)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.sel.x2.nxv4i32(target("aarch64.svcount") %pn, <vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2, <vscale x 4 x i32> %zm1, <vscale x 4 x i32> %zm2)
declare { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.sel.x2.nxv2i64(target("aarch64.svcount") %pn, <vscale x 2 x i64> %zn1, <vscale x 2 x i64> %zn2, <vscale x 2 x i64> %zm1, <vscale x 2 x i64> %zm2)
declare { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sve.sel.x2.nxv8f16(target("aarch64.svcount") %pn, <vscale x 8 x half> %zn1, <vscale x 8 x half> %zn2, <vscale x 8 x half> %zm1, <vscale x 8 x half> %zm2)
declare { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.sel.x2.nxv8bf16(target("aarch64.svcount") %pn, <vscale x 8 x bfloat> %zn1, <vscale x 8 x bfloat> %zn2, <vscale x 8 x bfloat> %zm1, <vscale x 8 x bfloat> %zm2)
declare { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sve.sel.x2.nxv4f32(target("aarch64.svcount") %pn, <vscale x 4 x float> %zn1, <vscale x 4 x float> %zn2, <vscale x 4 x float> %zm1, <vscale x 4 x float> %zm2)
declare { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sve.sel.x2.nxv2f64(target("aarch64.svcount") %pn, <vscale x 2 x double> %zn1, <vscale x 2 x double> %zn2, <vscale x 2 x double> %zm1, <vscale x 2 x double> %zm2)
