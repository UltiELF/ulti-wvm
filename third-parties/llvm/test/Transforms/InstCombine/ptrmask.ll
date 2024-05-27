; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "p1:64:64:64:32"

declare ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1), i32)
declare ptr @llvm.ptrmask.p0.i64(ptr, i64)
declare <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) >, <2 x i32>)
declare <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr>, <2 x i64>)

define ptr @ptrmask_combine_consecutive_preserve_attrs(ptr %p0, i64 %m1) {
; CHECK-LABEL: define ptr @ptrmask_combine_consecutive_preserve_attrs
; CHECK-SAME: (ptr [[P0:%.*]], i64 [[M1:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[M1]], 224
; CHECK-NEXT:    [[R:%.*]] = call noalias align 32 ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[TMP1]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %pm0 = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 224)
  %r = call noalias ptr @llvm.ptrmask.p0.i64(ptr %pm0, i64 %m1)
  ret ptr %r
}

define <2 x ptr> @ptrmask_combine_consecutive_preserve_attrs_vecs(<2 x ptr> %p0, <2 x i64> %m1) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_combine_consecutive_preserve_attrs_vecs
; CHECK-SAME: (<2 x ptr> [[P0:%.*]], <2 x i64> [[M1:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = and <2 x i64> [[M1]], <i64 12345, i64 12345>
; CHECK-NEXT:    [[R:%.*]] = call align 128 <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P0]], <2 x i64> [[TMP1]])
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %p0, <2 x i64> <i64 12345, i64 12345>)
  %r = call align 128 <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %pm0, <2 x i64> %m1)
  ret <2 x ptr> %r
}

define ptr @ptrmask_combine_consecutive_preserve_attrs_fail(ptr %p0, i64 %m0) {
; CHECK-LABEL: define ptr @ptrmask_combine_consecutive_preserve_attrs_fail
; CHECK-SAME: (ptr [[P0:%.*]], i64 [[M0:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[M0]], 193
; CHECK-NEXT:    [[R:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[TMP1]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %pm0 = call noalias ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %pm0, i64 193)
  ret ptr %r
}

define ptr @ptrmask_combine_consecutive_preserve_attrs_todo0(ptr %p0) {
; CHECK-LABEL: define ptr @ptrmask_combine_consecutive_preserve_attrs_todo0
; CHECK-SAME: (ptr [[P0:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call noalias align 32 ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 224)
; CHECK-NEXT:    ret ptr [[PM0]]
;
  %pm0 = call noalias ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 224)
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %pm0, i64 224)
  ret ptr %r
}

define ptr @ptrmask_combine_consecutive_preserve_attrs_todo1(ptr %p0) {
; CHECK-LABEL: define ptr @ptrmask_combine_consecutive_preserve_attrs_todo1
; CHECK-SAME: (ptr [[P0:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call align 32 ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 224)
; CHECK-NEXT:    ret ptr [[PM0]]
;
  %pm0 = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 224)
  %r = call noalias ptr @llvm.ptrmask.p0.i64(ptr %pm0, i64 224)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_combine_consecutive_preserve_attrs_todo2(ptr addrspace(1) %p0) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_combine_consecutive_preserve_attrs_todo2
; CHECK-SAME: (ptr addrspace(1) [[P0:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call noalias align 32 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P0]], i32 224)
; CHECK-NEXT:    ret ptr addrspace(1) [[PM0]]
;
  %pm0 = call noalias ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p0, i32 224)
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %pm0, i32 224)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_combine_add_nonnull(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_combine_add_nonnull
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call align 64 ptr @llvm.ptrmask.p0.i64(ptr [[P]], i64 -64)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, ptr [[PM0]], i64 33
; CHECK-NEXT:    [[R:%.*]] = call nonnull align 32 ptr @llvm.ptrmask.p0.i64(ptr [[PGEP]], i64 -32)
; CHECK-NEXT:    ret ptr [[R]]
;
  %pm0 = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 -64)
  %pgep = getelementptr i8, ptr %pm0, i64 33
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %pgep, i64 -16)
  ret ptr %r
}

define ptr @ptrmask_combine_add_alignment(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_combine_add_alignment
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 64 ptr @llvm.ptrmask.p0.i64(ptr [[P]], i64 -64)
; CHECK-NEXT:    ret ptr [[R]]
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 -64)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_combine_add_alignment2(ptr addrspace(1) align 32 %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_combine_add_alignment2
; CHECK-SAME: (ptr addrspace(1) align 32 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 64 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P]], i32 -64)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 -64)
  ret ptr addrspace(1) %r
}

define <2 x ptr> @ptrmask_combine_add_alignment_vec(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_combine_add_alignment_vec
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 32 <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -96, i64 -96>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %p, <2 x i64> <i64 -96, i64 -96>)
  ret <2 x ptr> %r
}

define ptr addrspace(1) @ptrmask_combine_improve_alignment(ptr addrspace(1) %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_combine_improve_alignment
; CHECK-SAME: (ptr addrspace(1) [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 64 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P]], i32 -64)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call align 32 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 -64)
  ret ptr addrspace(1) %r
}

define <2 x ptr addrspace(1) > @ptrmask_combine_improve_alignment_vec(<2 x ptr addrspace(1) > %p) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_combine_improve_alignment_vec
; CHECK-SAME: (<2 x ptr addrspace(1)> [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 64 <2 x ptr addrspace(1)> @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1)> [[P]], <2 x i32> <i32 -64, i32 -128>)
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> [[R]]
;
  %r = call align 32 <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> <i32 -64, i32 -128>)
  ret <2 x ptr addrspace(1) > %r
}

define ptr addrspace(1) @ptrmask_combine_improve_alignment_fail(ptr addrspace(1) %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_combine_improve_alignment_fail
; CHECK-SAME: (ptr addrspace(1) [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 128 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P]], i32 -64)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call align 128 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 -64)
  ret ptr addrspace(1) %r
}

define i64 @ptrtoint_of_ptrmask(ptr %p, i64 %m) {
; CHECK-LABEL: define i64 @ptrtoint_of_ptrmask
; CHECK-SAME: (ptr [[P:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[R:%.*]] = and i64 [[TMP1]], [[M]]
; CHECK-NEXT:    ret i64 [[R]]
;
  %pm = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 %m)
  %r = ptrtoint ptr %pm to i64
  ret i64 %r
}

; This succeeds because (ptrtoint i32) gets folded to (trunc i32 (ptrtoint i64))
define i32 @ptrtoint_of_ptrmask2(ptr %p, i64 %m) {
; CHECK-LABEL: define i32 @ptrtoint_of_ptrmask2
; CHECK-SAME: (ptr [[P:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], [[M]]
; CHECK-NEXT:    [[R:%.*]] = trunc i64 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[R]]
;
  %pm = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 %m)
  %r = ptrtoint ptr %pm to i32
  ret i32 %r
}

define <2 x i64> @ptrtoint_of_ptrmask_vec(<2 x ptr> %p, <2 x i64> %m) {
; CHECK-LABEL: define <2 x i64> @ptrtoint_of_ptrmask_vec
; CHECK-SAME: (<2 x ptr> [[P:%.*]], <2 x i64> [[M:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint <2 x ptr> [[P]] to <2 x i64>
; CHECK-NEXT:    [[R:%.*]] = and <2 x i64> [[TMP1]], [[M]]
; CHECK-NEXT:    ret <2 x i64> [[R]]
;
  %pm = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %p, <2 x i64> %m)
  %r = ptrtoint <2 x ptr> %pm to <2 x i64>
  ret <2 x i64> %r
}

define <2 x i32> @ptrtoint_of_ptrmask_vec2(<2 x ptr> %p, <2 x i64> %m) {
; CHECK-LABEL: define <2 x i32> @ptrtoint_of_ptrmask_vec2
; CHECK-SAME: (<2 x ptr> [[P:%.*]], <2 x i64> [[M:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint <2 x ptr> [[P]] to <2 x i64>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i64> [[TMP1]], [[M]]
; CHECK-NEXT:    [[R:%.*]] = trunc <2 x i64> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %pm = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %p, <2 x i64> %m)
  %r = ptrtoint <2 x ptr> %pm to <2 x i32>
  ret <2 x i32> %r
}

define i64 @ptrtoint_of_ptrmask_fail(ptr addrspace(1) %p, i32 %m) {
; CHECK-LABEL: define i64 @ptrtoint_of_ptrmask_fail
; CHECK-SAME: (ptr addrspace(1) [[P:%.*]], i32 [[M:%.*]]) {
; CHECK-NEXT:    [[PM:%.*]] = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P]], i32 [[M]])
; CHECK-NEXT:    [[R:%.*]] = ptrtoint ptr addrspace(1) [[PM]] to i64
; CHECK-NEXT:    ret i64 [[R]]
;
  %pm = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 %m)
  %r = ptrtoint ptr addrspace(1) %pm to i64
  ret i64 %r
}

define <2 x i32> @ptrtoint_of_ptrmask_vec_fail(<2 x ptr addrspace(1) > %p, <2 x i32> %m) {
; CHECK-LABEL: define <2 x i32> @ptrtoint_of_ptrmask_vec_fail
; CHECK-SAME: (<2 x ptr addrspace(1)> [[P:%.*]], <2 x i32> [[M:%.*]]) {
; CHECK-NEXT:    [[PM:%.*]] = call <2 x ptr addrspace(1)> @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1)> [[P]], <2 x i32> [[M]])
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint <2 x ptr addrspace(1)> [[PM]] to <2 x i64>
; CHECK-NEXT:    [[R:%.*]] = trunc <2 x i64> [[TMP1]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %pm = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> %m)
  %r = ptrtoint <2 x ptr addrspace(1) > %pm to <2 x i32>
  ret <2 x i32> %r
}

define ptr addrspace(1) @ptrmask_is_null(ptr addrspace(1) align 32 %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_is_null
; CHECK-SAME: (ptr addrspace(1) align 32 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 4294967296 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P]], i32 0)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 31)
  ret ptr addrspace(1) %r
}

define <2 x ptr addrspace(1) > @ptrmask_is_null_vec(<2 x ptr addrspace(1) > align 64 %p) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_is_null_vec
; CHECK-SAME: (<2 x ptr addrspace(1)> align 64 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr addrspace(1)> @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1)> [[P]], <2 x i32> <i32 31, i32 63>)
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> [[R]]
;
  %r = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> <i32 31, i32 63>)
  ret <2 x ptr addrspace(1) > %r
}

define ptr addrspace(1) @ptrmask_is_null_fail(ptr addrspace(1) align 16 %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_is_null_fail
; CHECK-SAME: (ptr addrspace(1) align 16 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 16 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P]], i32 16)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 31)
  ret ptr addrspace(1) %r
}

define <2 x ptr addrspace(1) > @ptrmask_is_null_vec_fail(<2 x ptr addrspace(1) > align 32 %p) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_is_null_vec_fail
; CHECK-SAME: (<2 x ptr addrspace(1)> align 32 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr addrspace(1)> @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1)> [[P]], <2 x i32> <i32 31, i32 63>)
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> [[R]]
;
  %r = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> <i32 31, i32 63>)
  ret <2 x ptr addrspace(1) > %r
}

define ptr @ptrmask_maintain_provenance_i64(ptr %p0) {
; CHECK-LABEL: define ptr @ptrmask_maintain_provenance_i64
; CHECK-SAME: (ptr [[P0:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 4294967296 ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 0)
; CHECK-NEXT:    ret ptr [[R]]
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 0)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_maintain_provenance_i32(ptr addrspace(1) %p0) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_maintain_provenance_i32
; CHECK-SAME: (ptr addrspace(1) [[P0:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call align 4294967296 ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P0]], i32 0)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p0, i32 0)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_is_useless0(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless0
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and i64 [[I]], -4
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    [[R:%.*]] = call align 4 ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[M]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %m0 = and i64 %m, -4
  %i0 = and i64 %i, -4
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}

define ptr @ptrmask_is_useless1(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless1
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and i64 [[I]], -8
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    [[R:%.*]] = call align 8 ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[M]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %m0 = and i64 %m, -4
  %i0 = and i64 %i, -8
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}

define ptr @ptrmask_is_useless2(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless2
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and i64 [[I]], 31
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    [[R:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[M]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %m0 = and i64 %m, 127
  %i0 = and i64 %i, 31
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}

define ptr @ptrmask_is_useless3(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless3
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and i64 [[I]], 127
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    [[R:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[M]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %m0 = and i64 %m, 127
  %i0 = and i64 %i, 127
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}

define ptr @ptrmask_is_useless4(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless4
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and i64 [[I]], -4
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    ret ptr [[P0]]
;
  %m0 = or i64 %m, -4
  %i0 = and i64 %i, -4
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}

define <2 x ptr> @ptrmask_is_useless_vec(<2 x i64> %i, <2 x i64> %m) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_is_useless_vec
; CHECK-SAME: (<2 x i64> [[I:%.*]], <2 x i64> [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and <2 x i64> [[I]], <i64 31, i64 31>
; CHECK-NEXT:    [[P0:%.*]] = inttoptr <2 x i64> [[I0]] to <2 x ptr>
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P0]], <2 x i64> [[M]])
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %m0 = and <2 x i64> %m, <i64 127, i64 127>
  %i0 = and <2 x i64> %i, <i64 31, i64 31>
  %p0 = inttoptr <2 x i64> %i0 to <2 x ptr>
  %r = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %p0, <2 x i64> %m0)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_is_useless_vec_todo(<2 x i64> %i, <2 x i64> %m) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_is_useless_vec_todo
; CHECK-SAME: (<2 x i64> [[I:%.*]], <2 x i64> [[M:%.*]]) {
; CHECK-NEXT:    [[I0:%.*]] = and <2 x i64> [[I]], <i64 31, i64 127>
; CHECK-NEXT:    [[P0:%.*]] = inttoptr <2 x i64> [[I0]] to <2 x ptr>
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P0]], <2 x i64> [[M]])
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %m0 = and <2 x i64> %m, <i64 127, i64 127>
  %i0 = and <2 x i64> %i, <i64 31, i64 127>
  %p0 = inttoptr <2 x i64> %i0 to <2 x ptr>
  %r = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> %p0, <2 x i64> %m0)
  ret <2 x ptr> %r
}

define ptr @ptrmask_is_useless_fail0(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless_fail0
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[M0:%.*]] = and i64 [[M]], -4
; CHECK-NEXT:    [[I0:%.*]] = or i64 [[I]], -4
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    [[R:%.*]] = call align 4 ptr @llvm.ptrmask.p0.i64(ptr nonnull [[P0]], i64 [[M0]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %m0 = and i64 %m, -4
  %i0 = or i64 %i, -4
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}

define ptr @ptrmask_is_useless_fail1(i64 %i, i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_is_useless_fail1
; CHECK-SAME: (i64 [[I:%.*]], i64 [[M:%.*]]) {
; CHECK-NEXT:    [[M0:%.*]] = and i64 [[M]], 127
; CHECK-NEXT:    [[I0:%.*]] = and i64 [[I]], 511
; CHECK-NEXT:    [[P0:%.*]] = inttoptr i64 [[I0]] to ptr
; CHECK-NEXT:    [[R:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 [[M0]])
; CHECK-NEXT:    ret ptr [[R]]
;
  %m0 = and i64 %m, 127
  %i0 = and i64 %i, 511
  %p0 = inttoptr i64 %i0 to ptr
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 %m0)
  ret ptr %r
}
