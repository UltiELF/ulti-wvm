; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-windows-pc-msvc -disable-post-ra -verify-machineinstrs < %s | FileCheck %s

@var8 = dso_local global i8 0
@var16 = dso_local global i16 0
@var32 = dso_local global i32 0
@var64 = dso_local global i64 0

define dso_local i8 @test_atomic_load_add_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_add_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB0_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w8, [x9]
; CHECK-NEXT:    add w10, w8, w0
; CHECK-NEXT:    stlxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB0_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw add ptr @var8, i8 %offset seq_cst
   ret i8 %old
}

define dso_local i16 @test_atomic_load_add_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_add_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB1_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w8, [x9]
; CHECK-NEXT:    add w10, w8, w0
; CHECK-NEXT:    stxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB1_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw add ptr @var16, i16 %offset acquire
   ret i16 %old
}

define dso_local i32 @test_atomic_load_add_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB2_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr w8, [x9]
; CHECK-NEXT:    add w10, w8, w0
; CHECK-NEXT:    stlxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB2_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw add ptr @var32, i32 %offset release
   ret i32 %old
}

define dso_local i64 @test_atomic_load_add_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_add_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB3_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr x8, [x9]
; CHECK-NEXT:    add x10, x8, x0
; CHECK-NEXT:    stxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB3_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw add ptr @var64, i64 %offset monotonic
   ret i64 %old
}

define dso_local i8 @test_atomic_load_sub_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_sub_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB4_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrb w8, [x9]
; CHECK-NEXT:    sub w10, w8, w0
; CHECK-NEXT:    stxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB4_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw sub ptr @var8, i8 %offset monotonic
   ret i8 %old
}

define dso_local i16 @test_atomic_load_sub_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_sub_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB5_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrh w8, [x9]
; CHECK-NEXT:    sub w10, w8, w0
; CHECK-NEXT:    stlxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB5_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw sub ptr @var16, i16 %offset release
   ret i16 %old
}

define dso_local i32 @test_atomic_load_sub_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_sub_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB6_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x9]
; CHECK-NEXT:    sub w10, w8, w0
; CHECK-NEXT:    stxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB6_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw sub ptr @var32, i32 %offset acquire
   ret i32 %old
}

define dso_local i64 @test_atomic_load_sub_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_sub_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB7_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x0, [x9]
; CHECK-NEXT:    sub x10, x0, x8
; CHECK-NEXT:    stlxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB7_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw sub ptr @var64, i64 %offset seq_cst
   ret i64 %old
}

define dso_local i8 @test_atomic_load_and_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_and_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB8_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrb w8, [x9]
; CHECK-NEXT:    and w10, w8, w0
; CHECK-NEXT:    stlxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB8_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw and ptr @var8, i8 %offset release
   ret i8 %old
}

define dso_local i16 @test_atomic_load_and_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_and_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB9_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrh w8, [x9]
; CHECK-NEXT:    and w10, w8, w0
; CHECK-NEXT:    stxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB9_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw and ptr @var16, i16 %offset monotonic
   ret i16 %old
}

define dso_local i32 @test_atomic_load_and_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_and_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB10_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x9]
; CHECK-NEXT:    and w10, w8, w0
; CHECK-NEXT:    stlxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB10_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw and ptr @var32, i32 %offset seq_cst
   ret i32 %old
}

define dso_local i64 @test_atomic_load_and_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_and_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB11_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x8, [x9]
; CHECK-NEXT:    and x10, x8, x0
; CHECK-NEXT:    stxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB11_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw and ptr @var64, i64 %offset acquire
   ret i64 %old
}

define dso_local i8 @test_atomic_load_or_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_or_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB12_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w8, [x9]
; CHECK-NEXT:    orr w10, w8, w0
; CHECK-NEXT:    stlxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB12_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw or ptr @var8, i8 %offset seq_cst
   ret i8 %old
}

define dso_local i16 @test_atomic_load_or_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_or_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB13_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrh w8, [x9]
; CHECK-NEXT:    orr w10, w8, w0
; CHECK-NEXT:    stxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB13_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw or ptr @var16, i16 %offset monotonic
   ret i16 %old
}

define dso_local i32 @test_atomic_load_or_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_or_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB14_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x9]
; CHECK-NEXT:    orr w10, w8, w0
; CHECK-NEXT:    stxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB14_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw or ptr @var32, i32 %offset acquire
   ret i32 %old
}

define dso_local i64 @test_atomic_load_or_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_or_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB15_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr x8, [x9]
; CHECK-NEXT:    orr x10, x8, x0
; CHECK-NEXT:    stlxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB15_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw or ptr @var64, i64 %offset release
   ret i64 %old
}

define dso_local i8 @test_atomic_load_xor_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xor_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB16_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w8, [x9]
; CHECK-NEXT:    eor w10, w8, w0
; CHECK-NEXT:    stxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB16_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw xor ptr @var8, i8 %offset acquire
   ret i8 %old
}

define dso_local i16 @test_atomic_load_xor_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xor_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB17_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrh w8, [x9]
; CHECK-NEXT:    eor w10, w8, w0
; CHECK-NEXT:    stlxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB17_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw xor ptr @var16, i16 %offset release
   ret i16 %old
}

define dso_local i32 @test_atomic_load_xor_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xor_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB18_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x9]
; CHECK-NEXT:    eor w10, w8, w0
; CHECK-NEXT:    stlxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB18_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw xor ptr @var32, i32 %offset seq_cst
   ret i32 %old
}

define dso_local i64 @test_atomic_load_xor_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xor_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB19_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr x8, [x9]
; CHECK-NEXT:    eor x10, x8, x0
; CHECK-NEXT:    stxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB19_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw xor ptr @var64, i64 %offset monotonic
   ret i64 %old
}

define dso_local i8 @test_atomic_load_xchg_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xchg_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB20_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrb w8, [x9]
; CHECK-NEXT:    stxrb w10, w0, [x9]
; CHECK-NEXT:    cbnz w10, .LBB20_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw xchg ptr @var8, i8 %offset monotonic
   ret i8 %old
}

define dso_local i16 @test_atomic_load_xchg_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xchg_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB21_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w8, [x9]
; CHECK-NEXT:    stlxrh w10, w0, [x9]
; CHECK-NEXT:    cbnz w10, .LBB21_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw xchg ptr @var16, i16 %offset seq_cst
   ret i16 %old
}

define dso_local i32 @test_atomic_load_xchg_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xchg_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB22_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr w0, [x9]
; CHECK-NEXT:    stlxr w10, w8, [x9]
; CHECK-NEXT:    cbnz w10, .LBB22_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %old = atomicrmw xchg ptr @var32, i32 %offset release
   ret i32 %old
}

define dso_local i64 @test_atomic_load_xchg_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_xchg_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB23_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x8, [x9]
; CHECK-NEXT:    stxr w10, x0, [x9]
; CHECK-NEXT:    cbnz w10, .LBB23_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw xchg ptr @var64, i64 %offset acquire
   ret i64 %old
}


define dso_local i8 @test_atomic_load_min_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_min_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB24_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w10, [x9]
; CHECK-NEXT:    sxtb w8, w10
; CHECK-NEXT:    cmp w8, w0, sxtb
; CHECK-NEXT:    csel w10, w10, w0, le
; CHECK-NEXT:    stxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB24_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw min ptr @var8, i8 %offset acquire
   ret i8 %old
}

define dso_local i16 @test_atomic_load_min_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_min_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB25_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrh w10, [x9]
; CHECK-NEXT:    sxth w8, w10
; CHECK-NEXT:    cmp w8, w0, sxth
; CHECK-NEXT:    csel w10, w10, w0, le
; CHECK-NEXT:    stlxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB25_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw min ptr @var16, i16 %offset release
   ret i16 %old
}

define dso_local i32 @test_atomic_load_min_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_min_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB26_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr w8, [x9]
; CHECK-NEXT:    cmp w8, w0
; CHECK-NEXT:    csel w10, w8, w0, le
; CHECK-NEXT:    stxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB26_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw min ptr @var32, i32 %offset monotonic
   ret i32 %old
}

define dso_local i64 @test_atomic_load_min_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_min_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB27_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x0, [x9]
; CHECK-NEXT:    cmp x0, x8
; CHECK-NEXT:    csel x10, x0, x8, le
; CHECK-NEXT:    stlxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB27_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw min ptr @var64, i64 %offset seq_cst
   ret i64 %old
}

define dso_local i8 @test_atomic_load_max_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_max_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB28_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w10, [x9]
; CHECK-NEXT:    sxtb w8, w10
; CHECK-NEXT:    cmp w8, w0, sxtb
; CHECK-NEXT:    csel w10, w10, w0, gt
; CHECK-NEXT:    stlxrb w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB28_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw max ptr @var8, i8 %offset seq_cst
   ret i8 %old
}

define dso_local i16 @test_atomic_load_max_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_max_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB29_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w10, [x9]
; CHECK-NEXT:    sxth w8, w10
; CHECK-NEXT:    cmp w8, w0, sxth
; CHECK-NEXT:    csel w10, w10, w0, gt
; CHECK-NEXT:    stxrh w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB29_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw max ptr @var16, i16 %offset acquire
   ret i16 %old
}

define dso_local i32 @test_atomic_load_max_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_max_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB30_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr w8, [x9]
; CHECK-NEXT:    cmp w8, w0
; CHECK-NEXT:    csel w10, w8, w0, gt
; CHECK-NEXT:    stlxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB30_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
   %old = atomicrmw max ptr @var32, i32 %offset release
   ret i32 %old
}

define dso_local i64 @test_atomic_load_max_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_max_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB31_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr x8, [x9]
; CHECK-NEXT:    cmp x8, x0
; CHECK-NEXT:    csel x10, x8, x0, gt
; CHECK-NEXT:    stxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB31_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw max ptr @var64, i64 %offset monotonic
   ret i64 %old
}

define dso_local i8 @test_atomic_load_umin_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umin_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    add x8, x8, :lo12:var8
; CHECK-NEXT:    and w9, w0, #0xff
; CHECK-NEXT:  .LBB32_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrb w0, [x8]
; CHECK-NEXT:    cmp w0, w9
; CHECK-NEXT:    csel w10, w0, w9, ls
; CHECK-NEXT:    stxrb w11, w10, [x8]
; CHECK-NEXT:    cbnz w11, .LBB32_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %old = atomicrmw umin ptr @var8, i8 %offset monotonic
   ret i8 %old
}

define dso_local i16 @test_atomic_load_umin_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umin_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var16
; CHECK-NEXT:    add x8, x8, :lo12:var16
; CHECK-NEXT:    and w9, w0, #0xffff
; CHECK-NEXT:  .LBB33_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w0, [x8]
; CHECK-NEXT:    cmp w0, w9
; CHECK-NEXT:    csel w10, w0, w9, ls
; CHECK-NEXT:    stxrh w11, w10, [x8]
; CHECK-NEXT:    cbnz w11, .LBB33_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %old = atomicrmw umin ptr @var16, i16 %offset acquire
   ret i16 %old
}

define dso_local i32 @test_atomic_load_umin_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umin_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB34_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x9]
; CHECK-NEXT:    cmp w8, w0
; CHECK-NEXT:    csel w10, w8, w0, ls
; CHECK-NEXT:    stlxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB34_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw umin ptr @var32, i32 %offset seq_cst
   ret i32 %old
}

define dso_local i64 @test_atomic_load_umin_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umin_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB35_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x8, [x9]
; CHECK-NEXT:    cmp x8, x0
; CHECK-NEXT:    csel x10, x8, x0, ls
; CHECK-NEXT:    stlxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB35_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw umin ptr @var64, i64 %offset acq_rel
   ret i64 %old
}

define dso_local i8 @test_atomic_load_umax_i8(i8 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umax_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    add x8, x8, :lo12:var8
; CHECK-NEXT:    and w9, w0, #0xff
; CHECK-NEXT:  .LBB36_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w0, [x8]
; CHECK-NEXT:    cmp w0, w9
; CHECK-NEXT:    csel w10, w0, w9, hi
; CHECK-NEXT:    stlxrb w11, w10, [x8]
; CHECK-NEXT:    cbnz w11, .LBB36_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %old = atomicrmw umax ptr @var8, i8 %offset acq_rel
   ret i8 %old
}

define dso_local i16 @test_atomic_load_umax_i16(i16 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umax_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var16
; CHECK-NEXT:    add x8, x8, :lo12:var16
; CHECK-NEXT:    and w9, w0, #0xffff
; CHECK-NEXT:  .LBB37_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxrh w0, [x8]
; CHECK-NEXT:    cmp w0, w9
; CHECK-NEXT:    csel w10, w0, w9, hi
; CHECK-NEXT:    stxrh w11, w10, [x8]
; CHECK-NEXT:    cbnz w11, .LBB37_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %old = atomicrmw umax ptr @var16, i16 %offset monotonic
   ret i16 %old
}

define dso_local i32 @test_atomic_load_umax_i32(i32 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umax_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB38_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x9]
; CHECK-NEXT:    cmp w8, w0
; CHECK-NEXT:    csel w10, w8, w0, hi
; CHECK-NEXT:    stlxr w11, w10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB38_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
   %old = atomicrmw umax ptr @var32, i32 %offset seq_cst
   ret i32 %old
}

define dso_local i64 @test_atomic_load_umax_i64(i64 %offset) nounwind {
; CHECK-LABEL: test_atomic_load_umax_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB39_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr x8, [x9]
; CHECK-NEXT:    cmp x8, x0
; CHECK-NEXT:    csel x10, x8, x0, hi
; CHECK-NEXT:    stlxr w11, x10, [x9]
; CHECK-NEXT:    cbnz w11, .LBB39_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
   %old = atomicrmw umax ptr @var64, i64 %offset release
   ret i64 %old
}

define dso_local i8 @test_atomic_cmpxchg_i8(i8 %wanted, i8 %new) nounwind {
; CHECK-LABEL: test_atomic_cmpxchg_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    adrp x9, var8
; CHECK-NEXT:    add x9, x9, :lo12:var8
; CHECK-NEXT:  .LBB40_1: // %cmpxchg.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w0, [x9]
; CHECK-NEXT:    cmp w0, w8
; CHECK-NEXT:    b.ne .LBB40_4
; CHECK-NEXT:  // %bb.2: // %cmpxchg.trystore
; CHECK-NEXT:    // in Loop: Header=BB40_1 Depth=1
; CHECK-NEXT:    stxrb w10, w1, [x9]
; CHECK-NEXT:    cbnz w10, .LBB40_1
; CHECK-NEXT:  // %bb.3: // %cmpxchg.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB40_4: // %cmpxchg.nostore
; CHECK-NEXT:    clrex
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %pair = cmpxchg ptr @var8, i8 %wanted, i8 %new acquire acquire
   %old = extractvalue { i8, i1 } %pair, 0
   ret i8 %old
}

define dso_local i16 @test_atomic_cmpxchg_i16(i16 %wanted, i16 %new) nounwind {
; CHECK-LABEL: test_atomic_cmpxchg_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    adrp x9, var16
; CHECK-NEXT:    add x9, x9, :lo12:var16
; CHECK-NEXT:  .LBB41_1: // %cmpxchg.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w0, [x9]
; CHECK-NEXT:    cmp w0, w8
; CHECK-NEXT:    b.ne .LBB41_4
; CHECK-NEXT:  // %bb.2: // %cmpxchg.trystore
; CHECK-NEXT:    // in Loop: Header=BB41_1 Depth=1
; CHECK-NEXT:    stlxrh w10, w1, [x9]
; CHECK-NEXT:    cbnz w10, .LBB41_1
; CHECK-NEXT:  // %bb.3: // %cmpxchg.success
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB41_4: // %cmpxchg.nostore
; CHECK-NEXT:    clrex
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %pair = cmpxchg ptr @var16, i16 %wanted, i16 %new seq_cst seq_cst
   %old = extractvalue { i16, i1 } %pair, 0
   ret i16 %old
}

define dso_local i32 @test_atomic_cmpxchg_i32(i32 %wanted, i32 %new) nounwind {
; CHECK-LABEL: test_atomic_cmpxchg_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    adrp x9, var32
; CHECK-NEXT:    add x9, x9, :lo12:var32
; CHECK-NEXT:  .LBB42_1: // %cmpxchg.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr w0, [x9]
; CHECK-NEXT:    cmp w0, w8
; CHECK-NEXT:    b.ne .LBB42_4
; CHECK-NEXT:  // %bb.2: // %cmpxchg.trystore
; CHECK-NEXT:    // in Loop: Header=BB42_1 Depth=1
; CHECK-NEXT:    stlxr w10, w1, [x9]
; CHECK-NEXT:    cbnz w10, .LBB42_1
; CHECK-NEXT:  // %bb.3: // %cmpxchg.end
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB42_4: // %cmpxchg.nostore
; CHECK-NEXT:    clrex
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
   %pair = cmpxchg ptr @var32, i32 %wanted, i32 %new release monotonic
   %old = extractvalue { i32, i1 } %pair, 0
   ret i32 %old
}

define dso_local void @test_atomic_cmpxchg_i64(i64 %wanted, i64 %new) nounwind {
; CHECK-LABEL: test_atomic_cmpxchg_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    add x9, x9, :lo12:var64
; CHECK-NEXT:  .LBB43_1: // %cmpxchg.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldxr x8, [x9]
; CHECK-NEXT:    cmp x8, x0
; CHECK-NEXT:    b.ne .LBB43_3
; CHECK-NEXT:  // %bb.2: // %cmpxchg.trystore
; CHECK-NEXT:    // in Loop: Header=BB43_1 Depth=1
; CHECK-NEXT:    stxr w10, x1, [x9]
; CHECK-NEXT:    cbnz w10, .LBB43_1
; CHECK-NEXT:    b .LBB43_4
; CHECK-NEXT:  .LBB43_3: // %cmpxchg.nostore
; CHECK-NEXT:    clrex
; CHECK-NEXT:  .LBB43_4: // %cmpxchg.end
; CHECK-NEXT:    adrp x9, var64
; CHECK-NEXT:    str x8, [x9, :lo12:var64]
; CHECK-NEXT:    ret
   %pair = cmpxchg ptr @var64, i64 %wanted, i64 %new monotonic monotonic
   %old = extractvalue { i64, i1 } %pair, 0
   store i64 %old, ptr @var64
   ret void
}

define dso_local i8 @test_atomic_load_monotonic_i8() nounwind {
; CHECK-LABEL: test_atomic_load_monotonic_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    ldrb w0, [x8, :lo12:var8]
; CHECK-NEXT:    ret
  %val = load atomic i8, ptr @var8 monotonic, align 1
  ret i8 %val
}

define dso_local i8 @test_atomic_load_monotonic_regoff_i8(i64 %base, i64 %off) nounwind {
; CHECK-LABEL: test_atomic_load_monotonic_regoff_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldrb w0, [x0, x1]
; CHECK-NEXT:    ret
  %addr_int = add i64 %base, %off
  %addr = inttoptr i64 %addr_int to ptr
  %val = load atomic i8, ptr %addr monotonic, align 1
  ret i8 %val
}

define dso_local i8 @test_atomic_load_acquire_i8() nounwind {
; CHECK-LABEL: test_atomic_load_acquire_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    add x8, x8, :lo12:var8
; CHECK-NEXT:    ldarb w0, [x8]
; CHECK-NEXT:    ret
  %val = load atomic i8, ptr @var8 acquire, align 1
  ret i8 %val
}

define dso_local i8 @test_atomic_load_seq_cst_i8() nounwind {
; CHECK-LABEL: test_atomic_load_seq_cst_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    add x8, x8, :lo12:var8
; CHECK-NEXT:    ldarb w0, [x8]
; CHECK-NEXT:    ret
  %val = load atomic i8, ptr @var8 seq_cst, align 1
  ret i8 %val
}

define dso_local i16 @test_atomic_load_monotonic_i16() nounwind {
; CHECK-LABEL: test_atomic_load_monotonic_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var16
; CHECK-NEXT:    ldrh w0, [x8, :lo12:var16]
; CHECK-NEXT:    ret
  %val = load atomic i16, ptr @var16 monotonic, align 2
  ret i16 %val
}

define dso_local i32 @test_atomic_load_monotonic_regoff_i32(i64 %base, i64 %off) nounwind {
; CHECK-LABEL: test_atomic_load_monotonic_regoff_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w0, [x0, x1]
; CHECK-NEXT:    ret
  %addr_int = add i64 %base, %off
  %addr = inttoptr i64 %addr_int to ptr
  %val = load atomic i32, ptr %addr monotonic, align 4
  ret i32 %val
}

define dso_local i64 @test_atomic_load_seq_cst_i64() nounwind {
; CHECK-LABEL: test_atomic_load_seq_cst_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var64
; CHECK-NEXT:    add x8, x8, :lo12:var64
; CHECK-NEXT:    ldar x0, [x8]
; CHECK-NEXT:    ret
  %val = load atomic i64, ptr @var64 seq_cst, align 8
  ret i64 %val
}

define dso_local void @test_atomic_store_monotonic_i8(i8 %val) nounwind {
; CHECK-LABEL: test_atomic_store_monotonic_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    strb w0, [x8, :lo12:var8]
; CHECK-NEXT:    ret
  store atomic i8 %val, ptr @var8 monotonic, align 1
  ret void
}

define dso_local void @test_atomic_store_monotonic_regoff_i8(i64 %base, i64 %off, i8 %val) nounwind {
; CHECK-LABEL: test_atomic_store_monotonic_regoff_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    strb w2, [x0, x1]
; CHECK-NEXT:    ret
  %addr_int = add i64 %base, %off
  %addr = inttoptr i64 %addr_int to ptr
  store atomic i8 %val, ptr %addr monotonic, align 1
  ret void
}
define dso_local void @test_atomic_store_release_i8(i8 %val) nounwind {
; CHECK-LABEL: test_atomic_store_release_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    add x8, x8, :lo12:var8
; CHECK-NEXT:    stlrb w0, [x8]
; CHECK-NEXT:    ret
  store atomic i8 %val, ptr @var8 release, align 1
  ret void
}

define dso_local void @test_atomic_store_seq_cst_i8(i8 %val) nounwind {
; CHECK-LABEL: test_atomic_store_seq_cst_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var8
; CHECK-NEXT:    add x8, x8, :lo12:var8
; CHECK-NEXT:    stlrb w0, [x8]
; CHECK-NEXT:    dmb ish
; CHECK-NEXT:    ret
  store atomic i8 %val, ptr @var8 seq_cst, align 1
  ret void
}

define dso_local void @test_atomic_store_monotonic_i16(i16 %val) nounwind {
; CHECK-LABEL: test_atomic_store_monotonic_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var16
; CHECK-NEXT:    strh w0, [x8, :lo12:var16]
; CHECK-NEXT:    ret
  store atomic i16 %val, ptr @var16 monotonic, align 2
  ret void
}

define dso_local void @test_atomic_store_monotonic_regoff_i32(i64 %base, i64 %off, i32 %val) nounwind {
; CHECK-LABEL: test_atomic_store_monotonic_regoff_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str w2, [x0, x1]
; CHECK-NEXT:    ret
  %addr_int = add i64 %base, %off
  %addr = inttoptr i64 %addr_int to ptr
  store atomic i32 %val, ptr %addr monotonic, align 4
  ret void
}

define dso_local void @test_atomic_store_release_i64(i64 %val) nounwind {
; CHECK-LABEL: test_atomic_store_release_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var64
; CHECK-NEXT:    add x8, x8, :lo12:var64
; CHECK-NEXT:    stlr x0, [x8]
; CHECK-NEXT:    ret
  store atomic i64 %val, ptr @var64 release, align 8
  ret void
}
