; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=i686-linux-gnu -atomic-expand %s | FileCheck %s


define i256 @atomic_load256_libcall(ptr %ptr) nounwind {
; CHECK-LABEL: @atomic_load256_libcall(
; CHECK-NEXT:    [[TMP1:%.*]] = alloca i256, align 16
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 32, ptr [[TMP1]])
; CHECK-NEXT:    call void @__atomic_load(i32 32, ptr [[PTR:%.*]], ptr [[TMP1]], i32 0)
; CHECK-NEXT:    [[TMP2:%.*]] = load i256, ptr [[TMP1]], align 16
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 32, ptr [[TMP1]])
; CHECK-NEXT:    ret i256 [[TMP2]]
;
  %result = load atomic i256, ptr %ptr unordered, align 16
  ret i256 %result
}

define i256 @atomic_load256_libcall_as1(ptr addrspace(1) %ptr) nounwind {
; CHECK-LABEL: @atomic_load256_libcall_as1(
; CHECK-NEXT:    [[TMP1:%.*]] = addrspacecast ptr addrspace(1) [[PTR:%.*]] to ptr
; CHECK-NEXT:    [[TMP2:%.*]] = alloca i256, align 16
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 32, ptr [[TMP2]])
; CHECK-NEXT:    call void @__atomic_load(i32 32, ptr [[TMP1]], ptr [[TMP2]], i32 0)
; CHECK-NEXT:    [[TMP3:%.*]] = load i256, ptr [[TMP2]], align 16
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 32, ptr [[TMP2]])
; CHECK-NEXT:    ret i256 [[TMP3]]
;
  %result = load atomic i256, ptr addrspace(1) %ptr unordered, align 16
  ret i256 %result
}
