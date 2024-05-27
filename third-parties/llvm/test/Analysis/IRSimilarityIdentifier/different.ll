; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -disable-output -S -passes=print-ir-similarity < %s 2>&1 | FileCheck --allow-empty %s

; Check to make sure that the IRSimilarityIdentifier and IRSimilarityPrinterPass
; return items only within the same function when there are different sets of
; instructions in functions.

; CHECK: 2 candidates of length 5.  Found in:
; CHECK-NEXT:   Function: fish, Basic Block: entry
; CHECK-NEXT:     Start Instruction:   store i32 6, ptr %0, align 4
; CHECK-NEXT:       End Instruction:   store i32 4, ptr %4, align 4
; CHECK-NEXT:   Function: fish, Basic Block: entry
; CHECK-NEXT:     Start Instruction:   store i32 1, ptr %1, align 4
; CHECK-NEXT:       End Instruction:   store i32 5, ptr %5, align 4
; CHECK-NEXT: 2 candidates of length 3.  Found in:
; CHECK-NEXT:   Function: turtle, Basic Block: (unnamed)
; CHECK-NEXT:     Start Instruction:   %b = load i32, ptr %1, align 4
; CHECK-NEXT:       End Instruction:   %d = load i32, ptr %3, align 4
; CHECK-NEXT:   Function: turtle, Basic Block: (unnamed)
; CHECK-NEXT:     Start Instruction:   %a = load i32, ptr %0, align 4
; CHECK-NEXT:       End Instruction:   %c = load i32, ptr %2, align 4

define linkonce_odr void @fish() {
entry:
  %0 = alloca i32, align 4
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 6, ptr %0, align 4
  store i32 1, ptr %1, align 4
  store i32 2, ptr %2, align 4
  store i32 3, ptr %3, align 4
  store i32 4, ptr %4, align 4
  store i32 5, ptr %5, align 4
  ret void
}

define void @turtle(ptr %0, ptr %1, ptr %2, ptr %3) {
  %a = load i32, ptr %0
  %b = load i32, ptr %1
  %c = load i32, ptr %2
  %d = load i32, ptr %3
  ret void
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
