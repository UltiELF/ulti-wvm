; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @select_v32i8_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: select_v32i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvrepli.h $xr1, -256
; CHECK-NEXT:    xvbitseli.b $xr1, $xr0, 1
; CHECK-NEXT:    xvst $xr1, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %sel = select <32 x i1> <i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true>, <32 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>, <32 x i8> %v0
  store <32 x i8> %sel, ptr %res
  ret void
}

define void @select_v32i8(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: select_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvrepli.h $xr2, -256
; CHECK-NEXT:    xvbitsel.v $xr0, $xr1, $xr0, $xr2
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %sel = select <32 x i1> <i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true>, <32 x i8> %v0, <32 x i8> %v1
  store <32 x i8> %sel, ptr %res
  ret void
}

define void @select_v16i16(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: select_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lu12i.w $a3, -16
; CHECK-NEXT:    xvreplgr2vr.w $xr0, $a3
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvld $xr2, $a2, 0
; CHECK-NEXT:    xvbitsel.v $xr0, $xr2, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %sel = select <16 x i1> <i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true>, <16 x i16> %v0, <16 x i16> %v1
  store <16 x i16> %sel, ptr %res
  ret void
}

define void @select_v8i32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: select_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    ori $a1, $zero, 0
; CHECK-NEXT:    lu32i.d $a1, -1
; CHECK-NEXT:    xvreplgr2vr.d $xr2, $a1
; CHECK-NEXT:    xvbitsel.v $xr0, $xr1, $xr0, $xr2
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %sel = select <8 x i1> <i1 false, i1 true, i1 false, i1 true, i1 false, i1 true, i1 false, i1 true>, <8 x i32> %v0, <8 x i32> %v1
  store <8 x i32> %sel, ptr %res
  ret void
}

define void @select_v4i64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: select_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a3, %pc_hi20(.LCPI4_0)
; CHECK-NEXT:    addi.d $a3, $a3, %pc_lo12(.LCPI4_0)
; CHECK-NEXT:    xvld $xr0, $a3, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvld $xr2, $a2, 0
; CHECK-NEXT:    xvbitsel.v $xr0, $xr2, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %sel = select <4 x i1> <i1 true, i1 false, i1 true, i1 false>, <4 x i64> %v0, <4 x i64> %v1
  store <4 x i64> %sel, ptr %res
  ret void
}
