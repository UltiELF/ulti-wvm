; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=riscv64 -mattr=+v | FileCheck %s

define void @snork(ptr %arg, <vscale x 2 x i64> %arg1) {
; CHECK-LABEL: snork:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    vsetvli a2, zero, e64, m2, ta, ma
; CHECK-NEXT:    vmul.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 1
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vsoxei64.v v10, (a0), v8
; CHECK-NEXT:    ret
bb:
  %getelementptr = getelementptr inbounds <vscale x 2 x i32>, ptr %arg, <vscale x 2 x i64> %arg1
  tail call void @llvm.vp.scatter.nxv2i32.nxv2p0(<vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> poison, i32 1, i32 0), <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer), <vscale x 2 x ptr> align 4 %getelementptr, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer), i32 4)
  ret void
}

declare void @llvm.vp.scatter.nxv2i32.nxv2p0(<vscale x 2 x i32>, <vscale x 2 x ptr>, <vscale x 2 x i1>, i32)
