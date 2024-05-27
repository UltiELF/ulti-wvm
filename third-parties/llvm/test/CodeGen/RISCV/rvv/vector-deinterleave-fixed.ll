; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+zfh,+zvfh | FileCheck %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zfh,+zvfh | FileCheck %s

; Integers

define {<16 x i1>, <16 x i1>} @vector_deinterleave_v16i1_v32i1(<32 x i1> %vec) {
; CHECK-LABEL: vector_deinterleave_v16i1_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v10, v8, 1, v0
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vadd.vv v11, v9, v9
; CHECK-NEXT:    vrgather.vv v9, v10, v11
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 2
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vadd.vi v12, v11, -16
; CHECK-NEXT:    li a0, -256
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, mu
; CHECK-NEXT:    vrgather.vv v9, v8, v12, v0.t
; CHECK-NEXT:    vmsne.vi v9, v9, 0
; CHECK-NEXT:    vadd.vi v12, v11, 1
; CHECK-NEXT:    vrgather.vv v13, v10, v12
; CHECK-NEXT:    vadd.vi v10, v11, -15
; CHECK-NEXT:    vrgather.vv v13, v8, v10, v0.t
; CHECK-NEXT:    vmsne.vi v8, v13, 0
; CHECK-NEXT:    vmv.v.v v0, v9
; CHECK-NEXT:    ret
%retval = call {<16 x i1>, <16 x i1>} @llvm.experimental.vector.deinterleave2.v32i1(<32 x i1> %vec)
ret {<16 x i1>, <16 x i1>} %retval
}

define {<16 x i8>, <16 x i8>} @vector_deinterleave_v16i8_v32i8(<32 x i8> %vec) {
; CHECK-LABEL: vector_deinterleave_v16i8_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v11, v8, 8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    vmv.v.v v9, v11
; CHECK-NEXT:    ret
%retval = call {<16 x i8>, <16 x i8>} @llvm.experimental.vector.deinterleave2.v32i8(<32 x i8> %vec)
ret {<16 x i8>, <16 x i8>} %retval
}

define {<8 x i16>, <8 x i16>} @vector_deinterleave_v8i16_v16i16(<16 x i16> %vec) {
; CHECK-LABEL: vector_deinterleave_v8i16_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v11, v8, 16
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    vmv.v.v v9, v11
; CHECK-NEXT:    ret
%retval = call {<8 x i16>, <8 x i16>} @llvm.experimental.vector.deinterleave2.v16i16(<16 x i16> %vec)
ret {<8 x i16>, <8 x i16>} %retval
}

define {<4 x i32>, <4 x i32>} @vector_deinterleave_v4i32_vv8i32(<8 x i32> %vec) {
; CHECK-LABEL: vector_deinterleave_v4i32_vv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wx v10, v8, a0
; CHECK-NEXT:    vnsrl.wi v11, v8, 0
; CHECK-NEXT:    vmv.v.v v8, v11
; CHECK-NEXT:    vmv.v.v v9, v10
; CHECK-NEXT:    ret
%retval = call {<4 x i32>, <4 x i32>} @llvm.experimental.vector.deinterleave2.v8i32(<8 x i32> %vec)
ret {<4 x i32>, <4 x i32>} %retval
}

define {<2 x i64>, <2 x i64>} @vector_deinterleave_v2i64_v4i64(<4 x i64> %vec) {
; CHECK-LABEL: vector_deinterleave_v2i64_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 2
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 2
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; CHECK-NEXT:    vrgather.vi v9, v8, 1
; CHECK-NEXT:    vrgather.vi v9, v10, 1, v0.t
; CHECK-NEXT:    vslideup.vi v8, v10, 1
; CHECK-NEXT:    ret
%retval = call {<2 x i64>, <2 x i64>} @llvm.experimental.vector.deinterleave2.v4i64(<4 x i64> %vec)
ret {<2 x i64>, <2 x i64>} %retval
}

declare {<16 x i1>, <16 x i1>} @llvm.experimental.vector.deinterleave2.v32i1(<32 x i1>)
declare {<16 x i8>, <16 x i8>} @llvm.experimental.vector.deinterleave2.v32i8(<32 x i8>)
declare {<8 x i16>, <8 x i16>} @llvm.experimental.vector.deinterleave2.v16i16(<16 x i16>)
declare {<4 x i32>, <4 x i32>} @llvm.experimental.vector.deinterleave2.v8i32(<8 x i32>)
declare {<2 x i64>, <2 x i64>} @llvm.experimental.vector.deinterleave2.v4i64(<4 x i64>)

; Floats

define {<2 x half>, <2 x half>} @vector_deinterleave_v2f16_v4f16(<4 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_v2f16_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v9, v8, 16
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
%retval = call {<2 x half>, <2 x half>} @llvm.experimental.vector.deinterleave2.v4f16(<4 x half> %vec)
ret {<2 x half>, <2 x half>} %retval
}

define {<4 x half>, <4 x half>} @vector_deinterleave_v4f16_v8f16(<8 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_v4f16_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v9, v8, 16
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
%retval = call {<4 x half>, <4 x half>} @llvm.experimental.vector.deinterleave2.v8f16(<8 x half> %vec)
ret {<4 x half>, <4 x half>} %retval
}

define {<2 x float>, <2 x float>} @vector_deinterleave_v2f32_v4f32(<4 x float> %vec) {
; CHECK-LABEL: vector_deinterleave_v2f32_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v9, v8, a0
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
%retval = call {<2 x float>, <2 x float>} @llvm.experimental.vector.deinterleave2.v4f32(<4 x float> %vec)
ret {<2 x float>, <2 x float>} %retval
}

define {<8 x half>, <8 x half>} @vector_deinterleave_v8f16_v16f16(<16 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_v8f16_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v11, v8, 16
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    vmv.v.v v9, v11
; CHECK-NEXT:    ret
%retval = call {<8 x half>, <8 x half>} @llvm.experimental.vector.deinterleave2.v16f16(<16 x half> %vec)
ret {<8 x half>, <8 x half>} %retval
}

define {<4 x float>, <4 x float>} @vector_deinterleave_v4f32_v8f32(<8 x float> %vec) {
; CHECK-LABEL: vector_deinterleave_v4f32_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wx v10, v8, a0
; CHECK-NEXT:    vnsrl.wi v11, v8, 0
; CHECK-NEXT:    vmv.v.v v8, v11
; CHECK-NEXT:    vmv.v.v v9, v10
; CHECK-NEXT:    ret
%retval = call {<4 x float>, <4 x float>} @llvm.experimental.vector.deinterleave2.v8f32(<8 x float> %vec)
ret  {<4 x float>, <4 x float>} %retval
}

define {<2 x double>, <2 x double>} @vector_deinterleave_v2f64_v4f64(<4 x double> %vec) {
; CHECK-LABEL: vector_deinterleave_v2f64_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 2
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 2
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; CHECK-NEXT:    vrgather.vi v9, v8, 1
; CHECK-NEXT:    vrgather.vi v9, v10, 1, v0.t
; CHECK-NEXT:    vslideup.vi v8, v10, 1
; CHECK-NEXT:    ret
%retval = call {<2 x double>, <2 x double>} @llvm.experimental.vector.deinterleave2.v4f64(<4 x double> %vec)
ret {<2 x double>, <2 x double>} %retval
}

declare {<2 x half>,<2 x half>} @llvm.experimental.vector.deinterleave2.v4f16(<4 x half>)
declare {<4 x half>, <4 x half>} @llvm.experimental.vector.deinterleave2.v8f16(<8 x half>)
declare {<2 x float>, <2 x float>} @llvm.experimental.vector.deinterleave2.v4f32(<4 x float>)
declare {<8 x half>, <8 x half>} @llvm.experimental.vector.deinterleave2.v16f16(<16 x half>)
declare {<4 x float>, <4 x float>} @llvm.experimental.vector.deinterleave2.v8f32(<8 x float>)
declare {<2 x double>, <2 x double>} @llvm.experimental.vector.deinterleave2.v4f64(<4 x double>)
