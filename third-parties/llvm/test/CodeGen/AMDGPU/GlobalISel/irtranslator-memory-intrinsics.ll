; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -O0 -stop-after=irtranslator -verify-machineinstrs %s -o - | FileCheck %s

; Size operand should be the minimum of the two pointer sizes.

define void @test_memcpy_p1_p3_i64(ptr addrspace(1) %dst, ptr addrspace(3) %src) {
  ; CHECK-LABEL: name: test_memcpy_p1_p3_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p3) = COPY $vgpr2
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 256
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[C]](s64)
  ; CHECK-NEXT:   G_MEMCPY [[MV]](p1), [[COPY2]](p3), [[TRUNC]](s32), 0 :: (store (s8) into %ir.dst, addrspace 1), (load (s8) from %ir.src, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) %dst, ptr addrspace(3) %src, i64 256, i1 false)
  ret void
}

define void @test_memcpy_p1_p3_i32(ptr addrspace(1) %dst, ptr addrspace(3) %src) {
  ; CHECK-LABEL: name: test_memcpy_p1_p3_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p3) = COPY $vgpr2
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 256
  ; CHECK-NEXT:   G_MEMCPY [[MV]](p1), [[COPY2]](p3), [[C]](s32), 0 :: (store (s8) into %ir.dst, addrspace 1), (load (s8) from %ir.src, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p1.p3.i32(ptr addrspace(1) %dst, ptr addrspace(3) %src, i32 256, i1 false)
  ret void
}

define void @test_memcpy_p1_p3_i16(ptr addrspace(1) %dst, ptr addrspace(3) %src) {
  ; CHECK-LABEL: name: test_memcpy_p1_p3_i16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p3) = COPY $vgpr2
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 256
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[C]](s16)
  ; CHECK-NEXT:   G_MEMCPY [[MV]](p1), [[COPY2]](p3), [[ZEXT]](s32), 0 :: (store (s8) into %ir.dst, addrspace 1), (load (s8) from %ir.src, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p1.p3.i16(ptr addrspace(1) %dst, ptr addrspace(3) %src, i16 256, i1 false)
  ret void
}

define void @test_memcpy_p3_p1_i64(ptr addrspace(3) %dst, ptr addrspace(1) %src) {
  ; CHECK-LABEL: name: test_memcpy_p3_p1_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 256
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[C]](s64)
  ; CHECK-NEXT:   G_MEMCPY [[COPY]](p3), [[MV]](p1), [[TRUNC]](s32), 0 :: (store (s8) into %ir.dst, addrspace 3), (load (s8) from %ir.src, addrspace 1)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p3.p1.i64(ptr addrspace(3) %dst, ptr addrspace(1) %src, i64 256, i1 false)
  ret void
}

define void @test_memcpy_p3_p1_i32(ptr addrspace(3) %dst, ptr addrspace(1) %src) {
  ; CHECK-LABEL: name: test_memcpy_p3_p1_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 256
  ; CHECK-NEXT:   G_MEMCPY [[COPY]](p3), [[MV]](p1), [[C]](s32), 0 :: (store (s8) into %ir.dst, addrspace 3), (load (s8) from %ir.src, addrspace 1)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p3.p1.i32(ptr addrspace(3) %dst, ptr addrspace(1) %src, i32 256, i1 false)
  ret void
}

define void @test_memcpy_p3_p1_i16(ptr addrspace(3) %dst, ptr addrspace(1) %src) {
  ; CHECK-LABEL: name: test_memcpy_p3_p1_i16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 256
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[C]](s16)
  ; CHECK-NEXT:   G_MEMCPY [[COPY]](p3), [[MV]](p1), [[ZEXT]](s32), 0 :: (store (s8) into %ir.dst, addrspace 3), (load (s8) from %ir.src, addrspace 1)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p3.p1.i16(ptr addrspace(3) %dst, ptr addrspace(1) %src, i16 256, i1 false)
  ret void
}

define void @test_memmove_p1_p3_i64(ptr addrspace(1) %dst, ptr addrspace(3) %src) {
  ; CHECK-LABEL: name: test_memmove_p1_p3_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p3) = COPY $vgpr2
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 256
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[C]](s64)
  ; CHECK-NEXT:   G_MEMMOVE [[MV]](p1), [[COPY2]](p3), [[TRUNC]](s32), 0 :: (store (s8) into %ir.dst, addrspace 1), (load (s8) from %ir.src, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memmove.p1.p3.i64(ptr addrspace(1) %dst, ptr addrspace(3) %src, i64 256, i1 false)
  ret void
}

define void @test_memmove_p1_p3_i32(ptr addrspace(1) %dst, ptr addrspace(3) %src) {
  ; CHECK-LABEL: name: test_memmove_p1_p3_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p3) = COPY $vgpr2
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 256
  ; CHECK-NEXT:   G_MEMMOVE [[MV]](p1), [[COPY2]](p3), [[C]](s32), 0 :: (store (s8) into %ir.dst, addrspace 1), (load (s8) from %ir.src, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memmove.p1.p3.i32(ptr addrspace(1) %dst, ptr addrspace(3) %src, i32 256, i1 false)
  ret void
}

define void @test_memmove_p1_p3_i16(ptr addrspace(1) %dst, ptr addrspace(3) %src) {
  ; CHECK-LABEL: name: test_memmove_p1_p3_i16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p3) = COPY $vgpr2
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 256
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[C]](s16)
  ; CHECK-NEXT:   G_MEMMOVE [[MV]](p1), [[COPY2]](p3), [[ZEXT]](s32), 0 :: (store (s8) into %ir.dst, addrspace 1), (load (s8) from %ir.src, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memmove.p1.p3.i16(ptr addrspace(1) %dst, ptr addrspace(3) %src, i16 256, i1 false)
  ret void
}

define void @test_memset_p1_i64(ptr addrspace(1) %dst, i8 %val) {
  ; CHECK-LABEL: name: test_memset_p1_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY2]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 256
  ; CHECK-NEXT:   G_MEMSET [[MV]](p1), [[TRUNC]](s8), [[C]](s64), 0 :: (store (s8) into %ir.dst, addrspace 1)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memset.p1.i64(ptr addrspace(1) %dst, i8 %val, i64 256, i1 false)
  ret void
}

define void @test_memset_p1_i32(ptr addrspace(1) %dst, i8 %val) {
  ; CHECK-LABEL: name: test_memset_p1_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY2]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 256
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[C]](s32)
  ; CHECK-NEXT:   G_MEMSET [[MV]](p1), [[TRUNC]](s8), [[ZEXT]](s64), 0 :: (store (s8) into %ir.dst, addrspace 1)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memset.p1.i32(ptr addrspace(1) %dst, i8 %val, i32 256, i1 false)
  ret void
}

define void @test_memset_p1_i16(ptr addrspace(1) %dst, i8 %val) {
  ; CHECK-LABEL: name: test_memset_p1_i16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY2]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 256
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[C]](s16)
  ; CHECK-NEXT:   G_MEMSET [[MV]](p1), [[TRUNC]](s8), [[ZEXT]](s64), 0 :: (store (s8) into %ir.dst, addrspace 1)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memset.p1.i16(ptr addrspace(1) %dst, i8 %val, i16 256, i1 false)
  ret void
}

define void @test_memset_p3_i64(ptr addrspace(3) %dst, i8 %val) {
  ; CHECK-LABEL: name: test_memset_p3_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY1]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 256
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[C]](s64)
  ; CHECK-NEXT:   G_MEMSET [[COPY]](p3), [[TRUNC]](s8), [[TRUNC1]](s32), 0 :: (store (s8) into %ir.dst, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memset.p3.i64(ptr addrspace(3) %dst, i8 %val, i64 256, i1 false)
  ret void
}

define void @test_memset_p3_i32(ptr addrspace(3) %dst, i8 %val) {
  ; CHECK-LABEL: name: test_memset_p3_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY1]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 256
  ; CHECK-NEXT:   G_MEMSET [[COPY]](p3), [[TRUNC]](s8), [[C]](s32), 0 :: (store (s8) into %ir.dst, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memset.p3.i32(ptr addrspace(3) %dst, i8 %val, i32 256, i1 false)
  ret void
}

define void @test_memset_p3_i16(ptr addrspace(3) %dst, i8 %val) {
  ; CHECK-LABEL: name: test_memset_p3_i16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY1]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 256
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[C]](s16)
  ; CHECK-NEXT:   G_MEMSET [[COPY]](p3), [[TRUNC]](s8), [[ZEXT]](s32), 0 :: (store (s8) into %ir.dst, addrspace 3)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memset.p3.i16(ptr addrspace(3) %dst, i8 %val, i16 256, i1 false)
  ret void
}

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #0
declare void @llvm.memcpy.p1.p3.i32(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i32, i1 immarg) #0
declare void @llvm.memcpy.p1.p3.i16(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i16, i1 immarg) #0
declare void @llvm.memcpy.p3.p1.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #0
declare void @llvm.memcpy.p3.p1.i32(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i32, i1 immarg) #0
declare void @llvm.memcpy.p3.p1.i16(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i16, i1 immarg) #0
declare void @llvm.memmove.p1.p3.i64(ptr addrspace(1) nocapture, ptr addrspace(3) nocapture readonly, i64, i1 immarg) #0
declare void @llvm.memmove.p1.p3.i32(ptr addrspace(1) nocapture, ptr addrspace(3) nocapture readonly, i32, i1 immarg) #0
declare void @llvm.memmove.p1.p3.i16(ptr addrspace(1) nocapture, ptr addrspace(3) nocapture readonly, i16, i1 immarg) #0
declare void @llvm.memset.p1.i64(ptr addrspace(1) nocapture writeonly, i8, i64, i1 immarg) #1
declare void @llvm.memset.p1.i32(ptr addrspace(1) nocapture writeonly, i8, i32, i1 immarg) #1
declare void @llvm.memset.p1.i16(ptr addrspace(1) nocapture writeonly, i8, i16, i1 immarg) #1
declare void @llvm.memset.p3.i64(ptr addrspace(3) nocapture writeonly, i8, i64, i1 immarg) #1
declare void @llvm.memset.p3.i32(ptr addrspace(3) nocapture writeonly, i8, i32, i1 immarg) #1
declare void @llvm.memset.p3.i16(ptr addrspace(3) nocapture writeonly, i8, i16, i1 immarg) #1

attributes #0 = { argmemonly nounwind willreturn }
attributes #1 = { argmemonly nounwind willreturn writeonly }
