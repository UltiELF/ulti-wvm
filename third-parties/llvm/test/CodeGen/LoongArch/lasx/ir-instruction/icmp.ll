; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

;; SETEQ
define void @v32i8_icmp_eq_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v32i8_icmp_eq_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvseqi.b $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %cmp = icmp eq <32 x i8> %v0, <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v32i8_icmp_eq(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_eq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp eq <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_eq_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v16i16_icmp_eq_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvseqi.h $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %cmp = icmp eq <16 x i16> %v0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_eq(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_eq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp eq <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_eq_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v8i32_icmp_eq_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvseqi.w $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %cmp = icmp eq <8 x i32> %v0, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_eq(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_eq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp eq <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_eq_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v4i64_icmp_eq_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvseqi.d $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %cmp = icmp eq <4 x i64> %v0, <i64 15, i64 15, i64 15, i64 15>
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_eq(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_eq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp eq <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; SETLE
define void @v32i8_icmp_sle_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v32i8_icmp_sle_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.b $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %cmp = icmp sle <32 x i8> %v0, <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v32i8_icmp_sle(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_sle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp sle <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_sle_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v16i16_icmp_sle_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.h $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %cmp = icmp sle <16 x i16> %v0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_sle(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_sle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp sle <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_sle_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v8i32_icmp_sle_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.w $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %cmp = icmp sle <8 x i32> %v0, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_sle(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_sle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp sle <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_sle_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v4i64_icmp_sle_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.d $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %cmp = icmp sle <4 x i64> %v0, <i64 15, i64 15, i64 15, i64 15>
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_sle(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_sle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp sle <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; SETULE
define void @v32i8_icmp_ule_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v32i8_icmp_ule_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.bu $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %cmp = icmp ule <32 x i8> %v0, <i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31>
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v32i8_icmp_ule(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_ule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.bu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp ule <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_ule_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v16i16_icmp_ule_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.hu $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %cmp = icmp ule <16 x i16> %v0, <i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31>
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_ule(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_ule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.hu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp ule <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_ule_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v8i32_icmp_ule_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.wu $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %cmp = icmp ule <8 x i32> %v0, <i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31>
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_ule(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_ule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.wu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp ule <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_ule_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v4i64_icmp_ule_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslei.du $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %cmp = icmp ule <4 x i64> %v0, <i64 31, i64 31, i64 31, i64 31>
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_ule(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_ule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvsle.du $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp ule <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; SETLT
define void @v32i8_icmp_slt_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v32i8_icmp_slt_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.b $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %cmp = icmp slt <32 x i8> %v0, <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v32i8_icmp_slt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_slt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp slt <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_slt_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v16i16_icmp_slt_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.h $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %cmp = icmp slt <16 x i16> %v0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_slt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_slt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp slt <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_slt_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v8i32_icmp_slt_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.w $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %cmp = icmp slt <8 x i32> %v0, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_slt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_slt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp slt <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_slt_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v4i64_icmp_slt_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.d $xr0, $xr0, 15
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %cmp = icmp slt <4 x i64> %v0, <i64 15, i64 15, i64 15, i64 15>
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_slt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_slt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp slt <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; SETULT
define void @v32i8_icmp_ult_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v32i8_icmp_ult_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.bu $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %cmp = icmp ult <32 x i8> %v0, <i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31, i8 31>
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v32i8_icmp_ult(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.bu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp ult <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_ult_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v16i16_icmp_ult_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.hu $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %cmp = icmp ult <16 x i16> %v0, <i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31, i16 31>
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_ult(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.hu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp ult <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_ult_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v8i32_icmp_ult_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.wu $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %cmp = icmp ult <8 x i32> %v0, <i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31>
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_ult(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.wu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp ult <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_ult_imm(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: v4i64_icmp_ult_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslti.du $xr0, $xr0, 31
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %cmp = icmp ult <4 x i64> %v0, <i64 31, i64 31, i64 31, i64 31>
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_ult(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvslt.du $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp ult <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; Expand SETNE
define void @v32i8_icmp_ne(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_ne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvxori.b $xr0, $xr0, 255
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp ne <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_ne(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_ne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvrepli.b $xr1, -1
; CHECK-NEXT:    xvxor.v $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp ne <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_ne(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_ne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvrepli.b $xr1, -1
; CHECK-NEXT:    xvxor.v $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp ne <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_ne(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_ne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvseq.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvrepli.b $xr1, -1
; CHECK-NEXT:    xvxor.v $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp ne <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; Expand SETGE
define void @v32i8_icmp_sge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_sge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp sge <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_sge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_sge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp sge <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_sge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_sge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp sge <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_sge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_sge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp sge <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; Expand SETUGE
define void @v32i8_icmp_uge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_uge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.bu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp uge <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_uge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_uge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.hu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp uge <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_uge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_uge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.wu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp uge <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_uge(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_uge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvsle.du $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp uge <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; Expand SETGT
define void @v32i8_icmp_sgt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_sgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp sgt <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_sgt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_sgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp sgt <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_sgt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_sgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp sgt <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_sgt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_sgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp sgt <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}

;; Expand SETUGT
define void @v32i8_icmp_ugt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v32i8_icmp_ugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.bu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %cmp = icmp ugt <32 x i8> %v0, %v1
  %ext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %ext, ptr %res
  ret void
}

define void @v16i16_icmp_ugt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v16i16_icmp_ugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.hu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %cmp = icmp ugt <16 x i16> %v0, %v1
  %ext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %ext, ptr %res
  ret void
}

define void @v8i32_icmp_ugt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v8i32_icmp_ugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.wu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %cmp = icmp ugt <8 x i32> %v0, %v1
  %ext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %ext, ptr %res
  ret void
}

define void @v4i64_icmp_ugt(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: v4i64_icmp_ugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvslt.du $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %cmp = icmp ugt <4 x i64> %v0, %v1
  %ext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %ext, ptr %res
  ret void
}
