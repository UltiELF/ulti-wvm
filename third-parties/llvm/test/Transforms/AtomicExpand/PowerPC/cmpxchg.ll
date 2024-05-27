; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -atomic-expand -S -mtriple=powerpc64-unknown-unknown \
; RUN:   -mcpu=pwr8 %s | FileCheck %s
; RUN: opt -atomic-expand -S -mtriple=powerpc64-unknown-unknown \
; RUN:   -mcpu=pwr7 %s | FileCheck --check-prefix=PWR7 %s

define i1 @test_cmpxchg_seq_cst(ptr %addr, i128 %desire, i128 %new) {
; CHECK-LABEL: @test_cmpxchg_seq_cst(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_LO:%.*]] = trunc i128 [[DESIRE:%.*]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = lshr i128 [[DESIRE]], 64
; CHECK-NEXT:    [[CMP_HI:%.*]] = trunc i128 [[TMP0]] to i64
; CHECK-NEXT:    [[NEW_LO:%.*]] = trunc i128 [[NEW:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i128 [[NEW]], 64
; CHECK-NEXT:    [[NEW_HI:%.*]] = trunc i128 [[TMP1]] to i64
; CHECK-NEXT:    call void @llvm.ppc.sync()
; CHECK-NEXT:    [[TMP2:%.*]] = call { i64, i64 } @llvm.ppc.cmpxchg.i128(ptr [[ADDR:%.*]], i64 [[CMP_LO]], i64 [[CMP_HI]], i64 [[NEW_LO]], i64 [[NEW_HI]])
; CHECK-NEXT:    call void @llvm.ppc.lwsync()
; CHECK-NEXT:    [[LO:%.*]] = extractvalue { i64, i64 } [[TMP2]], 0
; CHECK-NEXT:    [[HI:%.*]] = extractvalue { i64, i64 } [[TMP2]], 1
; CHECK-NEXT:    [[LO64:%.*]] = zext i64 [[LO]] to i128
; CHECK-NEXT:    [[HI64:%.*]] = zext i64 [[HI]] to i128
; CHECK-NEXT:    [[TMP3:%.*]] = shl i128 [[HI64]], 64
; CHECK-NEXT:    [[VAL64:%.*]] = or i128 [[LO64]], [[TMP3]]
; CHECK-NEXT:    [[TMP4:%.*]] = insertvalue { i128, i1 } poison, i128 [[VAL64]], 0
; CHECK-NEXT:    [[SUCCESS:%.*]] = icmp eq i128 [[DESIRE]], [[VAL64]]
; CHECK-NEXT:    [[TMP5:%.*]] = insertvalue { i128, i1 } [[TMP4]], i1 [[SUCCESS]], 1
; CHECK-NEXT:    [[SUCC:%.*]] = extractvalue { i128, i1 } [[TMP5]], 1
; CHECK-NEXT:    ret i1 [[SUCC]]
;
; PWR7-LABEL: @test_cmpxchg_seq_cst(
; PWR7-NEXT:  entry:
; PWR7-NEXT:    [[TMP0:%.*]] = alloca i128, align 8
; PWR7-NEXT:    call void @llvm.lifetime.start.p0(i64 16, ptr [[TMP0]])
; PWR7-NEXT:    store i128 [[DESIRE:%.*]], ptr [[TMP0]], align 8
; PWR7-NEXT:    [[TMP1:%.*]] = call zeroext i1 @__atomic_compare_exchange_16(ptr [[ADDR:%.*]], ptr [[TMP0]], i128 [[NEW:%.*]], i32 5, i32 5)
; PWR7-NEXT:    [[TMP2:%.*]] = load i128, ptr [[TMP0]], align 8
; PWR7-NEXT:    call void @llvm.lifetime.end.p0(i64 16, ptr [[TMP0]])
; PWR7-NEXT:    [[TMP3:%.*]] = insertvalue { i128, i1 } poison, i128 [[TMP2]], 0
; PWR7-NEXT:    [[TMP4:%.*]] = insertvalue { i128, i1 } [[TMP3]], i1 [[TMP1]], 1
; PWR7-NEXT:    [[SUCC:%.*]] = extractvalue { i128, i1 } [[TMP4]], 1
; PWR7-NEXT:    ret i1 [[SUCC]]
;
entry:
  %pair = cmpxchg weak ptr %addr, i128 %desire, i128 %new seq_cst seq_cst
  %succ = extractvalue {i128, i1} %pair, 1
  ret i1 %succ
}
