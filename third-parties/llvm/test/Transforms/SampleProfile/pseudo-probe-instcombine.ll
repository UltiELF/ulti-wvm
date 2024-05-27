; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -available-load-scan-limit=2 -S < %s | FileCheck %s

%struct.nonbonded = type { [2 x ptr], [2 x ptr], [2 x ptr], [2 x ptr], [2 x ptr], [2 x i32], %class.Vector, ptr, ptr, ptr, ptr, i32, i32, double, double, i32, i32, i32, i32 }
%struct.CompAtomExt = type { i32 }
%struct.CompAtom = type { %class.Vector, float, i16, i8, i8 }
%class.Vector = type { double, double, double }
%class.ComputeNonbondedWorkArrays = type { %class.ResizeArray, %class.ResizeArray.0, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray, %class.ResizeArray.2, %class.ResizeArray.2 }
%class.ResizeArray.0 = type { ptr, ptr }
%class.ResizeArrayRaw.1 = type <{ ptr, ptr, i32, i32, i32, float, i32, [4 x i8] }>
%class.ResizeArray = type { ptr, ptr }
%class.ResizeArrayRaw = type <{ ptr, ptr, i32, i32, i32, float, i32, [4 x i8] }>
%class.ResizeArray.2 = type { ptr, ptr }
%class.ResizeArrayRaw.3 = type <{ ptr, ptr, i32, i32, i32, float, i32, [4 x i8] }>
%class.Pairlists = type { ptr, i32, i32 }

;; Check the minPart4 and minPart assignments are merged.
define dso_local void @merge(ptr nocapture readonly %params) local_unnamed_addr align 2 {
; CHECK-LABEL: @merge(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SAVEPAIRLISTS3:%.*]] = getelementptr inbounds [[STRUCT_NONBONDED:%.*]], ptr [[PARAMS:%.*]], i64 0, i32 11
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[SAVEPAIRLISTS3]], align 8
; CHECK-NEXT:    [[USEPAIRLISTS4:%.*]] = getelementptr inbounds [[STRUCT_NONBONDED]], ptr [[PARAMS]], i64 0, i32 12
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[USEPAIRLISTS4]], align 4
; CHECK-NEXT:    [[TOBOOL54_NOT:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TOBOOL54_NOT]], label [[LOR_LHS_FALSE55:%.*]], label [[IF_END109:%.*]]
; CHECK:       lor.lhs.false55:
; CHECK-NEXT:    [[TOBOOL56_NOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TOBOOL56_NOT]], label [[IF_END109]], label [[IF_END109_THREAD:%.*]]
; CHECK:       if.end109.thread:
; CHECK-NEXT:    call void @llvm.pseudoprobe(i64 -6172701105289426098, i64 2, i32 0, i64 -1)
; CHECK-NEXT:    br label [[IF_THEN138:%.*]]
; CHECK:       if.end109:
; CHECK-NEXT:    call void @llvm.pseudoprobe(i64 -6172701105289426098, i64 3, i32 0, i64 -1)
; CHECK-NEXT:    [[TOBOOL116_NOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TOBOOL116_NOT]], label [[IF_THEN117:%.*]], label [[IF_THEN138]]
; CHECK:       if.then117:
; CHECK-NEXT:    ret void
; CHECK:       if.then138:
; CHECK-NEXT:    [[DOTIN:%.*]] = getelementptr inbounds [[STRUCT_NONBONDED]], ptr [[PARAMS]], i64 0, i32 16
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTIN]], align 4
; CHECK-NEXT:    [[TOBOOL139_NOT:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TOBOOL139_NOT]], label [[IF_ELSE147:%.*]], label [[IF_THEN140:%.*]]
; CHECK:       if.then140:
; CHECK-NEXT:    ret void
; CHECK:       if.else147:
; CHECK-NEXT:    ret void
;
entry:
  %savePairlists3 = getelementptr inbounds %struct.nonbonded, ptr %params, i64 0, i32 11
  %0 = load i32, ptr %savePairlists3, align 8
  %usePairlists4 = getelementptr inbounds %struct.nonbonded, ptr %params, i64 0, i32 12
  %1 = load i32, ptr %usePairlists4, align 4
  %tobool54.not = icmp eq i32 %0, 0
  br i1 %tobool54.not, label %lor.lhs.false55, label %if.end109

lor.lhs.false55:                                  ; preds = %entry
  %tobool56.not = icmp eq i32 %1, 0
  br i1 %tobool56.not, label %if.end109, label %if.end109.thread

if.end109.thread:                                 ; preds = %lor.lhs.false55
  %minPart4 = getelementptr inbounds %struct.nonbonded, ptr %params, i64 0, i32 16
  %2 = load i32, ptr %minPart4, align 4
  call void @llvm.pseudoprobe(i64 -6172701105289426098, i64 2, i32 0, i64 -1)
  br label %if.then138

if.end109:                                        ; preds = %lor.lhs.false55, %entry
  %minPart = getelementptr inbounds %struct.nonbonded, ptr %params, i64 0, i32 16
  %3 = load i32, ptr %minPart, align 4
  call void @llvm.pseudoprobe(i64 -6172701105289426098, i64 3, i32 0, i64 -1)
  %tobool116.not = icmp eq i32 %1, 0
  br i1 %tobool116.not, label %if.then117, label %if.then138

if.then117:                                       ; preds = %if.end109
  ret void

if.then138:                                       ; preds = %if.end109.thread, %if.end109
  %4 = phi i32 [ %2, %if.end109.thread ], [ %3, %if.end109 ]
  %tobool139.not = icmp eq i32 %4, 0
  br i1 %tobool139.not, label %if.else147, label %if.then140

if.then140:                                       ; preds = %if.then138
  ret void

if.else147:                                       ; preds = %if.then138
  ret void
}

;; Check the last store is deleted.
define i32 @load(ptr nocapture %a, ptr nocapture %b) {
; CHECK-LABEL: @load(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 1
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[TMP1]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i64 1
; CHECK-NEXT:    store i32 [[TMP2]], ptr [[TMP3]], align 8
; CHECK-NEXT:    call void @llvm.pseudoprobe(i64 5116412291814990879, i64 1, i32 0, i64 -1)
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = getelementptr inbounds i32, ptr %a, i32 1
  %2 = load i32, ptr %1, align 8
  %3 = getelementptr inbounds i32, ptr %b, i32 1
  store i32 %2, ptr %3, align 8
  %4 = getelementptr inbounds i32, ptr %b, i32 1
  call void @llvm.pseudoprobe(i64 5116412291814990879, i64 1, i32 0, i64 -1)
  %5 = load i32, ptr %4, align 8
  ret i32 %5
}

;; Check the first store is deleted.
define void @dse(ptr %p) {
; CHECK-LABEL: @dse(
; CHECK-NEXT:    call void @llvm.pseudoprobe(i64 5116412291814990879, i64 1, i32 0, i64 -1)
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %p
  call void @llvm.pseudoprobe(i64 5116412291814990879, i64 1, i32 0, i64 -1)
  store i32 0, ptr %p
  ret void
}

; Function Attrs: inaccessiblememonly nounwind willreturn
declare void @llvm.pseudoprobe(i64, i64, i32, i64) #0

attributes #0 = { inaccessiblememonly nounwind willreturn }
