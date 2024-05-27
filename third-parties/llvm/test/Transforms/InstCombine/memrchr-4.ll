; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
;
; Verify that memrchr calls with a string consisting of all the same
; characters are folded and those with mixed strings are not.

declare ptr @memrchr(ptr, i32, i64)

@a11111 = constant [5 x i8] c"\01\01\01\01\01"
@a1110111 = constant [7 x i8] c"\01\01\01\00\01\01\01"


; Fold memrchr(a11111, C, 5) to *a11111 == C ? a11111 + 5 - 1 : null.

define ptr @fold_memrchr_a11111_c_5(i32 %C) {
; CHECK-LABEL: @fold_memrchr_a11111_c_5(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[MEMRCHR_SEL:%.*]] = select i1 [[TMP2]], ptr getelementptr inbounds ([5 x i8], ptr @a11111, i64 0, i64 4), ptr null
; CHECK-NEXT:    ret ptr [[MEMRCHR_SEL]]
;

  %ret = call ptr @memrchr(ptr @a11111, i32 %C, i64 5)
  ret ptr %ret
}


; Fold memrchr(a11111, C, N) to N && *a11111 == C ? a11111 + N - 1 : null,
; on the assumption that N is in bounds.

define ptr @fold_memrchr_a11111_c_n(i32 %C, i64 %N) {
; CHECK-LABEL: @fold_memrchr_a11111_c_n(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne i64 [[N:%.*]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i8 [[TMP2]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP1]], i1 [[TMP3]], i1 false
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i8, ptr @a11111, i64 [[N]]
; CHECK-NEXT:    [[MEMRCHR_PTR_PLUS:%.*]] = getelementptr i8, ptr [[TMP5]], i64 -1
; CHECK-NEXT:    [[MEMRCHR_SEL:%.*]] = select i1 [[TMP4]], ptr [[MEMRCHR_PTR_PLUS]], ptr null
; CHECK-NEXT:    ret ptr [[MEMRCHR_SEL]]
;

  %ret = call ptr @memrchr(ptr @a11111, i32 %C, i64 %N)
  ret ptr %ret
}


; Fold memrchr(a1110111, C, 3) to a1110111[2] == C ? a1110111 + 2 : null.

define ptr @fold_memrchr_a1110111_c_3(i32 %C) {
; CHECK-LABEL: @fold_memrchr_a1110111_c_3(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[MEMRCHR_SEL:%.*]] = select i1 [[TMP2]], ptr getelementptr inbounds ([7 x i8], ptr @a1110111, i64 0, i64 2), ptr null
; CHECK-NEXT:    ret ptr [[MEMRCHR_SEL]]
;

  %ret = call ptr @memrchr(ptr @a1110111, i32 %C, i64 3)
  ret ptr %ret
}


; Don't fold memrchr(a1110111, C, 4).

define ptr @call_memrchr_a1110111_c_4(i32 %C) {
; CHECK-LABEL: @call_memrchr_a1110111_c_4(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @memrchr(ptr noundef nonnull dereferenceable(4) @a1110111, i32 [[C:%.*]], i64 4)
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @memrchr(ptr @a1110111, i32 %C, i64 4)
  ret ptr %ret
}


; Don't fold memrchr(a1110111, C, 7).

define ptr @call_memrchr_a1110111_c_7(i32 %C) {
; CHECK-LABEL: @call_memrchr_a1110111_c_7(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @memrchr(ptr noundef nonnull dereferenceable(7) @a1110111, i32 [[C:%.*]], i64 7)
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @memrchr(ptr @a1110111, i32 %C, i64 7)
  ret ptr %ret
}


; Don't fold memrchr(a1110111, C, N).

define ptr @call_memrchr_a1110111_c_n(i32 %C, i64 %N) {
; CHECK-LABEL: @call_memrchr_a1110111_c_n(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @memrchr(ptr nonnull @a1110111, i32 [[C:%.*]], i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @memrchr(ptr @a1110111, i32 %C, i64 %N)
  ret ptr %ret
}
