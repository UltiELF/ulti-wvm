; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='module(msan)' -msan-instrumentation-with-call-threshold=0 -msan-track-origins=1 -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!2 = distinct !DISubprogram(name: "t", scope: !3, file: !3, line: 4, type: !4, spFlags: DISPFlagDefinition, unit: !6)
!3 = !DIFile(filename: "tmp/noundef.cpp", directory: "/")
!4 = !DISubroutineType(types: !5)
!5 = !{}
!6 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug)
!10 = !DILocation(line: 9, column: 0, scope: !2)
!11 = !DILocation(line: 9, column: 1, scope: !2)
!12 = !DILocation(line: 9, column: 2, scope: !2)
!13 = !DILocation(line: 9, column: 3, scope: !2)
!14 = !DILocation(line: 9, column: 4, scope: !2)
!15 = !DILocation(line: 9, column: 5, scope: !2)

define void @Store(ptr nocapture %p, i32 %x) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @Store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_param_tls, align 8, !dbg [[DBG1:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP0]], i32 zeroext [[TMP1]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = ptrtoint ptr [[P:%.*]] to i64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = xor i64 [[TMP4]], 87960930222080, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = inttoptr i64 [[TMP5]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = add i64 [[TMP5]], 17592186044416, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = inttoptr i64 [[TMP7]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    store i32 [[TMP2]], ptr [[TMP6]], align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_store_origin_4(i32 zeroext [[TMP2]], ptr [[P]], i32 zeroext [[TMP3]]), !dbg [[DBG1]]
; CHECK-NEXT:    store i32 [[X:%.*]], ptr [[P]], align 4, !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
entry:
  store i32 %x, ptr %p, align 4, !dbg !10
  ret void
}

define void @LoadAndCmp(ptr nocapture %a) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @LoadAndCmp(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP0]], i32 zeroext [[TMP1]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[A:%.*]], align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[A]] to i64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = xor i64 [[TMP3]], 87960930222080, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[TMP4]], 17592186044416, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSLD:%.*]] = load i32, ptr [[TMP5]], align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr [[TMP7]], align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP9:%.*]] = xor i32 [[TMP2]], 0, !dbg [[DBG7:![0-9]+]]
; CHECK-NEXT:    [[TMP10:%.*]] = or i32 [[_MSLD]], 0, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP11:%.*]] = icmp ne i32 [[TMP10]], 0, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP12:%.*]] = xor i32 [[TMP10]], -1, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP13:%.*]] = and i32 [[TMP12]], [[TMP9]], !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[TMP13]], 0, !dbg [[DBG7]]
; CHECK-NEXT:    [[_MSPROP_ICMP:%.*]] = and i1 [[TMP11]], [[TMP14]], !dbg [[DBG7]]
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TMP2]], 0, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP15:%.*]] = zext i1 [[_MSPROP_ICMP]] to i8, !dbg [[DBG8:![0-9]+]]
; CHECK-NEXT:    call void @__msan_maybe_warning_1(i8 zeroext [[TMP15]], i32 zeroext [[TMP8]]), !dbg [[DBG8]]
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_END:%.*]], label [[IF_THEN:%.*]], !dbg [[DBG8]]
; CHECK:       if.then:
; CHECK-NEXT:    store i64 0, ptr @__msan_va_arg_overflow_size_tls, align 8
; CHECK-NEXT:    tail call void (...) @foo() #[[ATTR5:[0-9]+]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i32, ptr %a, align 4, !dbg !10
  %tobool = icmp eq i32 %0, 0, !dbg !11
  br i1 %tobool, label %if.end, label %if.then, !dbg !12

if.then:                                            tail call void (...) @foo() nounwind
  br label %if.end

if.end:                                             ret void
}

declare void @foo(...)

define i32 @ReturnInt() nounwind uwtable readnone sanitize_memory {
; CHECK-LABEL: @ReturnInt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    ret i32 123, !dbg [[DBG1]]
;
entry:
  ret i32 123, !dbg !10
}

define void @CopyRetVal(ptr nocapture %a) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @CopyRetVal(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[CALL:%.*]] = tail call i32 @ReturnInt() #[[ATTR5]], !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4, !dbg [[DBG7]]
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP0]], i32 zeroext [[TMP1]]), !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[A:%.*]] to i64, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP4:%.*]] = xor i64 [[TMP3]], 87960930222080, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[TMP4]], 17592186044416, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    store i32 [[_MSRET]], ptr [[TMP5]], align 4, !dbg [[DBG7]]
; CHECK-NEXT:    call void @__msan_maybe_store_origin_4(i32 zeroext [[_MSRET]], ptr [[A]], i32 zeroext [[TMP2]]), !dbg [[DBG7]]
; CHECK-NEXT:    store i32 [[CALL]], ptr [[A]], align 4, !dbg [[DBG7]]
; CHECK-NEXT:    ret void
;
entry:
  %call = tail call i32 @ReturnInt() nounwind, !dbg !10
  store i32 %call, ptr %a, align 4, !dbg !11
  ret void
}



define void @SExt(ptr nocapture %a, ptr nocapture %b) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @SExt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP0]], i32 zeroext [[TMP1]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i16, ptr [[B:%.*]], align 2, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = ptrtoint ptr [[B]] to i64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = xor i64 [[TMP5]], 87960930222080, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = add i64 [[TMP6]], 17592186044416, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP9:%.*]] = and i64 [[TMP8]], -4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP10:%.*]] = inttoptr i64 [[TMP9]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSLD:%.*]] = load i16, ptr [[TMP7]], align 2, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr [[TMP10]], align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP:%.*]] = sext i16 [[_MSLD]] to i32, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP12:%.*]] = sext i16 [[TMP4]] to i32, !dbg [[DBG7]]
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP2]], i32 zeroext [[TMP3]]), !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP13:%.*]] = ptrtoint ptr [[A:%.*]] to i64, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP14:%.*]] = xor i64 [[TMP13]], 87960930222080, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP15:%.*]] = inttoptr i64 [[TMP14]] to ptr, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP16:%.*]] = add i64 [[TMP14]], 17592186044416, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP17:%.*]] = inttoptr i64 [[TMP16]] to ptr, !dbg [[DBG8]]
; CHECK-NEXT:    store i32 [[_MSPROP]], ptr [[TMP15]], align 4, !dbg [[DBG8]]
; CHECK-NEXT:    call void @__msan_maybe_store_origin_4(i32 zeroext [[_MSPROP]], ptr [[A]], i32 zeroext [[TMP11]]), !dbg [[DBG8]]
; CHECK-NEXT:    store i32 [[TMP12]], ptr [[A]], align 4, !dbg [[DBG8]]
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i16, ptr %b, align 2, !dbg !10
  %1 = sext i16 %0 to i32, !dbg !11
  store i32 %1, ptr %a, align 4, !dbg !12
  ret void
}

define void @MemSet(ptr nocapture %x) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @MemSet(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @__msan_memset(ptr [[X:%.*]], i32 42, i64 10), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.memset.p0.i64(ptr %x, i8 42, i64 10, i1 false), !dbg !10
  ret void
}

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind



define void @MemCpy(ptr nocapture %x, ptr nocapture %y) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @MemCpy(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = call ptr @__msan_memcpy(ptr [[X:%.*]], ptr [[Y:%.*]], i64 10), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.memcpy.p0.p0.i64(ptr %x, ptr %y, i64 10, i1 false), !dbg !10
  ret void
}

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind


define void @MemSetInline(ptr nocapture %x) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @MemSetInline(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @__msan_memset(ptr [[X:%.*]], i32 42, i64 10), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.memset.inline.p0.i64(ptr %x, i8 42, i64 10, i1 false), !dbg !10
  ret void
}

declare void @llvm.memset.inline.p0.i64(ptr nocapture, i8, i64, i1) nounwind


define void @MemCpyInline(ptr nocapture %x, ptr nocapture %y) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @MemCpyInline(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = call ptr @__msan_memcpy(ptr [[X:%.*]], ptr [[Y:%.*]], i64 10), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.memcpy.inline.p0.p0.i64(ptr %x, ptr %y, i64 10, i1 false), !dbg !10
  ret void
}

declare void @llvm.memcpy.inline.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind


define void @MemMove(ptr nocapture %x, ptr nocapture %y) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @MemMove(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = call ptr @__msan_memmove(ptr [[X:%.*]], ptr [[Y:%.*]], i64 10), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.memmove.p0.p0.i64(ptr %x, ptr %y, i64 10, i1 false), !dbg !10
  ret void
}

declare void @llvm.memmove.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind


declare void @llvm.memset.element.unordered.atomic.p0.i64(ptr nocapture writeonly, i8, i64, i32) nounwind
declare void @llvm.memmove.element.unordered.atomic.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i32) nounwind
declare void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i32) nounwind

define void @atomic_memcpy(ptr nocapture %x, ptr nocapture %y) nounwind {
; CHECK-LABEL: @atomic_memcpy(
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 [[X:%.*]], ptr align 2 [[Y:%.*]], i64 16, i32 1), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 %x, ptr align 2 %y, i64 16, i32 1), !dbg !10
  ret void
}

define void @atomic_memmove(ptr nocapture %x, ptr nocapture %y) nounwind {
; CHECK-LABEL: @atomic_memmove(
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i64(ptr align 1 [[X:%.*]], ptr align 2 [[Y:%.*]], i64 16, i32 1), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i64(ptr align 1 %x, ptr align 2 %y, i64 16, i32 1), !dbg !10
  ret void
}

define void @atomic_memset(ptr nocapture %x) nounwind {
; CHECK-LABEL: @atomic_memset(
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i64(ptr align 1 [[X:%.*]], i8 88, i64 16, i32 1), !dbg [[DBG1]]
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i64(ptr align 1 %x, i8 88, i64 16, i32 1), !dbg !10
  ret void
}




define i32 @Select(i32 %a, i32 %b, i1 %c) nounwind uwtable readnone sanitize_memory {
; CHECK-LABEL: @Select(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i1, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 16) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = select i1 [[C:%.*]], i32 [[TMP2]], i32 [[TMP4]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = xor i32 [[A:%.*]], [[B:%.*]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = or i32 [[TMP7]], [[TMP2]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP9:%.*]] = or i32 [[TMP8]], [[TMP4]], !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP_SELECT:%.*]] = select i1 [[TMP0]], i32 [[TMP9]], i32 [[TMP6]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP10:%.*]] = select i1 [[C]], i32 [[TMP3]], i32 [[TMP5]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP11:%.*]] = select i1 [[TMP0]], i32 [[TMP1]], i32 [[TMP10]], !dbg [[DBG1]]
; CHECK-NEXT:    [[COND:%.*]] = select i1 [[C]], i32 [[A]], i32 [[B]], !dbg [[DBG1]]
; CHECK-NEXT:    store i32 [[_MSPROP_SELECT]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP11]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cond = select i1 %c, i32 %a, i32 %b, !dbg !10
  ret i32 %cond
}




define <8 x i16> @SelectVector(<8 x i16> %a, <8 x i16> %b, <8 x i1> %c) nounwind uwtable readnone sanitize_memory {
; CHECK-LABEL: @SelectVector(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <8 x i1>, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 32) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 32) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load <8 x i16>, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load <8 x i16>, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 16) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = select <8 x i1> [[C:%.*]], <8 x i16> [[TMP2]], <8 x i16> [[TMP4]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = xor <8 x i16> [[A:%.*]], [[B:%.*]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = or <8 x i16> [[TMP7]], [[TMP2]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP9:%.*]] = or <8 x i16> [[TMP8]], [[TMP4]], !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP_SELECT:%.*]] = select <8 x i1> [[TMP0]], <8 x i16> [[TMP9]], <8 x i16> [[TMP6]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast <8 x i1> [[C]] to i8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP11:%.*]] = icmp ne i8 [[TMP10]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP12:%.*]] = bitcast <8 x i1> [[TMP0]] to i8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP13:%.*]] = icmp ne i8 [[TMP12]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP14:%.*]] = select i1 [[TMP11]], i32 [[TMP3]], i32 [[TMP5]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP15:%.*]] = select i1 [[TMP13]], i32 [[TMP1]], i32 [[TMP14]], !dbg [[DBG1]]
; CHECK-NEXT:    [[COND:%.*]] = select <8 x i1> [[C]], <8 x i16> [[A]], <8 x i16> [[B]], !dbg [[DBG1]]
; CHECK-NEXT:    store <8 x i16> [[_MSPROP_SELECT]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP15]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret <8 x i16> [[COND]]
;
entry:
  %cond = select <8 x i1> %c, <8 x i16> %a, <8 x i16> %b, !dbg !10
  ret <8 x i16> %cond
}




define ptr @IntToPtr(i64 %x) nounwind uwtable readnone sanitize_memory {
; CHECK-LABEL: @IntToPtr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = inttoptr i64 [[X:%.*]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    store i64 [[TMP0]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP1]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret ptr [[TMP2]]
;
entry:
  %0 = inttoptr i64 %x to ptr, !dbg !10
  ret ptr %0
}





define i32 @Div(i32 %a, i32 %b) nounwind uwtable readnone sanitize_memory {
; CHECK-LABEL: @Div(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_warning_4(i32 zeroext [[TMP0]], i32 zeroext [[TMP1]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 [[A:%.*]], [[B:%.*]], !dbg [[DBG1]]
; CHECK-NEXT:    store i32 [[TMP2]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP3]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[DIV]]
;
entry:
  %div = udiv i32 %a, %b, !dbg !10
  ret i32 %div
}







define i32 @ShadowLoadAlignmentLarge() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @ShadowLoadAlignmentLarge(
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[Y:%.*]] = alloca i32, align 64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[Y]] to i64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i64 [[TMP1]], 87960930222080, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP2]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP2]], 17592186044416, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = and i64 [[TMP4]], -4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = inttoptr i64 [[TMP5]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 64 [[TMP3]], i8 -1, i64 4, i1 false), !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_set_alloca_origin_with_descr(ptr [[Y]], i64 4, ptr @[[GLOB0:[0-9]+]], ptr @[[GLOB1:[0-9]+]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = load volatile i32, ptr [[Y]], align 64, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP9:%.*]] = ptrtoint ptr [[Y]] to i64, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP10:%.*]] = xor i64 [[TMP9]], 87960930222080, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP11:%.*]] = inttoptr i64 [[TMP10]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP12:%.*]] = add i64 [[TMP10]], 17592186044416, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP13:%.*]] = inttoptr i64 [[TMP12]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    [[_MSLD:%.*]] = load i32, ptr [[TMP11]], align 64, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, ptr [[TMP13]], align 64, !dbg [[DBG7]]
; CHECK-NEXT:    store i32 [[_MSLD]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP14]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[TMP8]]
;
  %y = alloca i32, align 64, !dbg !10
  %1 = load volatile i32, ptr %y, align 64, !dbg !11
  ret i32 %1
}



define i32 @ExtractElement(<4 x i32> %vec, i32 %idx) sanitize_memory {
; CHECK-LABEL: @ExtractElement(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 16) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x i32>, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP:%.*]] = extractelement <4 x i32> [[TMP3]], i32 [[IDX:%.*]], !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_warning_4(i32 zeroext [[TMP1]], i32 zeroext [[TMP2]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[X:%.*]] = extractelement <4 x i32> [[VEC:%.*]], i32 [[IDX]], !dbg [[DBG1]]
; CHECK-NEXT:    store i32 [[_MSPROP]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP4]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
  %x = extractelement <4 x i32> %vec, i32 %idx, !dbg !10
  ret i32 %x
}


define <4 x i32> @InsertElement(<4 x i32> %vec, i32 %idx, i32 %x) sanitize_memory {
; CHECK-LABEL: @InsertElement(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 16) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x i32>, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 24) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[TMP5]], i32 [[IDX:%.*]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ne i32 [[TMP5]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = select i1 [[TMP7]], i32 [[TMP6]], i32 [[TMP4]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ne i32 [[TMP1]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP10:%.*]] = select i1 [[TMP9]], i32 [[TMP2]], i32 [[TMP8]], !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_maybe_warning_4(i32 zeroext [[TMP1]], i32 zeroext [[TMP2]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[VEC1:%.*]] = insertelement <4 x i32> [[VEC:%.*]], i32 [[X:%.*]], i32 [[IDX]], !dbg [[DBG1]]
; CHECK-NEXT:    store <4 x i32> [[_MSPROP]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP10]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret <4 x i32> [[VEC1]]
;
  %vec1 = insertelement <4 x i32> %vec, i32 %x, i32 %idx, !dbg !10
  ret <4 x i32> %vec1
}


define <4 x i32> @ShuffleVector(<4 x i32> %vec, <4 x i32> %vec1) sanitize_memory {
; CHECK-LABEL: @ShuffleVector(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x i32>, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 16) to ptr), align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> [[TMP3]], <4 x i32> <i32 0, i32 4, i32 1, i32 5>, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <4 x i32> [[TMP3]] to i128, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ne i128 [[TMP5]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = select i1 [[TMP6]], i32 [[TMP4]], i32 [[TMP2]], !dbg [[DBG1]]
; CHECK-NEXT:    [[VEC2:%.*]] = shufflevector <4 x i32> [[VEC:%.*]], <4 x i32> [[VEC1:%.*]], <4 x i32> <i32 0, i32 4, i32 1, i32 5>, !dbg [[DBG1]]
; CHECK-NEXT:    store <4 x i32> [[_MSPROP]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 [[TMP7]], ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret <4 x i32> [[VEC2]]
;
  %vec2 = shufflevector <4 x i32> %vec, <4 x i32> %vec1, <4 x i32> <i32 0, i32 4, i32 1, i32 5>, !dbg !10
  ret <4 x i32> %vec2
}



%struct.__va_list_tag = type { i32, i32, ptr, ptr }
declare void @llvm.va_start(ptr) nounwind

define void @VAStart(i32 %x, ...) sanitize_memory {
; CHECK-LABEL: @VAStart(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 176, [[TMP0]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = alloca i8, i64 [[TMP1]], align 8, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP2]], i8 0, i64 [[TMP1]], i1 false), !dbg [[DBG1]]
; CHECK-NEXT:    [[SRCSZ:%.*]] = call i64 @llvm.umin.i64(i64 [[TMP1]], i64 800), !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP2]], ptr align 8 @__msan_va_arg_tls, i64 [[SRCSZ]], i1 false), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = alloca i8, i64 [[TMP1]], align 8, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP3]], ptr align 8 @__msan_va_arg_origin_tls, i64 [[SRCSZ]], i1 false), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP6:%.*]] = ptrtoint ptr [[X_ADDR]] to i64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP7:%.*]] = xor i64 [[TMP6]], 87960930222080, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP8:%.*]] = inttoptr i64 [[TMP7]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP9:%.*]] = add i64 [[TMP7]], 17592186044416, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP10:%.*]] = and i64 [[TMP9]], -4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP11:%.*]] = inttoptr i64 [[TMP10]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[TMP8]], i8 -1, i64 4, i1 false), !dbg [[DBG1]]
; CHECK-NEXT:    call void @__msan_set_alloca_origin_with_descr(ptr [[X_ADDR]], i64 4, ptr @[[GLOB2:[0-9]+]], ptr @[[GLOB3:[0-9]+]]), !dbg [[DBG1]]
; CHECK-NEXT:    [[VA:%.*]] = alloca [1 x %struct.__va_list_tag], align 16, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP13:%.*]] = ptrtoint ptr [[VA]] to i64, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP14:%.*]] = xor i64 [[TMP13]], 87960930222080, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP15:%.*]] = inttoptr i64 [[TMP14]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP16:%.*]] = add i64 [[TMP14]], 17592186044416, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP17:%.*]] = and i64 [[TMP16]], -4, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP18:%.*]] = inttoptr i64 [[TMP17]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 16 [[TMP15]], i8 -1, i64 24, i1 false), !dbg [[DBG7]]
; CHECK-NEXT:    call void @__msan_set_alloca_origin_with_descr(ptr [[VA]], i64 24, ptr @[[GLOB4:[0-9]+]], ptr @[[GLOB5:[0-9]+]]), !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP20:%.*]] = ptrtoint ptr [[X_ADDR]] to i64, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP21:%.*]] = xor i64 [[TMP20]], 87960930222080, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP22:%.*]] = inttoptr i64 [[TMP21]] to ptr, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP23:%.*]] = add i64 [[TMP21]], 17592186044416, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP24:%.*]] = inttoptr i64 [[TMP23]] to ptr, !dbg [[DBG8]]
; CHECK-NEXT:    store i32 [[TMP4]], ptr [[TMP22]], align 4, !dbg [[DBG8]]
; CHECK-NEXT:    call void @__msan_maybe_store_origin_4(i32 zeroext [[TMP4]], ptr [[X_ADDR]], i32 zeroext [[TMP5]]), !dbg [[DBG8]]
; CHECK-NEXT:    store i32 [[X:%.*]], ptr [[X_ADDR]], align 4, !dbg [[DBG8]]
; CHECK-NEXT:    [[TMP26:%.*]] = ptrtoint ptr [[VA]] to i64, !dbg [[DBG11:![0-9]+]]
; CHECK-NEXT:    [[TMP27:%.*]] = xor i64 [[TMP26]], 87960930222080, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP28:%.*]] = inttoptr i64 [[TMP27]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP29:%.*]] = add i64 [[TMP27]], 17592186044416, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP30:%.*]] = inttoptr i64 [[TMP29]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP28]], i8 0, i64 24, i1 false), !dbg [[DBG11]]
; CHECK-NEXT:    call void @llvm.va_start(ptr [[VA]]), !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP31:%.*]] = ptrtoint ptr [[VA]] to i64, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP32:%.*]] = add i64 [[TMP31]], 16, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP33:%.*]] = inttoptr i64 [[TMP32]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP34:%.*]] = load ptr, ptr [[TMP33]], align 8, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP35:%.*]] = ptrtoint ptr [[TMP34]] to i64, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP36:%.*]] = xor i64 [[TMP35]], 87960930222080, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP37:%.*]] = inttoptr i64 [[TMP36]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP38:%.*]] = add i64 [[TMP36]], 17592186044416, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP39:%.*]] = inttoptr i64 [[TMP38]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 16 [[TMP37]], ptr align 16 [[TMP2]], i64 176, i1 false), !dbg [[DBG11]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 16 [[TMP39]], ptr align 16 [[TMP3]], i64 176, i1 false), !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP41:%.*]] = ptrtoint ptr [[VA]] to i64, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP42:%.*]] = add i64 [[TMP41]], 8, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP43:%.*]] = inttoptr i64 [[TMP42]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP44:%.*]] = load ptr, ptr [[TMP43]], align 8, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP45:%.*]] = ptrtoint ptr [[TMP44]] to i64, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP46:%.*]] = xor i64 [[TMP45]], 87960930222080, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP47:%.*]] = inttoptr i64 [[TMP46]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP48:%.*]] = add i64 [[TMP46]], 17592186044416, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP49:%.*]] = inttoptr i64 [[TMP48]] to ptr, !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP50:%.*]] = getelementptr i8, ptr [[TMP2]], i32 176, !dbg [[DBG11]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 16 [[TMP47]], ptr align 16 [[TMP50]], i64 [[TMP0]], i1 false), !dbg [[DBG11]]
; CHECK-NEXT:    [[TMP51:%.*]] = getelementptr i8, ptr [[TMP3]], i32 176, !dbg [[DBG11]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 16 [[TMP49]], ptr align 16 [[TMP51]], i64 [[TMP0]], i1 false), !dbg [[DBG11]]
; CHECK-NEXT:    ret void
;
entry:
  %x.addr = alloca i32, align 4, !dbg !10
  %va = alloca [1 x %struct.__va_list_tag], align 16, !dbg !11
  store i32 %x, ptr %x.addr, align 4, !dbg !12
  call void @llvm.va_start(ptr %va), !dbg !15
  ret void
}



define i32 @NoSanitizeMemory(i32 %x) uwtable {
; CHECK-LABEL: @NoSanitizeMemory(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP0:%.*]] = xor i32 [[X:%.*]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 -1, [[TMP0]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSPROP_ICMP:%.*]] = and i1 false, [[TMP2]], !dbg [[DBG1]]
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[X]], 0, !dbg [[DBG1]]
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_END:%.*]], label [[IF_THEN:%.*]], !dbg [[DBG7]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @bar(), !dbg [[DBG8]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  %tobool = icmp eq i32 %x, 0, !dbg !10
  br i1 %tobool, label %if.end, label %if.then, !dbg !11

if.then:                                            tail call void @bar(), !dbg !12
  br label %if.end

if.end:                                             ret i32 %x
}

declare void @bar()




define i32 @NoSanitizeMemoryAlloca() {
; CHECK-LABEL: @NoSanitizeMemoryAlloca(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[P:%.*]] = alloca i32, align 4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[P]] to i64, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP1:%.*]] = xor i64 [[TMP0]], 87960930222080, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP2:%.*]] = inttoptr i64 [[TMP1]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[TMP1]], 17592186044416, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], -4, !dbg [[DBG1]]
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[TMP2]], i8 0, i64 4, i1 false), !dbg [[DBG1]]
; CHECK-NEXT:    store i64 0, ptr @__msan_param_tls, align 8, !dbg [[DBG7]]
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8, !dbg [[DBG7]]
; CHECK-NEXT:    [[X:%.*]] = call i32 @NoSanitizeMemoryAllocaHelper(ptr [[P]]), !dbg [[DBG7]]
; CHECK-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  %p = alloca i32, align 4, !dbg !10
  %x = call i32 @NoSanitizeMemoryAllocaHelper(ptr %p), !dbg !11
  ret i32 %x
}

declare i32 @NoSanitizeMemoryAllocaHelper(ptr %p)




define i32 @NoSanitizeMemoryUndef() {
; CHECK-LABEL: @NoSanitizeMemoryUndef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    store i32 0, ptr @__msan_param_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8, !dbg [[DBG1]]
; CHECK-NEXT:    [[X:%.*]] = call i32 @NoSanitizeMemoryUndefHelper(i32 undef), !dbg [[DBG1]]
; CHECK-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  %x = call i32 @NoSanitizeMemoryUndefHelper(i32 undef), !dbg !10
  ret i32 %x
}

declare i32 @NoSanitizeMemoryUndefHelper(i32 %x)

declare void @llvm.lifetime.start.p0(i64 immarg %0, ptr nocapture %1)
declare void @llvm.lifetime.end.p0(i64 immarg %0, ptr nocapture %1)
declare void @foo8(ptr nocapture)


define void @msan() sanitize_memory {
; CHECK-LABEL: @msan(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.donothing(), !dbg [[DBG1]]
; CHECK-NEXT:    [[TEXT:%.*]] = alloca i8, align 1, !dbg [[DBG1]]
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 1, ptr [[TEXT]]), !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[TEXT]] to i64, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP1:%.*]] = xor i64 [[TMP0]], 87960930222080, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP2:%.*]] = inttoptr i64 [[TMP1]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[TMP1]], 17592186044416, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], -4, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr, !dbg [[DBG7]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[TMP2]], i8 -1, i64 1, i1 false), !dbg [[DBG7]]
; CHECK-NEXT:    call void @__msan_set_alloca_origin_with_descr(ptr [[TEXT]], i64 1, ptr @[[GLOB6:[0-9]+]], ptr @[[GLOB7:[0-9]+]]), !dbg [[DBG7]]
; CHECK-NEXT:    store i64 0, ptr @__msan_param_tls, align 8, !dbg [[DBG8]]
; CHECK-NEXT:    call void @foo8(ptr [[TEXT]]), !dbg [[DBG8]]
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 1, ptr [[TEXT]]), !dbg
; CHECK-NEXT:    ret void, !dbg
;
entry:
  %text = alloca i8, align 1, !dbg !10
  call void @llvm.lifetime.start.p0(i64 1, ptr %text), !dbg !11
  call void @foo8(ptr %text), !dbg !12
  call void @llvm.lifetime.end.p0(i64 1, ptr %text), !dbg !13
  ret void, !dbg !14
}
