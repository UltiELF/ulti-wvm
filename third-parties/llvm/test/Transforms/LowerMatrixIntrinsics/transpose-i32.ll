; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='lower-matrix-intrinsics' -S < %s | FileCheck %s


define <8 x i32> @transpose(<8 x i32> %a) {
; CHECK-LABEL: @transpose(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[A]], <8 x i32> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x i32> [[A]], <8 x i32> poison, <2 x i32> <i32 4, i32 5>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <8 x i32> [[A]], <8 x i32> poison, <2 x i32> <i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x i32> [[SPLIT]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> poison, i32 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x i32> [[SPLIT1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> [[TMP1]], i32 [[TMP2]], i64 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x i32> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[TMP4]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x i32> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x i32> [[TMP5]], i32 [[TMP6]], i64 3
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x i32> [[SPLIT]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x i32> poison, i32 [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x i32> [[SPLIT1]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x i32> [[TMP9]], i32 [[TMP10]], i64 1
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x i32> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x i32> [[TMP11]], i32 [[TMP12]], i64 2
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <2 x i32> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <4 x i32> [[TMP13]], i32 [[TMP14]], i64 3
; CHECK-NEXT:    [[TMP16:%.*]] = shufflevector <4 x i32> [[TMP7]], <4 x i32> [[TMP15]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x i32> [[TMP16]]
;
entry:
  %c  = call <8 x i32> @llvm.matrix.transpose(<8 x i32> %a, i32 2, i32 4)
  ret <8 x i32> %c
}

declare <8 x i32> @llvm.matrix.transpose(<8 x i32>, i32, i32)

define <8 x i32> @transpose_single_column(<8 x i32> %a) {
; CHECK-LABEL: @transpose_single_column(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <1 x i32> poison, i32 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 1
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <1 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 2
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <1 x i32> poison, i32 [[TMP4]], i64 0
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 3
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <1 x i32> poison, i32 [[TMP6]], i64 0
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 4
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <1 x i32> poison, i32 [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 5
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <1 x i32> poison, i32 [[TMP10]], i64 0
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 6
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <1 x i32> poison, i32 [[TMP12]], i64 0
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <8 x i32> [[SPLIT]], i64 7
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <1 x i32> poison, i32 [[TMP14]], i64 0
; CHECK-NEXT:    [[TMP16:%.*]] = shufflevector <1 x i32> [[TMP1]], <1 x i32> [[TMP3]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP17:%.*]] = shufflevector <1 x i32> [[TMP5]], <1 x i32> [[TMP7]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP18:%.*]] = shufflevector <1 x i32> [[TMP9]], <1 x i32> [[TMP11]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP19:%.*]] = shufflevector <1 x i32> [[TMP13]], <1 x i32> [[TMP15]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP20:%.*]] = shufflevector <2 x i32> [[TMP16]], <2 x i32> [[TMP17]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP21:%.*]] = shufflevector <2 x i32> [[TMP18]], <2 x i32> [[TMP19]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP22:%.*]] = shufflevector <4 x i32> [[TMP20]], <4 x i32> [[TMP21]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x i32> [[TMP22]]
;
entry:
  %c  = call <8 x i32> @llvm.matrix.transpose(<8 x i32> %a, i32 8, i32 1)
  ret <8 x i32> %c
}

declare <12 x i32> @llvm.matrix.transpose.v12i32(<12 x i32>, i32, i32)

define <12 x i32> @transpose_i32_3x4(<12 x i32> %a) {
; CHECK-LABEL: @transpose_i32_3x4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <12 x i32> [[A:%.*]], <12 x i32> poison, <3 x i32> <i32 0, i32 1, i32 2>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <12 x i32> [[A]], <12 x i32> poison, <3 x i32> <i32 3, i32 4, i32 5>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <12 x i32> [[A]], <12 x i32> poison, <3 x i32> <i32 6, i32 7, i32 8>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <12 x i32> [[A]], <12 x i32> poison, <3 x i32> <i32 9, i32 10, i32 11>
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <3 x i32> [[SPLIT]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> poison, i32 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <3 x i32> [[SPLIT1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> [[TMP1]], i32 [[TMP2]], i64 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <3 x i32> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[TMP4]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <3 x i32> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x i32> [[TMP5]], i32 [[TMP6]], i64 3
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <3 x i32> [[SPLIT]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x i32> poison, i32 [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <3 x i32> [[SPLIT1]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x i32> [[TMP9]], i32 [[TMP10]], i64 1
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <3 x i32> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x i32> [[TMP11]], i32 [[TMP12]], i64 2
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <3 x i32> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <4 x i32> [[TMP13]], i32 [[TMP14]], i64 3
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <3 x i32> [[SPLIT]], i64 2
; CHECK-NEXT:    [[TMP17:%.*]] = insertelement <4 x i32> poison, i32 [[TMP16]], i64 0
; CHECK-NEXT:    [[TMP18:%.*]] = extractelement <3 x i32> [[SPLIT1]], i64 2
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x i32> [[TMP17]], i32 [[TMP18]], i64 1
; CHECK-NEXT:    [[TMP20:%.*]] = extractelement <3 x i32> [[SPLIT2]], i64 2
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <4 x i32> [[TMP19]], i32 [[TMP20]], i64 2
; CHECK-NEXT:    [[TMP22:%.*]] = extractelement <3 x i32> [[SPLIT3]], i64 2
; CHECK-NEXT:    [[TMP23:%.*]] = insertelement <4 x i32> [[TMP21]], i32 [[TMP22]], i64 3
; CHECK-NEXT:    [[TMP24:%.*]] = shufflevector <4 x i32> [[TMP7]], <4 x i32> [[TMP15]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP25:%.*]] = shufflevector <4 x i32> [[TMP23]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP26:%.*]] = shufflevector <8 x i32> [[TMP24]], <8 x i32> [[TMP25]], <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
; CHECK-NEXT:    ret <12 x i32> [[TMP26]]
;
entry:
  %c  = call <12 x i32> @llvm.matrix.transpose.v12i32(<12 x i32> %a, i32 3, i32 4)
  ret <12 x i32> %c
}
