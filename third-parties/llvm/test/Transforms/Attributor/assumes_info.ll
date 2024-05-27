; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

define dso_local void @entry(i1 %cond) #0 {
; TUNIT-LABEL: define {{[^@]+}}@entry
; TUNIT-SAME: (i1 [[COND:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    call void @foo(i1 [[COND]]) #[[ATTR1:[0-9]+]]
; TUNIT-NEXT:    call void @bar() #[[ATTR2:[0-9]+]]
; TUNIT-NEXT:    call void @qux() #[[ATTR1]]
; TUNIT-NEXT:    ret void
;
; CGSCC-LABEL: define {{[^@]+}}@entry
; CGSCC-SAME: (i1 noundef [[COND:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    call void @foo(i1 noundef [[COND]]) #[[ATTR1:[0-9]+]]
; CGSCC-NEXT:    call void @bar() #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    call void @qux() #[[ATTR1]]
; CGSCC-NEXT:    ret void
;
entry:
  call void @foo(i1 %cond)
  call void @bar()
  call void @qux() #1
  ret void
}

define internal void @foo(i1 %cond) #1 {
; TUNIT-LABEL: define {{[^@]+}}@foo
; TUNIT-SAME: (i1 [[COND:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    call void @baz(i1 [[COND]]) #[[ATTR1]]
; TUNIT-NEXT:    ret void
;
; CGSCC-LABEL: define {{[^@]+}}@foo
; CGSCC-SAME: (i1 noundef [[COND:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    call void @baz(i1 noundef [[COND]]) #[[ATTR1]]
; CGSCC-NEXT:    ret void
;
entry:
  call void @baz(i1 %cond)
  ret void
}

define internal void @bar() #2 {
; CHECK-LABEL: define {{[^@]+}}@bar
; CHECK-SAME: () #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @baz(i1 noundef false) #[[ATTR2]]
; CHECK-NEXT:    ret void
;
entry:
  call void @baz(i1 0)
  ret void
}

define internal void @baz(i1 %Cond) {
; TUNIT-LABEL: define {{[^@]+}}@baz
; TUNIT-SAME: (i1 [[COND:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    br i1 [[COND]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; TUNIT:       if.then:
; TUNIT-NEXT:    call void @baz(i1 noundef false) #[[ATTR1]]
; TUNIT-NEXT:    br label [[IF_END]]
; TUNIT:       if.end:
; TUNIT-NEXT:    call void @qux() #[[ATTR1]]
; TUNIT-NEXT:    ret void
;
; CGSCC-LABEL: define {{[^@]+}}@baz
; CGSCC-SAME: (i1 noundef [[COND:%.*]]) #[[ATTR3:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    br i1 [[COND]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CGSCC:       if.then:
; CGSCC-NEXT:    call void @baz(i1 noundef false) #[[ATTR3]]
; CGSCC-NEXT:    br label [[IF_END]]
; CGSCC:       if.end:
; CGSCC-NEXT:    call void @qux() #[[ATTR3]]
; CGSCC-NEXT:    ret void
;
entry:
  %tobool = icmp ne i1 %Cond, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:
  call void @baz(i1 0)
  br label %if.end

if.end:
  call void @qux()
  ret void
}

define internal void @qux() {
; TUNIT-LABEL: define {{[^@]+}}@qux
; TUNIT-SAME: () #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    call void @call() #[[ATTR2]]
; TUNIT-NEXT:    ret void
;
; CGSCC-LABEL: define {{[^@]+}}@qux() {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    call void @call() #[[ATTR2]]
; CGSCC-NEXT:    ret void
;
entry:
  call void @call()
  ret void
}

declare void @call() #3

attributes #0 = { "llvm.assume"="A" }
attributes #1 = { "llvm.assume"="B" }
attributes #2 = { "llvm.assume"="B,C" }
attributes #3 = { "llvm.assume"="B,C,A" }
;.
; TUNIT: attributes #[[ATTR0]] = { "llvm.assume"="A" }
; TUNIT: attributes #[[ATTR1]] = { "llvm.assume"="B,A" }
; TUNIT: attributes #[[ATTR2]] = { "llvm.assume"="B,C,A" }
;.
; CGSCC: attributes #[[ATTR0]] = { "llvm.assume"="A" }
; CGSCC: attributes #[[ATTR1]] = { "llvm.assume"="B,A" }
; CGSCC: attributes #[[ATTR2]] = { "llvm.assume"="B,C,A" }
; CGSCC: attributes #[[ATTR3]] = { "llvm.assume"="B" }
;.
