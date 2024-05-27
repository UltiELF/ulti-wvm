; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=openmp-opt-postlink < %s | FileCheck %s --check-prefix=POSTLINK
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s --check-prefix=PRELINK

@client = internal addrspace(1) global i32 zeroinitializer, align 8
@__llvm_libc_rpc_client = protected local_unnamed_addr addrspace(1) global ptr addrspacecast (ptr addrspace(1) @client to ptr), align 8

;.
; POSTLINK-NOT: @[[CLIENT:[a-zA-Z0-9_$"\\.-]+]] = internal addrspace(1) global i32 0, align 8
; POSTLINK-NOT: @[[__LLVM_LIBC_RPC_CLIENT:[a-zA-Z0-9_$"\\.-]+]] = protected local_unnamed_addr addrspace(1) global ptr addrspacecast (ptr addrspace(1) @client to ptr), align 8
;.
; PRELINK: @[[CLIENT:[a-zA-Z0-9_$"\\.-]+]] = internal addrspace(1) global i32 0, align 8
; PRELINK: @[[__LLVM_LIBC_RPC_CLIENT:[a-zA-Z0-9_$"\\.-]+]] = protected local_unnamed_addr addrspace(1) global ptr addrspacecast (ptr addrspace(1) @client to ptr), align 8
;.
define void @a() {
; POSTLINK-LABEL: define {{[^@]+}}@a() {
; POSTLINK-NEXT:    ret void
;
; PRELINK-LABEL: define {{[^@]+}}@a() {
; PRELINK-NEXT:    ret void
;
  ret void
}

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"openmp", i32 50}
!2 = !{i32 7, !"openmp-device", i32 50}
