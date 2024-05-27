; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp %s -o - | FileCheck %s

define nonnull ptr @useafterloop(ptr nocapture noundef readonly %pSrcA, ptr nocapture noundef readonly %pSrcB, ptr noundef writeonly %pDst, i32 noundef %blockSize) {
; CHECK-LABEL: useafterloop:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:    mov r3, r2
; CHECK-NEXT:  .LBB0_1: @ %while.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [r0], #16
; CHECK-NEXT:    vldrw.u32 q1, [r1], #16
; CHECK-NEXT:    vadd.f32 q0, q1, q0
; CHECK-NEXT:    vstrb.8 q0, [r3], #16
; CHECK-NEXT:    le lr, .LBB0_1
; CHECK-NEXT:  @ %bb.2: @ %while.end
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %while.body

while.body:
  %pSrcA.addr.012 = phi ptr [ %pSrcA, %entry ], [ %add.ptr, %while.body ]
  %pSrcB.addr.011 = phi ptr [ %pSrcB, %entry ], [ %add.ptr1, %while.body ]
  %pDst.addr.010 = phi ptr [ %pDst, %entry ], [ %add.ptr2, %while.body ]
  %blkCnt.09 = phi i32 [ 64, %entry ], [ %dec, %while.body ]
  %0 = load <4 x float>, ptr %pSrcA.addr.012, align 4
  %1 = load <4 x float>, ptr %pSrcB.addr.011, align 4
  %2 = fadd fast <4 x float> %1, %0
  store <4 x float> %2, ptr %pDst.addr.010, align 4
  %add.ptr = getelementptr inbounds float, ptr %pSrcA.addr.012, i32 4
  %add.ptr1 = getelementptr inbounds float, ptr %pSrcB.addr.011, i32 4
  %add.ptr2 = getelementptr inbounds float, ptr %pDst.addr.010, i32 4
  %dec = add nsw i32 %blkCnt.09, -1
  %cmp.not = icmp eq i32 %dec, 0
  br i1 %cmp.not, label %while.end, label %while.body

while.end:
  ret ptr %pDst
}


define nonnull ptr @nouse(ptr nocapture noundef readonly %pSrcA, ptr nocapture noundef readonly %pSrcB, ptr noundef writeonly %pDst, i32 noundef %blockSize) {
; CHECK-LABEL: nouse:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:    mov r3, r2
; CHECK-NEXT:  .LBB1_1: @ %while.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [r0], #16
; CHECK-NEXT:    vldrw.u32 q1, [r1], #16
; CHECK-NEXT:    vadd.f32 q0, q1, q0
; CHECK-NEXT:    vstrb.8 q0, [r3], #16
; CHECK-NEXT:    le lr, .LBB1_1
; CHECK-NEXT:  @ %bb.2: @ %while.end
; CHECK-NEXT:    adds r0, r2, #4
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %while.body

while.body:
  %pSrcA.addr.012 = phi ptr [ %pSrcA, %entry ], [ %add.ptr, %while.body ]
  %pSrcB.addr.011 = phi ptr [ %pSrcB, %entry ], [ %add.ptr1, %while.body ]
  %pDst.addr.010 = phi ptr [ %pDst, %entry ], [ %add.ptr2, %while.body ]
  %blkCnt.09 = phi i32 [ 64, %entry ], [ %dec, %while.body ]
  %0 = load <4 x float>, ptr %pSrcA.addr.012, align 4
  %1 = load <4 x float>, ptr %pSrcB.addr.011, align 4
  %2 = fadd fast <4 x float> %1, %0
  store <4 x float> %2, ptr %pDst.addr.010, align 4
  %add.ptr = getelementptr inbounds float, ptr %pSrcA.addr.012, i32 4
  %add.ptr1 = getelementptr inbounds float, ptr %pSrcB.addr.011, i32 4
  %add.ptr2 = getelementptr inbounds float, ptr %pDst.addr.010, i32 4
  %dec = add nsw i32 %blkCnt.09, -1
  %cmp.not = icmp eq i32 %dec, 0
  br i1 %cmp.not, label %while.end, label %while.body

while.end:
  %add.ptr3 = getelementptr inbounds float, ptr %pDst, i32 1
  ret ptr %add.ptr3
}

define nofpclass(nan inf) float @manyusesafterloop(ptr nocapture noundef readonly %pSrcA, ptr nocapture noundef readonly %pSrcB, ptr nocapture noundef %pDst, i32 noundef %blockSize) {
; CHECK-LABEL: manyusesafterloop:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:    mov r12, r0
; CHECK-NEXT:    mov r3, r1
; CHECK-NEXT:    mov r4, r2
; CHECK-NEXT:  .LBB2_1: @ %while.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [r12], #16
; CHECK-NEXT:    vldrw.u32 q1, [r3], #16
; CHECK-NEXT:    vadd.f32 q0, q1, q0
; CHECK-NEXT:    vstrb.8 q0, [r4], #16
; CHECK-NEXT:    le lr, .LBB2_1
; CHECK-NEXT:  @ %bb.2: @ %while.end
; CHECK-NEXT:    vldr s0, [r2]
; CHECK-NEXT:    vldr s2, [r0]
; CHECK-NEXT:    vadd.f32 s0, s2, s0
; CHECK-NEXT:    vldr s2, [r1]
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    pop {r4, pc}
entry:
  br label %while.body

while.body:
  %pSrcA.addr.016 = phi ptr [ %pSrcA, %entry ], [ %add.ptr, %while.body ]
  %pSrcB.addr.015 = phi ptr [ %pSrcB, %entry ], [ %add.ptr1, %while.body ]
  %pDst.addr.014 = phi ptr [ %pDst, %entry ], [ %add.ptr2, %while.body ]
  %blkCnt.013 = phi i32 [ 64, %entry ], [ %dec, %while.body ]
  %0 = load <4 x float>, ptr %pSrcA.addr.016, align 4
  %1 = load <4 x float>, ptr %pSrcB.addr.015, align 4
  %2 = fadd fast <4 x float> %1, %0
  store <4 x float> %2, ptr %pDst.addr.014, align 4
  %add.ptr = getelementptr inbounds float, ptr %pSrcA.addr.016, i32 4
  %add.ptr1 = getelementptr inbounds float, ptr %pSrcB.addr.015, i32 4
  %add.ptr2 = getelementptr inbounds float, ptr %pDst.addr.014, i32 4
  %dec = add nsw i32 %blkCnt.013, -1
  %cmp.not = icmp eq i32 %dec, 0
  br i1 %cmp.not, label %while.end, label %while.body

while.end:
  %3 = load float, ptr %pDst, align 4
  %4 = load float, ptr %pSrcA, align 4
  %add = fadd fast float %4, %3
  %5 = load float, ptr %pSrcB, align 4
  %add5 = fadd fast float %add, %5
  ret float %add5
}

