; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc-unknown-linux-gnu -verify-machineinstrs  -ppc-asm-full-reg-names | FileCheck %s --check-prefix=CHECK --check-prefix=PPC32
; This is already checked for in Atomics-64.ll
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64-unknown-linux-gnu  -ppc-asm-full-reg-names | FileCheck %s --check-prefix=CHECK --check-prefix=PPC64

; FIXME: we don't currently check for the operations themselves with CHECK-NEXT,
;   because they are implemented in a very messy way with lwarx/stwcx.
;   It should be fixed soon in another patch.

; We first check loads, for all sizes from i8 to i64.
; We also vary orderings to check for barriers.
define i8 @load_i8_unordered(ptr %mem) {
; CHECK-LABEL: load_i8_unordered:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lbz r3, 0(r3)
; CHECK-NEXT:    blr
  %val = load atomic i8, ptr %mem unordered, align 1
  ret i8 %val
}
define i16 @load_i16_monotonic(ptr %mem) {
; CHECK-LABEL: load_i16_monotonic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lhz r3, 0(r3)
; CHECK-NEXT:    blr
  %val = load atomic i16, ptr %mem monotonic, align 2
  ret i16 %val
}
define i32 @load_i32_acquire(ptr %mem) {
; PPC32-LABEL: load_i32_acquire:
; PPC32:       # %bb.0:
; PPC32-NEXT:    lwz r3, 0(r3)
; PPC32-NEXT:    cmpw cr7, r3, r3
; PPC32-NEXT:    bne- cr7, .+4
; PPC32-NEXT:    isync
; PPC32-NEXT:    blr
;
; PPC64-LABEL: load_i32_acquire:
; PPC64:       # %bb.0:
; PPC64-NEXT:    lwz r3, 0(r3)
; PPC64-NEXT:    cmpd cr7, r3, r3
; PPC64-NEXT:    bne- cr7, .+4
; PPC64-NEXT:    isync
; PPC64-NEXT:    blr
  %val = load atomic i32, ptr %mem acquire, align 4
; CHECK-PPC32: lwsync
; CHECK-PPC64: cmpw [[CR:cr[0-9]+]], [[VAL]], [[VAL]]
; CHECK-PPC64: bne- [[CR]], .+4
; CHECK-PPC64: isync
  ret i32 %val
}
define i64 @load_i64_seq_cst(ptr %mem) {
; PPC32-LABEL: load_i64_seq_cst:
; PPC32:       # %bb.0:
; PPC32-NEXT:    mflr r0
; PPC32-NEXT:    stwu r1, -16(r1)
; PPC32-NEXT:    stw r0, 20(r1)
; PPC32-NEXT:    .cfi_def_cfa_offset 16
; PPC32-NEXT:    .cfi_offset lr, 4
; PPC32-NEXT:    li r4, 5
; PPC32-NEXT:    bl __atomic_load_8
; PPC32-NEXT:    lwz r0, 20(r1)
; PPC32-NEXT:    addi r1, r1, 16
; PPC32-NEXT:    mtlr r0
; PPC32-NEXT:    blr
;
; PPC64-LABEL: load_i64_seq_cst:
; PPC64:       # %bb.0:
; PPC64-NEXT:    sync
; PPC64-NEXT:    ld r3, 0(r3)
; PPC64-NEXT:    cmpd cr7, r3, r3
; PPC64-NEXT:    bne- cr7, .+4
; PPC64-NEXT:    isync
; PPC64-NEXT:    blr
  %val = load atomic i64, ptr %mem seq_cst, align 8
; CHECK-PPC32: lwsync
; CHECK-PPC64: cmpw [[CR:cr[0-9]+]], [[VAL]], [[VAL]]
; CHECK-PPC64: bne- [[CR]], .+4
; CHECK-PPC64: isync
  ret i64 %val
}

; Stores
define void @store_i8_unordered(ptr %mem) {
; CHECK-LABEL: store_i8_unordered:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li r4, 42
; CHECK-NEXT:    stb r4, 0(r3)
; CHECK-NEXT:    blr
  store atomic i8 42, ptr %mem unordered, align 1
  ret void
}
define void @store_i16_monotonic(ptr %mem) {
; CHECK-LABEL: store_i16_monotonic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li r4, 42
; CHECK-NEXT:    sth r4, 0(r3)
; CHECK-NEXT:    blr
  store atomic i16 42, ptr %mem monotonic, align 2
  ret void
}
define void @store_i32_release(ptr %mem) {
; CHECK-LABEL: store_i32_release:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li r4, 42
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    stw r4, 0(r3)
; CHECK-NEXT:    blr
  store atomic i32 42, ptr %mem release, align 4
  ret void
}
define void @store_i64_seq_cst(ptr %mem) {
; PPC32-LABEL: store_i64_seq_cst:
; PPC32:       # %bb.0:
; PPC32-NEXT:    mflr r0
; PPC32-NEXT:    stwu r1, -16(r1)
; PPC32-NEXT:    stw r0, 20(r1)
; PPC32-NEXT:    .cfi_def_cfa_offset 16
; PPC32-NEXT:    .cfi_offset lr, 4
; PPC32-NEXT:    li r5, 0
; PPC32-NEXT:    li r6, 42
; PPC32-NEXT:    li r7, 5
; PPC32-NEXT:    bl __atomic_store_8
; PPC32-NEXT:    lwz r0, 20(r1)
; PPC32-NEXT:    addi r1, r1, 16
; PPC32-NEXT:    mtlr r0
; PPC32-NEXT:    blr
;
; PPC64-LABEL: store_i64_seq_cst:
; PPC64:       # %bb.0:
; PPC64-NEXT:    li r4, 42
; PPC64-NEXT:    sync
; PPC64-NEXT:    std r4, 0(r3)
; PPC64-NEXT:    blr
  store atomic i64 42, ptr %mem seq_cst, align 8
  ret void
}

; Atomic CmpXchg
define i8 @cas_strong_i8_sc_sc(ptr %mem) {
; PPC32-LABEL: cas_strong_i8_sc_sc:
; PPC32:       # %bb.0:
; PPC32-NEXT:    rlwinm r8, r3, 3, 27, 28
; PPC32-NEXT:    li r5, 1
; PPC32-NEXT:    li r6, 0
; PPC32-NEXT:    li r7, 255
; PPC32-NEXT:    rlwinm r4, r3, 0, 0, 29
; PPC32-NEXT:    xori r3, r8, 24
; PPC32-NEXT:    slw r8, r5, r3
; PPC32-NEXT:    slw r9, r6, r3
; PPC32-NEXT:    slw r5, r7, r3
; PPC32-NEXT:    and r6, r8, r5
; PPC32-NEXT:    and r7, r9, r5
; PPC32-NEXT:    sync
; PPC32-NEXT:  .LBB8_1:
; PPC32-NEXT:    lwarx r9, 0, r4
; PPC32-NEXT:    and r8, r9, r5
; PPC32-NEXT:    cmpw r8, r7
; PPC32-NEXT:    bne cr0, .LBB8_3
; PPC32-NEXT:  # %bb.2:
; PPC32-NEXT:    andc r9, r9, r5
; PPC32-NEXT:    or r9, r9, r6
; PPC32-NEXT:    stwcx. r9, 0, r4
; PPC32-NEXT:    bne cr0, .LBB8_1
; PPC32-NEXT:  .LBB8_3:
; PPC32-NEXT:    srw r3, r8, r3
; PPC32-NEXT:    lwsync
; PPC32-NEXT:    blr
;
; PPC64-LABEL: cas_strong_i8_sc_sc:
; PPC64:       # %bb.0:
; PPC64-NEXT:    rlwinm r8, r3, 3, 27, 28
; PPC64-NEXT:    li r5, 1
; PPC64-NEXT:    li r6, 0
; PPC64-NEXT:    li r7, 255
; PPC64-NEXT:    rldicr r4, r3, 0, 61
; PPC64-NEXT:    xori r3, r8, 24
; PPC64-NEXT:    slw r8, r5, r3
; PPC64-NEXT:    slw r9, r6, r3
; PPC64-NEXT:    slw r5, r7, r3
; PPC64-NEXT:    and r6, r8, r5
; PPC64-NEXT:    and r7, r9, r5
; PPC64-NEXT:    sync
; PPC64-NEXT:  .LBB8_1:
; PPC64-NEXT:    lwarx r9, 0, r4
; PPC64-NEXT:    and r8, r9, r5
; PPC64-NEXT:    cmpw r8, r7
; PPC64-NEXT:    bne cr0, .LBB8_3
; PPC64-NEXT:  # %bb.2:
; PPC64-NEXT:    andc r9, r9, r5
; PPC64-NEXT:    or r9, r9, r6
; PPC64-NEXT:    stwcx. r9, 0, r4
; PPC64-NEXT:    bne cr0, .LBB8_1
; PPC64-NEXT:  .LBB8_3:
; PPC64-NEXT:    srw r3, r8, r3
; PPC64-NEXT:    lwsync
; PPC64-NEXT:    blr
  %val = cmpxchg ptr %mem, i8 0, i8 1 seq_cst seq_cst
  %loaded = extractvalue { i8, i1} %val, 0
  ret i8 %loaded
}
define i16 @cas_weak_i16_acquire_acquire(ptr %mem) {
; PPC32-LABEL: cas_weak_i16_acquire_acquire:
; PPC32:       # %bb.0:
; PPC32-NEXT:    li r6, 0
; PPC32-NEXT:    rlwinm r4, r3, 3, 27, 27
; PPC32-NEXT:    li r5, 1
; PPC32-NEXT:    ori r7, r6, 65535
; PPC32-NEXT:    xori r4, r4, 16
; PPC32-NEXT:    slw r8, r5, r4
; PPC32-NEXT:    slw r9, r6, r4
; PPC32-NEXT:    slw r5, r7, r4
; PPC32-NEXT:    rlwinm r3, r3, 0, 0, 29
; PPC32-NEXT:    and r6, r8, r5
; PPC32-NEXT:    and r7, r9, r5
; PPC32-NEXT:  .LBB9_1:
; PPC32-NEXT:    lwarx r9, 0, r3
; PPC32-NEXT:    and r8, r9, r5
; PPC32-NEXT:    cmpw r8, r7
; PPC32-NEXT:    bne cr0, .LBB9_3
; PPC32-NEXT:  # %bb.2:
; PPC32-NEXT:    andc r9, r9, r5
; PPC32-NEXT:    or r9, r9, r6
; PPC32-NEXT:    stwcx. r9, 0, r3
; PPC32-NEXT:    bne cr0, .LBB9_1
; PPC32-NEXT:  .LBB9_3:
; PPC32-NEXT:    srw r3, r8, r4
; PPC32-NEXT:    lwsync
; PPC32-NEXT:    blr
;
; PPC64-LABEL: cas_weak_i16_acquire_acquire:
; PPC64:       # %bb.0:
; PPC64-NEXT:    li r6, 0
; PPC64-NEXT:    rlwinm r4, r3, 3, 27, 27
; PPC64-NEXT:    li r5, 1
; PPC64-NEXT:    ori r7, r6, 65535
; PPC64-NEXT:    xori r4, r4, 16
; PPC64-NEXT:    slw r8, r5, r4
; PPC64-NEXT:    slw r9, r6, r4
; PPC64-NEXT:    slw r5, r7, r4
; PPC64-NEXT:    rldicr r3, r3, 0, 61
; PPC64-NEXT:    and r6, r8, r5
; PPC64-NEXT:    and r7, r9, r5
; PPC64-NEXT:  .LBB9_1:
; PPC64-NEXT:    lwarx r9, 0, r3
; PPC64-NEXT:    and r8, r9, r5
; PPC64-NEXT:    cmpw r8, r7
; PPC64-NEXT:    bne cr0, .LBB9_3
; PPC64-NEXT:  # %bb.2:
; PPC64-NEXT:    andc r9, r9, r5
; PPC64-NEXT:    or r9, r9, r6
; PPC64-NEXT:    stwcx. r9, 0, r3
; PPC64-NEXT:    bne cr0, .LBB9_1
; PPC64-NEXT:  .LBB9_3:
; PPC64-NEXT:    srw r3, r8, r4
; PPC64-NEXT:    lwsync
; PPC64-NEXT:    blr
  %val = cmpxchg weak ptr %mem, i16 0, i16 1 acquire acquire
  %loaded = extractvalue { i16, i1} %val, 0
  ret i16 %loaded
}
define i32 @cas_strong_i32_acqrel_acquire(ptr %mem) {
; CHECK-LABEL: cas_strong_i32_acqrel_acquire:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li r5, 1
; CHECK-NEXT:    lwsync
; CHECK-NEXT:  .LBB10_1:
; CHECK-NEXT:    lwarx r4, 0, r3
; CHECK-NEXT:    cmpwi r4, 0
; CHECK-NEXT:    bne cr0, .LBB10_3
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    stwcx. r5, 0, r3
; CHECK-NEXT:    bne cr0, .LBB10_1
; CHECK-NEXT:  .LBB10_3:
; CHECK-NEXT:    mr r3, r4
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %val = cmpxchg ptr %mem, i32 0, i32 1 acq_rel acquire
  %loaded = extractvalue { i32, i1} %val, 0
  ret i32 %loaded
}
define i64 @cas_weak_i64_release_monotonic(ptr %mem) {
; PPC32-LABEL: cas_weak_i64_release_monotonic:
; PPC32:       # %bb.0:
; PPC32-NEXT:    mflr r0
; PPC32-NEXT:    stwu r1, -16(r1)
; PPC32-NEXT:    stw r0, 20(r1)
; PPC32-NEXT:    .cfi_def_cfa_offset 16
; PPC32-NEXT:    .cfi_offset lr, 4
; PPC32-NEXT:    li r4, 0
; PPC32-NEXT:    stw r4, 12(r1)
; PPC32-NEXT:    li r5, 0
; PPC32-NEXT:    stw r4, 8(r1)
; PPC32-NEXT:    addi r4, r1, 8
; PPC32-NEXT:    li r6, 1
; PPC32-NEXT:    li r7, 3
; PPC32-NEXT:    li r8, 0
; PPC32-NEXT:    bl __atomic_compare_exchange_8
; PPC32-NEXT:    lwz r4, 12(r1)
; PPC32-NEXT:    lwz r3, 8(r1)
; PPC32-NEXT:    lwz r0, 20(r1)
; PPC32-NEXT:    addi r1, r1, 16
; PPC32-NEXT:    mtlr r0
; PPC32-NEXT:    blr
;
; PPC64-LABEL: cas_weak_i64_release_monotonic:
; PPC64:       # %bb.0:
; PPC64-NEXT:    li r5, 1
; PPC64-NEXT:    lwsync
; PPC64-NEXT:  .LBB11_1:
; PPC64-NEXT:    ldarx r4, 0, r3
; PPC64-NEXT:    cmpdi r4, 0
; PPC64-NEXT:    bne cr0, .LBB11_3
; PPC64-NEXT:  # %bb.2:
; PPC64-NEXT:    stdcx. r5, 0, r3
; PPC64-NEXT:    bne cr0, .LBB11_1
; PPC64-NEXT:  .LBB11_3:
; PPC64-NEXT:    mr r3, r4
; PPC64-NEXT:    blr
  %val = cmpxchg weak ptr %mem, i64 0, i64 1 release monotonic
  %loaded = extractvalue { i64, i1} %val, 0
  ret i64 %loaded
}

; AtomicRMW
define i8 @add_i8_monotonic(ptr %mem, i8 %operand) {
; PPC32-LABEL: add_i8_monotonic:
; PPC32:       # %bb.0:
; PPC32-NEXT:    rlwinm r7, r3, 3, 27, 28
; PPC32-NEXT:    li r6, 255
; PPC32-NEXT:    rlwinm r5, r3, 0, 0, 29
; PPC32-NEXT:    xori r3, r7, 24
; PPC32-NEXT:    slw r4, r4, r3
; PPC32-NEXT:    slw r6, r6, r3
; PPC32-NEXT:  .LBB12_1:
; PPC32-NEXT:    lwarx r7, 0, r5
; PPC32-NEXT:    add r8, r4, r7
; PPC32-NEXT:    andc r9, r7, r6
; PPC32-NEXT:    and r8, r8, r6
; PPC32-NEXT:    or r8, r8, r9
; PPC32-NEXT:    stwcx. r8, 0, r5
; PPC32-NEXT:    bne cr0, .LBB12_1
; PPC32-NEXT:  # %bb.2:
; PPC32-NEXT:    srw r3, r7, r3
; PPC32-NEXT:    clrlwi r3, r3, 24
; PPC32-NEXT:    blr
;
; PPC64-LABEL: add_i8_monotonic:
; PPC64:       # %bb.0:
; PPC64-NEXT:    rlwinm r7, r3, 3, 27, 28
; PPC64-NEXT:    li r6, 255
; PPC64-NEXT:    rldicr r5, r3, 0, 61
; PPC64-NEXT:    xori r3, r7, 24
; PPC64-NEXT:    slw r4, r4, r3
; PPC64-NEXT:    slw r6, r6, r3
; PPC64-NEXT:  .LBB12_1:
; PPC64-NEXT:    lwarx r7, 0, r5
; PPC64-NEXT:    add r8, r4, r7
; PPC64-NEXT:    andc r9, r7, r6
; PPC64-NEXT:    and r8, r8, r6
; PPC64-NEXT:    or r8, r8, r9
; PPC64-NEXT:    stwcx. r8, 0, r5
; PPC64-NEXT:    bne cr0, .LBB12_1
; PPC64-NEXT:  # %bb.2:
; PPC64-NEXT:    srw r3, r7, r3
; PPC64-NEXT:    clrlwi r3, r3, 24
; PPC64-NEXT:    blr
  %val = atomicrmw add ptr %mem, i8 %operand monotonic
  ret i8 %val
}
define i16 @xor_i16_seq_cst(ptr %mem, i16 %operand) {
; PPC32-LABEL: xor_i16_seq_cst:
; PPC32:       # %bb.0:
; PPC32-NEXT:    li r5, 0
; PPC32-NEXT:    rlwinm r6, r3, 3, 27, 27
; PPC32-NEXT:    ori r7, r5, 65535
; PPC32-NEXT:    xori r5, r6, 16
; PPC32-NEXT:    rlwinm r3, r3, 0, 0, 29
; PPC32-NEXT:    slw r4, r4, r5
; PPC32-NEXT:    slw r6, r7, r5
; PPC32-NEXT:    sync
; PPC32-NEXT:  .LBB13_1:
; PPC32-NEXT:    lwarx r7, 0, r3
; PPC32-NEXT:    xor r8, r4, r7
; PPC32-NEXT:    andc r9, r7, r6
; PPC32-NEXT:    and r8, r8, r6
; PPC32-NEXT:    or r8, r8, r9
; PPC32-NEXT:    stwcx. r8, 0, r3
; PPC32-NEXT:    bne cr0, .LBB13_1
; PPC32-NEXT:  # %bb.2:
; PPC32-NEXT:    srw r3, r7, r5
; PPC32-NEXT:    clrlwi r3, r3, 16
; PPC32-NEXT:    lwsync
; PPC32-NEXT:    blr
;
; PPC64-LABEL: xor_i16_seq_cst:
; PPC64:       # %bb.0:
; PPC64-NEXT:    li r5, 0
; PPC64-NEXT:    rlwinm r6, r3, 3, 27, 27
; PPC64-NEXT:    ori r7, r5, 65535
; PPC64-NEXT:    xori r5, r6, 16
; PPC64-NEXT:    rldicr r3, r3, 0, 61
; PPC64-NEXT:    slw r4, r4, r5
; PPC64-NEXT:    slw r6, r7, r5
; PPC64-NEXT:    sync
; PPC64-NEXT:  .LBB13_1:
; PPC64-NEXT:    lwarx r7, 0, r3
; PPC64-NEXT:    xor r8, r4, r7
; PPC64-NEXT:    andc r9, r7, r6
; PPC64-NEXT:    and r8, r8, r6
; PPC64-NEXT:    or r8, r8, r9
; PPC64-NEXT:    stwcx. r8, 0, r3
; PPC64-NEXT:    bne cr0, .LBB13_1
; PPC64-NEXT:  # %bb.2:
; PPC64-NEXT:    srw r3, r7, r5
; PPC64-NEXT:    clrlwi r3, r3, 16
; PPC64-NEXT:    lwsync
; PPC64-NEXT:    blr
  %val = atomicrmw xor ptr %mem, i16 %operand seq_cst
  ret i16 %val
}
define i32 @xchg_i32_acq_rel(ptr %mem, i32 %operand) {
; CHECK-LABEL: xchg_i32_acq_rel:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lwsync
; CHECK-NEXT:  .LBB14_1:
; CHECK-NEXT:    lwarx r5, 0, r3
; CHECK-NEXT:    stwcx. r4, 0, r3
; CHECK-NEXT:    bne cr0, .LBB14_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    mr r3, r5
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %val = atomicrmw xchg ptr %mem, i32 %operand acq_rel
  ret i32 %val
}
define i64 @and_i64_release(ptr %mem, i64 %operand) {
; PPC32-LABEL: and_i64_release:
; PPC32:       # %bb.0:
; PPC32-NEXT:    mflr r0
; PPC32-NEXT:    stwu r1, -16(r1)
; PPC32-NEXT:    stw r0, 20(r1)
; PPC32-NEXT:    .cfi_def_cfa_offset 16
; PPC32-NEXT:    .cfi_offset lr, 4
; PPC32-NEXT:    li r7, 3
; PPC32-NEXT:    bl __atomic_fetch_and_8
; PPC32-NEXT:    lwz r0, 20(r1)
; PPC32-NEXT:    addi r1, r1, 16
; PPC32-NEXT:    mtlr r0
; PPC32-NEXT:    blr
;
; PPC64-LABEL: and_i64_release:
; PPC64:       # %bb.0:
; PPC64-NEXT:    lwsync
; PPC64-NEXT:  .LBB15_1:
; PPC64-NEXT:    ldarx r5, 0, r3
; PPC64-NEXT:    and r6, r4, r5
; PPC64-NEXT:    stdcx. r6, 0, r3
; PPC64-NEXT:    bne cr0, .LBB15_1
; PPC64-NEXT:  # %bb.2:
; PPC64-NEXT:    mr r3, r5
; PPC64-NEXT:    blr
  %val = atomicrmw and ptr %mem, i64 %operand release
  ret i64 %val
}
