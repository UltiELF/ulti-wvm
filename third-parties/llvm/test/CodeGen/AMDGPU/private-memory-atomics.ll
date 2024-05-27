; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: opt -S -mtriple=amdgcn-- -mcpu=tahiti -atomic-expand < %s | FileCheck -check-prefix=IR %s
; RUN: llc -mtriple=amdgcn-- -mcpu=tahiti < %s | FileCheck -check-prefix=GCN %s

define i32 @load_atomic_private_seq_cst_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @load_atomic_private_seq_cst_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0:[0-9]+]] {
; IR-NEXT:    [[LOAD:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[LOAD]]
;
; GCN-LABEL: load_atomic_private_seq_cst_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v0, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %load = load atomic i32, ptr addrspace(5) %ptr seq_cst, align 4
  ret i32 %load
}

define i64 @load_atomic_private_seq_cst_i64(ptr addrspace(5) %ptr) {
; IR-LABEL: define i64 @load_atomic_private_seq_cst_i64(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[LOAD:%.*]] = load i64, ptr addrspace(5) [[PTR]], align 8
; IR-NEXT:    ret i64 [[LOAD]]
;
; GCN-LABEL: load_atomic_private_seq_cst_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v1, vcc, 4, v0
; GCN-NEXT:    buffer_load_dword v0, v0, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v1, v1, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %load = load atomic i64, ptr addrspace(5) %ptr seq_cst, align 8
  ret i64 %load
}

define void @atomic_store_seq_cst_i32(ptr addrspace(5) %ptr, i32 %val) {
; IR-LABEL: define void @atomic_store_seq_cst_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]], i32 [[VAL:%.*]]) #[[ATTR0]] {
; IR-NEXT:    store i32 [[VAL]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_store_seq_cst_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  store atomic i32 %val, ptr addrspace(5) %ptr seq_cst, align 4
  ret void
}

define void @atomic_store_seq_cst_i64(ptr addrspace(5) %ptr, i64 %val) {
; IR-LABEL: define void @atomic_store_seq_cst_i64(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]], i64 [[VAL:%.*]]) #[[ATTR0]] {
; IR-NEXT:    store i64 [[VAL]], ptr addrspace(5) [[PTR]], align 8
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_store_seq_cst_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v3, vcc, 4, v0
; GCN-NEXT:    buffer_store_dword v2, v3, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  store atomic i64 %val, ptr addrspace(5) %ptr seq_cst, align 8
  ret void
}

define i32 @load_atomic_private_seq_cst_syncscope_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @load_atomic_private_seq_cst_syncscope_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[LOAD:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[LOAD]]
;
; GCN-LABEL: load_atomic_private_seq_cst_syncscope_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v0, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %load = load atomic i32, ptr addrspace(5) %ptr syncscope("agent") seq_cst, align 4
  ret i32 %load
}

define void @atomic_store_seq_cst_syncscope_i32(ptr addrspace(5) %ptr, i32 %val) {
; IR-LABEL: define void @atomic_store_seq_cst_syncscope_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]], i32 [[VAL:%.*]]) #[[ATTR0]] {
; IR-NEXT:    store i32 [[VAL]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_store_seq_cst_syncscope_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  store atomic i32 %val, ptr addrspace(5) %ptr syncscope("agent") seq_cst, align 4
  ret void
}

define i32 @cmpxchg_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @cmpxchg_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; IR-NEXT:    [[TMP3:%.*]] = select i1 [[TMP2]], i32 1, i32 [[TMP1]]
; IR-NEXT:    store i32 [[TMP3]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP4:%.*]] = insertvalue { i32, i1 } poison, i32 [[TMP1]], 0
; IR-NEXT:    [[TMP5:%.*]] = insertvalue { i32, i1 } [[TMP4]], i1 [[TMP2]], 1
; IR-NEXT:    [[RESULT_0:%.*]] = extractvalue { i32, i1 } [[TMP5]], 0
; IR-NEXT:    [[RESULT_1:%.*]] = extractvalue { i32, i1 } [[TMP5]], 1
; IR-NEXT:    store i1 [[RESULT_1]], ptr addrspace(1) poison, align 1
; IR-NEXT:    ret i32 [[RESULT_0]]
;
; GCN-LABEL: cmpxchg_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v1
; GCN-NEXT:    v_cndmask_b32_e64 v2, v1, 1, vcc
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GCN-NEXT:    buffer_store_byte v0, off, s[4:7], 0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = cmpxchg ptr addrspace(5) %ptr, i32 0, i32 1 acq_rel monotonic
  %result.0 = extractvalue { i32, i1 } %result, 0
  %result.1 = extractvalue { i32, i1 } %result, 1
  store i1 %result.1, ptr addrspace(1) poison
  ret i32 %result.0
}

define i64 @cmpxchg_private_i64(ptr addrspace(5) %ptr) {
; IR-LABEL: define i64 @cmpxchg_private_i64(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i64, ptr addrspace(5) [[PTR]], align 8
; IR-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 0
; IR-NEXT:    [[TMP3:%.*]] = select i1 [[TMP2]], i64 1, i64 [[TMP1]]
; IR-NEXT:    store i64 [[TMP3]], ptr addrspace(5) [[PTR]], align 8
; IR-NEXT:    [[TMP4:%.*]] = insertvalue { i64, i1 } poison, i64 [[TMP1]], 0
; IR-NEXT:    [[TMP5:%.*]] = insertvalue { i64, i1 } [[TMP4]], i1 [[TMP2]], 1
; IR-NEXT:    [[RESULT_0:%.*]] = extractvalue { i64, i1 } [[TMP5]], 0
; IR-NEXT:    [[RESULT_1:%.*]] = extractvalue { i64, i1 } [[TMP5]], 1
; IR-NEXT:    store i1 [[RESULT_1]], ptr addrspace(1) poison, align 1
; IR-NEXT:    ret i64 [[RESULT_0]]
;
; GCN-LABEL: cmpxchg_private_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v2, v0
; GCN-NEXT:    v_add_i32_e32 v3, vcc, 4, v2
; GCN-NEXT:    buffer_load_dword v1, v3, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v0, v0, s[0:3], 0 offen
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_eq_u64_e32 vcc, 0, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e64 v4, v1, 0, vcc
; GCN-NEXT:    buffer_store_dword v4, v3, s[0:3], 0 offen
; GCN-NEXT:    v_cndmask_b32_e64 v3, v0, 1, vcc
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_cndmask_b32_e64 v4, 0, 1, vcc
; GCN-NEXT:    buffer_store_dword v3, v2, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_byte v4, off, s[4:7], 0
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = cmpxchg ptr addrspace(5) %ptr, i64 0, i64 1 acq_rel monotonic
  %result.0 = extractvalue { i64, i1 } %result, 0
  %result.1 = extractvalue { i64, i1 } %result, 1
  store i1 %result.1, ptr addrspace(1) poison
  ret i64 %result.0
}


define i32 @atomicrmw_xchg_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_xchg_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    store i32 4, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_xchg_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v2, 4
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(1)
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw xchg ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_add_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_add_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = add i32 [[TMP1]], 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_add_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v2, vcc, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw add ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_sub_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_sub_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = sub i32 [[TMP1]], 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_sub_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v2, vcc, -4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw sub ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_and_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_and_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = and i32 [[TMP1]], 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_and_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw and ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_nand_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_nand_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 4
; IR-NEXT:    [[NEW:%.*]] = xor i32 [[TMP2]], -1
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_nand_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_not_b32_e32 v2, v1
; GCN-NEXT:    v_or_b32_e32 v2, -5, v2
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw nand ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_or_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_or_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = or i32 [[TMP1]], 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_or_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_or_b32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw or ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_xor_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_xor_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = xor i32 [[TMP1]], 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_xor_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_xor_b32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw xor ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_max_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_max_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP1]], 4
; IR-NEXT:    [[NEW:%.*]] = select i1 [[TMP2]], i32 [[TMP1]], i32 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_max_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_max_i32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw max ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_min_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_min_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = icmp sle i32 [[TMP1]], 4
; IR-NEXT:    [[NEW:%.*]] = select i1 [[TMP2]], i32 [[TMP1]], i32 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_min_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_min_i32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw min ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_umax_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_umax_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = icmp ugt i32 [[TMP1]], 4
; IR-NEXT:    [[NEW:%.*]] = select i1 [[TMP2]], i32 [[TMP1]], i32 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_umax_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_max_u32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw umax ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_umin_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_umin_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = icmp ule i32 [[TMP1]], 4
; IR-NEXT:    [[NEW:%.*]] = select i1 [[TMP2]], i32 [[TMP1]], i32 4
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_umin_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_min_u32_e32 v2, 4, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw umin ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define float @atomicrmw_fadd_private_f32(ptr addrspace(5) %ptr) {
; IR-LABEL: define float @atomicrmw_fadd_private_f32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load float, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = fadd float [[TMP1]], 2.000000e+00
; IR-NEXT:    store float [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret float [[TMP1]]
;
; GCN-LABEL: atomicrmw_fadd_private_f32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_f32_e32 v2, 2.0, v1
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw fadd ptr addrspace(5) %ptr, float 2.0 seq_cst
  ret float %result
}

define bfloat @atomicrmw_fadd_private_bf16(ptr addrspace(5) %ptr) {
; IR-LABEL: define bfloat @atomicrmw_fadd_private_bf16(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load bfloat, ptr addrspace(5) [[PTR]], align 2
; IR-NEXT:    [[NEW:%.*]] = fadd bfloat [[TMP1]], 0xR4000
; IR-NEXT:    store bfloat [[NEW]], ptr addrspace(5) [[PTR]], align 2
; IR-NEXT:    ret bfloat [[TMP1]]
;
; GCN-LABEL: atomicrmw_fadd_private_bf16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_ushort v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GCN-NEXT:    v_add_f32_e32 v2, 2.0, v1
; GCN-NEXT:    v_lshrrev_b32_e32 v2, 16, v2
; GCN-NEXT:    buffer_store_short v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw fadd ptr addrspace(5) %ptr, bfloat 2.0 seq_cst
  ret bfloat %result
}

define float @atomicrmw_fsub_private_i32(ptr addrspace(5) %ptr, float %val) {
; IR-LABEL: define float @atomicrmw_fsub_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]], float [[VAL:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load float, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[NEW:%.*]] = fsub float [[TMP1]], [[VAL]]
; IR-NEXT:    store float [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret float [[TMP1]]
;
; GCN-LABEL: atomicrmw_fsub_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_sub_f32_e32 v1, v2, v1
; GCN-NEXT:    buffer_store_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v2
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw fsub ptr addrspace(5) %ptr, float %val seq_cst
  ret float %result
}

define amdgpu_kernel void @alloca_promote_atomicrmw_private_lds_promote(ptr addrspace(1) %out, i32 %in) nounwind {
; IR-LABEL: define amdgpu_kernel void @alloca_promote_atomicrmw_private_lds_promote(
; IR-SAME: ptr addrspace(1) [[OUT:%.*]], i32 [[IN:%.*]]) #[[ATTR1:[0-9]+]] {
; IR-NEXT:  entry:
; IR-NEXT:    [[TMP:%.*]] = alloca [2 x i32], align 4, addrspace(5)
; IR-NEXT:    [[GEP2:%.*]] = getelementptr inbounds [2 x i32], ptr addrspace(5) [[TMP]], i32 0, i32 1
; IR-NEXT:    store i32 0, ptr addrspace(5) [[TMP]], align 4
; IR-NEXT:    store i32 1, ptr addrspace(5) [[GEP2]], align 4
; IR-NEXT:    [[GEP3:%.*]] = getelementptr inbounds [2 x i32], ptr addrspace(5) [[TMP]], i32 0, i32 [[IN]]
; IR-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspace(5) [[GEP3]], align 4
; IR-NEXT:    [[NEW:%.*]] = add i32 [[TMP0]], 7
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[GEP3]], align 4
; IR-NEXT:    store i32 [[TMP0]], ptr addrspace(1) [[OUT]], align 4
; IR-NEXT:    ret void
;
; GCN-LABEL: alloca_promote_atomicrmw_private_lds_promote:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dword s4, s[0:1], 0xb
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_eq_u32 s4, 1
; GCN-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
entry:
  %tmp = alloca [2 x i32], addrspace(5)
  %gep2 = getelementptr inbounds [2 x i32], ptr addrspace(5) %tmp, i32 0, i32 1
  store i32 0, ptr addrspace(5) %tmp
  store i32 1, ptr addrspace(5) %gep2
  %gep3 = getelementptr inbounds [2 x i32], ptr addrspace(5) %tmp, i32 0, i32 %in
  %rmw = atomicrmw add ptr addrspace(5) %gep3, i32 7 acq_rel
  store i32 %rmw, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @alloca_promote_cmpxchg_private(ptr addrspace(1) %out, i32 %in) nounwind {
; IR-LABEL: define amdgpu_kernel void @alloca_promote_cmpxchg_private(
; IR-SAME: ptr addrspace(1) [[OUT:%.*]], i32 [[IN:%.*]]) #[[ATTR1]] {
; IR-NEXT:  entry:
; IR-NEXT:    [[TMP:%.*]] = alloca [2 x i32], align 4, addrspace(5)
; IR-NEXT:    [[GEP2:%.*]] = getelementptr inbounds [2 x i32], ptr addrspace(5) [[TMP]], i32 0, i32 1
; IR-NEXT:    store i32 0, ptr addrspace(5) [[TMP]], align 4
; IR-NEXT:    store i32 1, ptr addrspace(5) [[GEP2]], align 4
; IR-NEXT:    [[GEP3:%.*]] = getelementptr inbounds [2 x i32], ptr addrspace(5) [[TMP]], i32 0, i32 [[IN]]
; IR-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspace(5) [[GEP3]], align 4
; IR-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[TMP0]], 0
; IR-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i32 1, i32 [[TMP0]]
; IR-NEXT:    store i32 [[TMP2]], ptr addrspace(5) [[GEP3]], align 4
; IR-NEXT:    [[TMP3:%.*]] = insertvalue { i32, i1 } poison, i32 [[TMP0]], 0
; IR-NEXT:    [[TMP4:%.*]] = insertvalue { i32, i1 } [[TMP3]], i1 [[TMP1]], 1
; IR-NEXT:    [[VAL:%.*]] = extractvalue { i32, i1 } [[TMP4]], 0
; IR-NEXT:    store i32 [[VAL]], ptr addrspace(1) [[OUT]], align 4
; IR-NEXT:    ret void
;
; GCN-LABEL: alloca_promote_cmpxchg_private:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dword s4, s[0:1], 0xb
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_eq_u32 s4, 1
; GCN-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
entry:
  %tmp = alloca [2 x i32], addrspace(5)
  %gep2 = getelementptr inbounds [2 x i32], ptr addrspace(5) %tmp, i32 0, i32 1
  store i32 0, ptr addrspace(5) %tmp
  store i32 1, ptr addrspace(5) %gep2
  %gep3 = getelementptr inbounds [2 x i32], ptr addrspace(5) %tmp, i32 0, i32 %in
  %xchg = cmpxchg ptr addrspace(5) %gep3, i32 0, i32 1 acq_rel monotonic
  %val = extractvalue { i32, i1 } %xchg, 0
  store i32 %val, ptr addrspace(1) %out
  ret void
}

define i32 @atomicrmw_inc_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_inc_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = add i32 [[TMP1]], 1
; IR-NEXT:    [[TMP3:%.*]] = icmp uge i32 [[TMP1]], 4
; IR-NEXT:    [[NEW:%.*]] = select i1 [[TMP3]], i32 0, i32 [[TMP2]]
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_inc_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v2, vcc, 1, v1
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 4, v1
; GCN-NEXT:    v_cndmask_b32_e32 v2, 0, v2, vcc
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw uinc_wrap ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}

define i32 @atomicrmw_dec_private_i32(ptr addrspace(5) %ptr) {
; IR-LABEL: define i32 @atomicrmw_dec_private_i32(
; IR-SAME: ptr addrspace(5) [[PTR:%.*]]) #[[ATTR0]] {
; IR-NEXT:    [[TMP1:%.*]] = load i32, ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    [[TMP2:%.*]] = sub i32 [[TMP1]], 1
; IR-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[TMP1]], 0
; IR-NEXT:    [[TMP4:%.*]] = icmp ugt i32 [[TMP1]], 4
; IR-NEXT:    [[TMP5:%.*]] = or i1 [[TMP3]], [[TMP4]]
; IR-NEXT:    [[NEW:%.*]] = select i1 [[TMP5]], i32 4, i32 [[TMP2]]
; IR-NEXT:    store i32 [[NEW]], ptr addrspace(5) [[PTR]], align 4
; IR-NEXT:    ret i32 [[TMP1]]
;
; GCN-LABEL: atomicrmw_dec_private_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v2, vcc, -1, v1
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v1
; GCN-NEXT:    v_cmp_lt_u32_e64 s[4:5], 4, v1
; GCN-NEXT:    s_or_b64 s[4:5], vcc, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v2, v2, 4, s[4:5]
; GCN-NEXT:    buffer_store_dword v2, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v0, v1
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %result = atomicrmw udec_wrap ptr addrspace(5) %ptr, i32 4 seq_cst
  ret i32 %result
}
