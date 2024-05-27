; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+avx2 | FileCheck %s

define i32 @f(<8 x float> %A, i8* %B, <4 x double> %C, <4 x i64> %E, <8 x i32> %F, <16 x i16> %G, <32 x i8> %H, i32* %loadptr) nounwind {
  %v0 = load i32, i32* %loadptr, align 1
  %cast = bitcast i8* %B to <8 x float>*
  %A2 = fadd <8 x float> %A, <float 1.0, float 2.0, float 3.0, float 4.0, float 5.0, float 6.0, float 7.0, float 8.0>
  store <8 x float> %A2, <8 x float>* %cast, align 32, !nontemporal !0
  %v1 = load i32, i32* %loadptr, align 1
  %cast1 = bitcast i8* %B to <4 x i64>*
  %E2 = add <4 x i64> %E, <i64 1, i64 2, i64 3, i64 4>
  store <4 x i64> %E2, <4 x i64>* %cast1, align 32, !nontemporal !0
  %v2 = load i32, i32* %loadptr, align 1
  %cast2 = bitcast i8* %B to <4 x double>*
  %C2 = fadd <4 x double> %C, <double 1.0, double 2.0, double 3.0, double 4.0>
  store <4 x double> %C2, <4 x double>* %cast2, align 32, !nontemporal !0
  %v3 = load i32, i32* %loadptr, align 1
  %cast3 = bitcast i8* %B to <8 x i32>*
  %F2 = add <8 x i32> %F, <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8>
  store <8 x i32> %F2, <8 x i32>* %cast3, align 32, !nontemporal !0
  %v4 = load i32, i32* %loadptr, align 1
  %cast4 = bitcast i8* %B to <16 x i16>*
  %G2 = add <16 x i16> %G, <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>
  store <16 x i16> %G2, <16 x i16>* %cast4, align 32, !nontemporal !0
  %v5 = load i32, i32* %loadptr, align 1
  %cast5 = bitcast i8* %B to <32 x i8>*
  %H2 = add <32 x i8> %H, <i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8>
  store <32 x i8> %H2, <32 x i8>* %cast5, align 32, !nontemporal !0
  %v6 = load i32, i32* %loadptr, align 1
  %sum1 = add i32 %v0, %v1
  %sum2 = add i32 %sum1, %v2
  %sum3 = add i32 %sum2, %v3
  %sum4 = add i32 %sum3, %v4
  %sum5 = add i32 %sum4, %v5
  %sum6 = add i32 %sum5, %v6
  ret i32 %sum5
}

!0 = !{i32 1}
