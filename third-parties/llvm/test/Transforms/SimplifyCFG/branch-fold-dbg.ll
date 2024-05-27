; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S < %s | FileCheck %s
; RUN: opt -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S < %s --try-experimental-debuginfo-iterators | FileCheck %s

%0 = type { ptr, ptr }

@0 = external hidden constant [5 x %0], align 4

define i1 @foo(i32) nounwind ssp !dbg !0 {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[TMP0:%.*]], 0, !dbg [[DBG7:![0-9]+]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP0]], 4, !dbg [[DBG7]]
; CHECK-NEXT:    [[OR_COND:%.*]] = or i1 [[TMP1]], [[TMP2]], !dbg [[DBG7]]
; CHECK-NEXT:    br i1 [[OR_COND]], label [[COMMON_RET:%.*]], label [[BB2:%.*]], !dbg [[DBG7]]
; CHECK:       BB2:
; CHECK-NEXT:    [[TMP3:%.*]] = shl i32 1, [[TMP0]], !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP4:%.*]] = and i32 [[TMP3]], 31, !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP4]], 0, !dbg [[DBG7]]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata ptr null, metadata [[META8:![0-9]+]], metadata !DIExpression()), !dbg [[DBG13:![0-9]+]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [5 x %0], ptr @[[GLOB0:[0-9]+]], i32 0, i32 [[TMP0]]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata ptr [[TMP6]], metadata [[META8]], metadata !DIExpression()), !dbg [[DBG13]]
; CHECK-NEXT:    [[TMP7:%.*]] = icmp eq ptr [[TMP6]], null
; CHECK-NEXT:    call void @llvm.dbg.value(metadata ptr [[TMP6]], metadata [[META8]], metadata !DIExpression()), !dbg [[DBG13]]
; CHECK-NEXT:    [[OR_COND2:%.*]] = select i1 [[TMP5]], i1 true, i1 [[TMP7]], !dbg [[DBG7]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp slt i32 [[TMP0]], 0
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[OR_COND2]], i1 false, i1 [[TMP8]], !dbg [[DBG7]]
; CHECK-NEXT:    br label [[COMMON_RET]], !dbg [[DBG7]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ [[SPEC_SELECT]], [[BB2]] ]
; CHECK-NEXT:    ret i1 [[COMMON_RET_OP]], !dbg [[DBG14:![0-9]+]]
;
Entry:
  %1 = icmp slt i32 %0, 0, !dbg !5
  br i1 %1, label %BB5, label %BB1, !dbg !5

BB1:                                              ; preds = %Entry
  %2 = icmp sgt i32 %0, 4, !dbg !5
  br i1 %2, label %BB5, label %BB2, !dbg !5

BB2:                                              ; preds = %BB1
  %3 = shl i32 1, %0, !dbg !5
  %4 = and i32 %3, 31, !dbg !5
  %5 = icmp eq i32 %4, 0, !dbg !5
  br i1 %5, label %BB5, label %BB3, !dbg !5


BB3:                                              ; preds = %BB2
  call void @llvm.dbg.value(metadata ptr null, metadata !7, metadata !DIExpression()), !dbg !12
  %6 = getelementptr inbounds [5 x %0], ptr @0, i32 0, i32 %0, !dbg !6
  call void @llvm.dbg.value(metadata ptr %6, metadata !7, metadata !DIExpression()), !dbg !12
  %7 = icmp eq ptr %6, null, !dbg !13
  call void @llvm.dbg.value(metadata ptr %6, metadata !7, metadata !DIExpression()), !dbg !12
  br i1 %7, label %BB5, label %BB4, !dbg !13

BB4:                                              ; preds = %BB3
  %8 = icmp slt i32 %0, 0, !dbg !5
  ret i1 %8, !dbg !14

BB5:                                              ; preds = %BB3, %BB2, %BB1, %Entry
  ret i1 false, !dbg !14
}

declare void @llvm.dbg.value(metadata, metadata, metadata) nounwind readnone

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!16, !17}

!0 = distinct !DISubprogram(name: "foo", line: 231, isLocal: false, isDefinition: true, virtualIndex: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !2, file: !15, scope: !1, type: !3)
!1 = !DIFile(filename: "a.c", directory: "/private/tmp")
!2 = distinct !DICompileUnit(language: DW_LANG_C99, producer: "clang (trunk 129006)", isOptimized: true, emissionKind: FullDebug, file: !15, enums: !4, retainedTypes: !4)
!3 = !DISubroutineType(types: !4)
!4 = !{}
!5 = !DILocation(line: 131, column: 2, scope: !0)
!6 = !DILocation(line: 134, column: 2, scope: !0)
!7 = !DILocalVariable(name: "bar", line: 232, scope: !8, file: !1, type: !9)
!8 = distinct !DILexicalBlock(line: 231, column: 1, file: !15, scope: !0)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, size: 32, align: 32, scope: !2, baseType: !10)
!10 = !DIDerivedType(tag: DW_TAG_const_type, scope: !2, baseType: !11)
!11 = !DIBasicType(tag: DW_TAG_base_type, name: "unsigned int", size: 32, align: 32, encoding: DW_ATE_unsigned)
!12 = !DILocation(line: 232, column: 40, scope: !8)
!13 = !DILocation(line: 234, column: 2, scope: !8)
!14 = !DILocation(line: 274, column: 1, scope: !8)
!15 = !DIFile(filename: "a.c", directory: "/private/tmp")
!16 = !{i32 1, !"Debug Info Version", i32 3}
!17 = !{i32 2, !"Dwarf Version", i32 4}
