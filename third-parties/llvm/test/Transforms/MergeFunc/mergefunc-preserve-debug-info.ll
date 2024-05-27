; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes='default<O0>,mergefunc' -S -mergefunc-preserve-debug-info < %s | FileCheck %s --check-prefix=OPTIMIZATION_LEVEL_0
; RUN: opt -passes='default<O2>,mergefunc' -S -mergefunc-preserve-debug-info < %s | FileCheck %s --check-prefix=OPTIMIZATION_LEVEL_2

; Preserve debug info in thunks under -passes=mergefunc -mergefunc-preserve-debug-info
;
; We test that:
; At -O0 we have preserved the generated @llvm.dbg.declare debug intrinsics.
; At -O2 we have preserved the generated @llvm.dbg.value debug intrinsics.
; At -O0, stores from the incoming parameters to locations on the stack-frame
;         and allocas that create these locations on the stack-frame are preserved.
; Debug info got generated for the call made by the thunk and for its return value.
; The foregoing is the only content of a thunk's entry block.
; A thunk makes a tail call to the shared implementation.
; A thunk's call site is preserved to point to the thunk (with only -passes=mergefunc the
;   call site is modified to point to the shared implementation) when both occur
;   within the same translation unit.

; The source code that was used to test and generate this LLVM IR is:
;
; int maxA(int x, int y) {
;   int i, m, j;
;   if (x > y)
;     m = x;
;   else
;     m = y;
;   return m;
; }
;
; int maxB(int x, int y) {
;   int i, m, j;
;   if (x > y)
;     m = x;
;   else
;     m = y;
;   return m;
; }
;
; void f(void) {
;
;   maxA(3, 4);
;   maxB(1, 9);
; }

; Function Attrs: nounwind uwtable
define i32 @maxA(i32 %x, i32 %y) !dbg !6 {
; OPTIMIZATION_LEVEL_0-LABEL: define i32 @maxA
; OPTIMIZATION_LEVEL_0-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) !dbg [[DBG6:![0-9]+]] {
; OPTIMIZATION_LEVEL_0-NEXT:  entry:
; OPTIMIZATION_LEVEL_0-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    [[Y_ADDR:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    [[I:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    [[M:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    [[J:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    store i32 [[X]], ptr [[X_ADDR]], align 4
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[X_ADDR]], metadata [[META11:![0-9]+]], metadata !DIExpression()), !dbg [[DBG12:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    store i32 [[Y]], ptr [[Y_ADDR]], align 4
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[Y_ADDR]], metadata [[META13:![0-9]+]], metadata !DIExpression()), !dbg [[DBG14:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[I]], metadata [[META15:![0-9]+]], metadata !DIExpression()), !dbg [[DBG16:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[M]], metadata [[META17:![0-9]+]], metadata !DIExpression()), !dbg [[DBG18:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[J]], metadata [[META19:![0-9]+]], metadata !DIExpression()), !dbg [[DBG20:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    [[TMP0:%.*]] = load i32, ptr [[X_ADDR]], align 4, !dbg [[DBG21:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    [[TMP1:%.*]] = load i32, ptr [[Y_ADDR]], align 4, !dbg [[DBG23:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP0]], [[TMP1]], !dbg [[DBG24:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]], !dbg [[DBG25:![0-9]+]]
; OPTIMIZATION_LEVEL_0:       if.then:
; OPTIMIZATION_LEVEL_0-NEXT:    [[TMP2:%.*]] = load i32, ptr [[X_ADDR]], align 4, !dbg [[DBG26:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    store i32 [[TMP2]], ptr [[M]], align 4, !dbg [[DBG27:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    br label [[IF_END:%.*]], !dbg [[DBG28:![0-9]+]]
; OPTIMIZATION_LEVEL_0:       if.else:
; OPTIMIZATION_LEVEL_0-NEXT:    [[TMP3:%.*]] = load i32, ptr [[Y_ADDR]], align 4, !dbg [[DBG29:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    store i32 [[TMP3]], ptr [[M]], align 4, !dbg [[DBG30:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    br label [[IF_END]]
; OPTIMIZATION_LEVEL_0:       if.end:
; OPTIMIZATION_LEVEL_0-NEXT:    [[TMP4:%.*]] = load i32, ptr [[M]], align 4, !dbg [[DBG31:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    ret i32 [[TMP4]], !dbg [[DBG32:![0-9]+]]
;
; OPTIMIZATION_LEVEL_2-LABEL: define i32 @maxA
; OPTIMIZATION_LEVEL_2-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] !dbg [[DBG6:![0-9]+]] {
; OPTIMIZATION_LEVEL_2-NEXT:  entry:
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.value(metadata i32 [[X]], metadata [[META11:![0-9]+]], metadata !DIExpression()), !dbg [[DBG12:![0-9]+]]
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.value(metadata i32 [[Y]], metadata [[META13:![0-9]+]], metadata !DIExpression()), !dbg [[DBG12]]
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.declare(metadata ptr undef, metadata [[META14:![0-9]+]], metadata !DIExpression()), !dbg [[DBG15:![0-9]+]]
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.declare(metadata ptr undef, metadata [[META16:![0-9]+]], metadata !DIExpression()), !dbg [[DBG17:![0-9]+]]
; OPTIMIZATION_LEVEL_2-NEXT:    [[X_Y:%.*]] = tail call i32 @llvm.smax.i32(i32 [[X]], i32 [[Y]])
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.value(metadata i32 [[X_Y]], metadata [[META18:![0-9]+]], metadata !DIExpression()), !dbg [[DBG12]]
; OPTIMIZATION_LEVEL_2-NEXT:    ret i32 [[X_Y]], !dbg [[DBG19:![0-9]+]]
;
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %m = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !11, metadata !12), !dbg !13
  store i32 %y, ptr %y.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %y.addr, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata ptr %i, metadata !16, metadata !12), !dbg !17
  call void @llvm.dbg.declare(metadata ptr %m, metadata !18, metadata !12), !dbg !19
  call void @llvm.dbg.declare(metadata ptr %j, metadata !20, metadata !12), !dbg !21
  %0 = load i32, ptr %x.addr, align 4, !dbg !22
  %1 = load i32, ptr %y.addr, align 4, !dbg !24
  %cmp = icmp sgt i32 %0, %1, !dbg !25
  br i1 %cmp, label %if.then, label %if.else, !dbg !26

if.then:                                          ; preds = %entry
  %2 = load i32, ptr %x.addr, align 4, !dbg !27
  store i32 %2, ptr %m, align 4, !dbg !28
  br label %if.end, !dbg !29

if.else:                                          ; preds = %entry
  %3 = load i32, ptr %y.addr, align 4, !dbg !30
  store i32 %3, ptr %m, align 4, !dbg !31
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, ptr %m, align 4, !dbg !32
  ret i32 %4, !dbg !33
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata)

; Function Attrs: nounwind uwtable
define i32 @maxB(i32 %x, i32 %y) !dbg !34 {
; OPTIMIZATION_LEVEL_0-LABEL: define i32 @maxB
; OPTIMIZATION_LEVEL_0-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) !dbg [[DBG33:![0-9]+]] {
; OPTIMIZATION_LEVEL_0-NEXT:  entry:
; OPTIMIZATION_LEVEL_0-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    [[Y_ADDR:%.*]] = alloca i32, align 4
; OPTIMIZATION_LEVEL_0-NEXT:    store i32 [[X]], ptr [[X_ADDR]], align 4
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[X_ADDR]], metadata [[META34:![0-9]+]], metadata !DIExpression()), !dbg [[DBG35:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    store i32 [[Y]], ptr [[Y_ADDR]], align 4
; OPTIMIZATION_LEVEL_0-NEXT:    call void @llvm.dbg.declare(metadata ptr [[Y_ADDR]], metadata [[META36:![0-9]+]], metadata !DIExpression()), !dbg [[DBG37:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    [[TMP0:%.*]] = tail call i32 @maxA(i32 [[X]], i32 [[Y]]), !dbg [[DBG38:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    ret i32 [[TMP0]], !dbg [[DBG38]]
;
; OPTIMIZATION_LEVEL_2-LABEL: define i32 @maxB
; OPTIMIZATION_LEVEL_2-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) local_unnamed_addr #[[ATTR0]] !dbg [[DBG20:![0-9]+]] {
; OPTIMIZATION_LEVEL_2-NEXT:  entry:
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.value(metadata i32 [[X]], metadata [[META21:![0-9]+]], metadata !DIExpression()), !dbg [[DBG22:![0-9]+]]
; OPTIMIZATION_LEVEL_2-NEXT:    call void @llvm.dbg.value(metadata i32 [[Y]], metadata [[META23:![0-9]+]], metadata !DIExpression()), !dbg [[DBG22]]
; OPTIMIZATION_LEVEL_2-NEXT:    [[TMP0:%.*]] = tail call i32 @maxA(i32 [[X]], i32 [[Y]]) #[[ATTR0]], !dbg [[DBG24:![0-9]+]]
; OPTIMIZATION_LEVEL_2-NEXT:    ret i32 [[TMP0]], !dbg [[DBG24]]
;


entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %m = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !35, metadata !12), !dbg !36
  store i32 %y, ptr %y.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %y.addr, metadata !37, metadata !12), !dbg !38
  call void @llvm.dbg.declare(metadata ptr %i, metadata !39, metadata !12), !dbg !40
  call void @llvm.dbg.declare(metadata ptr %m, metadata !41, metadata !12), !dbg !42
  call void @llvm.dbg.declare(metadata ptr %j, metadata !43, metadata !12), !dbg !44
  %0 = load i32, ptr %x.addr, align 4, !dbg !45
  %1 = load i32, ptr %y.addr, align 4, !dbg !47
  %cmp = icmp sgt i32 %0, %1, !dbg !48
  br i1 %cmp, label %if.then, label %if.else, !dbg !49

if.then:                                          ; preds = %entry
  %2 = load i32, ptr %x.addr, align 4, !dbg !50
  store i32 %2, ptr %m, align 4, !dbg !51
  br label %if.end, !dbg !52

if.else:                                          ; preds = %entry
  %3 = load i32, ptr %y.addr, align 4, !dbg !53
  store i32 %3, ptr %m, align 4, !dbg !54
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, ptr %m, align 4, !dbg !55
  ret i32 %4, !dbg !56
}

; Function Attrs: nounwind uwtable
define void @f() !dbg !57 {
; OPTIMIZATION_LEVEL_0-LABEL: define void @f
; OPTIMIZATION_LEVEL_0-SAME: () !dbg [[DBG39:![0-9]+]] {
; OPTIMIZATION_LEVEL_0-NEXT:  entry:
; OPTIMIZATION_LEVEL_0-NEXT:    [[CALL:%.*]] = call i32 @maxA(i32 3, i32 4), !dbg [[DBG42:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    [[CALL1:%.*]] = call i32 @maxB(i32 1, i32 9), !dbg [[DBG43:![0-9]+]]
; OPTIMIZATION_LEVEL_0-NEXT:    ret void, !dbg [[DBG44:![0-9]+]]
;
; OPTIMIZATION_LEVEL_2-LABEL: define void @f
; OPTIMIZATION_LEVEL_2-SAME: () local_unnamed_addr #[[ATTR2:[0-9]+]] !dbg [[DBG25:![0-9]+]] {
; OPTIMIZATION_LEVEL_2-NEXT:  entry:
; OPTIMIZATION_LEVEL_2-NEXT:    ret void, !dbg [[DBG28:![0-9]+]]
;
entry:
  %call = call i32 @maxA(i32 3, i32 4), !dbg !60
  %call1 = call i32 @maxB(i32 1, i32 9), !dbg !61
  ret void, !dbg !62
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "mergefunc-preserve-debug-info.c", directory: "")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!""}
!6 = distinct !DISubprogram(name: "maxA", scope: !7, file: !7, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!7 = !DIFile(filename: "./mergefunc-preserve-debug-info.c", directory: "")
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x", arg: 1, scope: !6, file: !7, line: 1, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 1, column: 14, scope: !6)
!14 = !DILocalVariable(name: "y", arg: 2, scope: !6, file: !7, line: 1, type: !10)
!15 = !DILocation(line: 1, column: 21, scope: !6)
!16 = !DILocalVariable(name: "i", scope: !6, file: !7, line: 2, type: !10)
!17 = !DILocation(line: 2, column: 7, scope: !6)
!18 = !DILocalVariable(name: "m", scope: !6, file: !7, line: 2, type: !10)
!19 = !DILocation(line: 2, column: 10, scope: !6)
!20 = !DILocalVariable(name: "j", scope: !6, file: !7, line: 2, type: !10)
!21 = !DILocation(line: 2, column: 13, scope: !6)
!22 = !DILocation(line: 3, column: 7, scope: !23)
!23 = distinct !DILexicalBlock(scope: !6, file: !7, line: 3, column: 7)
!24 = !DILocation(line: 3, column: 11, scope: !23)
!25 = !DILocation(line: 3, column: 9, scope: !23)
!26 = !DILocation(line: 3, column: 7, scope: !6)
!27 = !DILocation(line: 4, column: 9, scope: !23)
!28 = !DILocation(line: 4, column: 7, scope: !23)
!29 = !DILocation(line: 4, column: 5, scope: !23)
!30 = !DILocation(line: 6, column: 9, scope: !23)
!31 = !DILocation(line: 6, column: 7, scope: !23)
!32 = !DILocation(line: 7, column: 10, scope: !6)
!33 = !DILocation(line: 7, column: 3, scope: !6)
!34 = distinct !DISubprogram(name: "maxB", scope: !7, file: !7, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!35 = !DILocalVariable(name: "x", arg: 1, scope: !34, file: !7, line: 10, type: !10)
!36 = !DILocation(line: 10, column: 14, scope: !34)
!37 = !DILocalVariable(name: "y", arg: 2, scope: !34, file: !7, line: 10, type: !10)
!38 = !DILocation(line: 10, column: 21, scope: !34)
!39 = !DILocalVariable(name: "i", scope: !34, file: !7, line: 11, type: !10)
!40 = !DILocation(line: 11, column: 7, scope: !34)
!41 = !DILocalVariable(name: "m", scope: !34, file: !7, line: 11, type: !10)
!42 = !DILocation(line: 11, column: 10, scope: !34)
!43 = !DILocalVariable(name: "j", scope: !34, file: !7, line: 11, type: !10)
!44 = !DILocation(line: 11, column: 13, scope: !34)
!45 = !DILocation(line: 12, column: 7, scope: !46)
!46 = distinct !DILexicalBlock(scope: !34, file: !7, line: 12, column: 7)
!47 = !DILocation(line: 12, column: 11, scope: !46)
!48 = !DILocation(line: 12, column: 9, scope: !46)
!49 = !DILocation(line: 12, column: 7, scope: !34)
!50 = !DILocation(line: 13, column: 9, scope: !46)
!51 = !DILocation(line: 13, column: 7, scope: !46)
!52 = !DILocation(line: 13, column: 5, scope: !46)
!53 = !DILocation(line: 15, column: 9, scope: !46)
!54 = !DILocation(line: 15, column: 7, scope: !46)
!55 = !DILocation(line: 16, column: 10, scope: !34)
!56 = !DILocation(line: 16, column: 3, scope: !34)
!57 = distinct !DISubprogram(name: "f", scope: !7, file: !7, line: 19, type: !58, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!58 = !DISubroutineType(types: !59)
!59 = !{null}
!60 = !DILocation(line: 21, column: 3, scope: !57)
!61 = !DILocation(line: 22, column: 3, scope: !57)
!62 = !DILocation(line: 23, column: 1, scope: !57)
