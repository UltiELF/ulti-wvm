; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S < %s | FileCheck %s

define void @assume_false_to_unreachable1() {
; CHECK-LABEL: @assume_false_to_unreachable1(
; CHECK-NEXT:    unreachable
;
  call void @llvm.assume(i1 0)
  ret void

}

define void @assume_undef_to_unreachable() {
; CHECK-LABEL: @assume_undef_to_unreachable(
; CHECK-NEXT:    unreachable
;
  call void @llvm.assume(i1 undef)
  ret void

}

define i32 @speculate_block_with_assume_basic(i1 %c, i32 %x) {
; CHECK-LABEL: @speculate_block_with_assume_basic(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[C:%.*]], i32 1, i32 0
; CHECK-NEXT:    ret i32 [[SPEC_SELECT]]
;
entry:
  br i1 %c, label %if, label %join

if:
  %cmp = icmp ne i32 %x, 0
  call void @llvm.assume(i1 %cmp)
  br label %join

join:
  %phi = phi i32 [ 0, %entry ], [ 1, %if ]
  ret i32 %phi
}

define i32 @speculate_block_with_assume_extra_instr(i1 %c, i32 %x) {
; CHECK-LABEL: @speculate_block_with_assume_extra_instr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[X:%.*]], 1
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[C:%.*]], i32 [[ADD]], i32 0
; CHECK-NEXT:    ret i32 [[SPEC_SELECT]]
;
entry:
  br i1 %c, label %if, label %join

if:
  %add = add i32 %x, 1
  %cmp = icmp ne i32 %add, 0
  call void @llvm.assume(i1 %cmp)
  br label %join

join:
  %phi = phi i32 [ 0, %entry ], [ %add, %if ]
  ret i32 %phi
}

; We only allow speculating one instruction. Here %add and %add2 are used by
; the assume, but not ephemeral, because they are also used by %phi.
define i32 @speculate_block_with_assume_extra_instrs_too_many(i1 %c, i32 %x) {
; CHECK-LABEL: @speculate_block_with_assume_extra_instrs_too_many(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[JOIN:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[X:%.*]], 1
; CHECK-NEXT:    [[ADD2:%.*]] = add i32 [[ADD]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[ADD2]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[ADD2]], [[IF]] ]
; CHECK-NEXT:    ret i32 [[PHI]]
;
entry:
  br i1 %c, label %if, label %join

if:
  %add = add i32 %x, 1
  %add2 = add i32 %add, 1
  %cmp = icmp ne i32 %add2, 0
  call void @llvm.assume(i1 %cmp)
  br label %join

join:
  %phi = phi i32 [ 0, %entry ], [ %add2, %if ]
  ret i32 %phi
}

define i32 @speculate_block_with_assume_extra_instrs_okay(i1 %c, i32 %x) {
; CHECK-LABEL: @speculate_block_with_assume_extra_instrs_okay(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[X:%.*]], 1
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[C:%.*]], i32 [[ADD]], i32 0
; CHECK-NEXT:    ret i32 [[SPEC_SELECT]]
;
entry:
  br i1 %c, label %if, label %join

if:
  %add = add i32 %x, 1
  %add2 = add i32 %add, 1
  %cmp = icmp ne i32 %add2, 0
  call void @llvm.assume(i1 %cmp)
  br label %join

join:
  %phi = phi i32 [ 0, %entry ], [ %add, %if ]
  ret i32 %phi
}

define i32 @speculate_block_with_assume_operand_bundle(i1 %c, ptr %p) {
; CHECK-LABEL: @speculate_block_with_assume_operand_bundle(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[C:%.*]], i32 1, i32 0
; CHECK-NEXT:    ret i32 [[SPEC_SELECT]]
;
entry:
  br i1 %c, label %if, label %join

if:
  call void @llvm.assume(i1 true) ["nonnull"(ptr %p)]
  br label %join

join:
  %phi = phi i32 [ 0, %entry ], [ 1, %if ]
  ret i32 %phi
}

define void @empty_block_with_assume(i1 %c, i32 %x) {
; CHECK-LABEL: @empty_block_with_assume(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[ELSE:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    br label [[JOIN:%.*]]
; CHECK:       else:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %if, label %else

if:
  %cmp = icmp ne i32 %x, 0
  call void @llvm.assume(i1 %cmp)
  br label %join

else:
  call void @dummy()
  br label %join

join:
  ret void
}

define void @not_empty_block_with_assume(i1 %c) {
; CHECK-LABEL: @not_empty_block_with_assume(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[ELSE:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[X:%.*]] = call i32 @may_have_side_effect()
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[X]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    br label [[JOIN:%.*]]
; CHECK:       else:
; CHECK-NEXT:    call void @dummy()
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %if, label %else

if:
  %x = call i32 @may_have_side_effect()
  %cmp = icmp ne i32 %x, 0
  call void @llvm.assume(i1 %cmp)
  br label %join

else:
  call void @dummy()
  br label %join

join:
  ret void
}

declare void @dummy()
declare i32 @may_have_side_effect()
declare void @llvm.assume(i1) nounwind

