; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=licm -S | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa -passes='require<aa>,require<targetir>,require<scalar-evolution>,require<opt-remark-emit>,loop-mssa(licm)' -S %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Make sure we don't hoist the store out of the loop; %a would
; have the wrong value if f() unwinds
define void @test1(ptr nocapture noalias %a, i1 zeroext %y) uwtable {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i32, ptr [[A:%.*]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[I_03:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr [[A]], align 4
; CHECK-NEXT:    br i1 [[Y:%.*]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @f()
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_03]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %a, align 4
  br i1 %y, label %if.then, label %for.inc


if.then:
  tail call void @f()
  br label %for.inc

for.inc:
  %inc = add nuw nsw i32 %i.03, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; We can hoist the store out of the loop here; if f() unwinds,
; the lifetime of %a ends.
define void @test_alloca(i1 zeroext %y) uwtable {
; CHECK-LABEL: @test_alloca(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[I_03:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    br i1 [[Y:%.*]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @f()
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_03]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_INC]] ]
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], ptr [[A]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32
  br label %for.body

for.body:
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %a, align 4
  br i1 %y, label %if.then, label %for.inc

if.then:
  tail call void @f()
  br label %for.inc

for.inc:
  %inc = add nuw nsw i32 %i.03, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; byval memory cannot be accessed on unwind either.
define void @test_byval(ptr byval(i32) %a, i1 zeroext %y) uwtable {
; CHECK-LABEL: @test_byval(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i32, ptr [[A:%.*]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[I_03:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    br i1 [[Y:%.*]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @f()
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_03]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_INC]] ]
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], ptr [[A]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %a, align 4
  br i1 %y, label %if.then, label %for.inc

if.then:
  tail call void @f()
  br label %for.inc

for.inc:
  %inc = add nuw nsw i32 %i.03, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @test_dead_on_unwind(ptr noalias dead_on_unwind %a, i1 zeroext %y) uwtable {
; CHECK-LABEL: @test_dead_on_unwind(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i32, ptr [[A:%.*]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[I_03:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    br i1 [[Y:%.*]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @f()
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_03]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_INC]] ]
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], ptr [[A]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %a, align 4
  br i1 %y, label %if.then, label %for.inc

if.then:
  tail call void @f()
  br label %for.inc

for.inc:
  %inc = add nuw nsw i32 %i.03, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

;; We can promote if the load can be proven safe to speculate, and the
;; store safe to sink, even if the the store *isn't* must execute.
define void @test3(i1 zeroext %y) uwtable {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[I_03:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    tail call void @f()
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_03]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_BODY]] ]
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], ptr [[A]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32
  br label %for.body

for.body:
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 1
  tail call void @f()
  store i32 %add, ptr %a, align 4
  %inc = add nuw nsw i32 %i.03, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

;; Same as test3, but with unordered atomics
define void @test3b(i1 zeroext %y) uwtable {
; CHECK-LABEL: @test3b(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load atomic i32, ptr [[A]] unordered, align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[I_03:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    tail call void @f()
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_03]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_BODY]] ]
; CHECK-NEXT:    store atomic i32 [[ADD_LCSSA]], ptr [[A]] unordered, align 4
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32
  br label %for.body

for.body:
  %i.03 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %0 = load atomic i32, ptr %a unordered, align 4
  %add = add nsw i32 %0, 1
  tail call void @f()
  store atomic i32 %add, ptr %a unordered, align 4
  %inc = add nuw nsw i32 %i.03, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

@_ZTIi = external constant ptr

; In this test, the loop is within a try block. There is an explicit unwind edge out of the loop.
; Make sure this edge is treated as a loop exit, and that the loads and stores are promoted as
; expected
define void @loop_within_tryblock() personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @loop_within_tryblock(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 0, ptr [[A]], align 4
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I_0]], 1024
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    invoke void @boo()
; CHECK-NEXT:    to label [[INVOKE_CONT:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       invoke.cont:
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       lpad:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr @_ZTIi
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], ptr [[A]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { ptr, i32 } [[TMP0]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { ptr, i32 } [[TMP0]], 1
; CHECK-NEXT:    br label [[CATCH_DISPATCH:%.*]]
; CHECK:       catch.dispatch:
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.eh.typeid.for(ptr @_ZTIi)
; CHECK-NEXT:    [[MATCHES:%.*]] = icmp eq i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    br i1 [[MATCHES]], label [[CATCH:%.*]], label [[EH_RESUME:%.*]]
; CHECK:       catch:
; CHECK-NEXT:    [[TMP4:%.*]] = call ptr @__cxa_begin_catch(ptr [[TMP1]])
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[TMP4]], align 4
; CHECK-NEXT:    call void @__cxa_end_catch()
; CHECK-NEXT:    br label [[TRY_CONT:%.*]]
; CHECK:       try.cont:
; CHECK-NEXT:    ret void
; CHECK:       for.end:
; CHECK-NEXT:    [[ADD1_LCSSA:%.*]] = phi i32 [ [[ADD1]], [[FOR_COND]] ]
; CHECK-NEXT:    store i32 [[ADD1_LCSSA]], ptr [[A]], align 4
; CHECK-NEXT:    br label [[TRY_CONT]]
; CHECK:       eh.resume:
; CHECK-NEXT:    [[LPAD_VAL:%.*]] = insertvalue { ptr, i32 } undef, ptr [[TMP1]], 0
; CHECK-NEXT:    [[LPAD_VAL3:%.*]] = insertvalue { ptr, i32 } [[LPAD_VAL]], i32 [[TMP2]], 1
; CHECK-NEXT:    resume { ptr, i32 } [[LPAD_VAL3]]
;
entry:
  %a = alloca i32, align 4
  store i32 0, ptr %a, align 4
  br label %for.cond

for.cond:
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 1024
  br i1 %cmp, label %for.body, label %for.end

for.body:
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %a, align 4
  invoke void @boo()
  to label %invoke.cont unwind label %lpad

invoke.cont:
  br label %for.inc

for.inc:
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

lpad:
  %1 = landingpad { ptr, i32 }
  catch ptr @_ZTIi
  %2 = extractvalue { ptr, i32 } %1, 0
  %3 = extractvalue { ptr, i32 } %1, 1
  br label %catch.dispatch

catch.dispatch:
  %4 = call i32 @llvm.eh.typeid.for(ptr @_ZTIi) #3
  %matches = icmp eq i32 %3, %4
  br i1 %matches, label %catch, label %eh.resume

catch:
  %5 = call ptr @__cxa_begin_catch(ptr %2) #3
  %6 = load i32, ptr %5, align 4
  call void @__cxa_end_catch() #3
  br label %try.cont

try.cont:
  ret void

for.end:
  br label %try.cont

eh.resume:
  %lpad.val = insertvalue { ptr, i32 } undef, ptr %2, 0
  %lpad.val3 = insertvalue { ptr, i32 } %lpad.val, i32 %3, 1
  resume { ptr, i32 } %lpad.val3
}


; The malloc'ed memory is not capture and therefore promoted.
define void @malloc_no_capture() #0 personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @malloc_no_capture(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @malloc(i64 4)
; CHECK-NEXT:    [[CALL_PROMOTED:%.*]] = load i32, ptr [[CALL]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[CALL_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_LATCH:%.*]] ]
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_LATCH]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    br label [[FOR_CALL:%.*]]
; CHECK:       for.call:
; CHECK-NEXT:    invoke void @boo()
; CHECK-NEXT:    to label [[INVOKE_CONT:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       invoke.cont:
; CHECK-NEXT:    br label [[FOR_LATCH]]
; CHECK:       for.latch:
; CHECK-NEXT:    [[INC]] = add i32 [[I_0]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I_0]], 1024
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    [[ADD_LCSSA2:%.*]] = phi i32 [ [[ADD]], [[FOR_LATCH]] ]
; CHECK-NEXT:    store i32 [[ADD_LCSSA2]], ptr [[CALL]], align 4
; CHECK-NEXT:    br label [[FUN_RET:%.*]]
; CHECK:       lpad:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_CALL]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], ptr [[CALL]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { ptr, i32 } [[TMP0]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { ptr, i32 } [[TMP0]], 1
; CHECK-NEXT:    br label [[CATCH:%.*]]
; CHECK:       catch:
; CHECK-NEXT:    [[TMP3:%.*]] = call ptr @__cxa_begin_catch(ptr [[TMP1]])
; CHECK-NEXT:    call void @free(ptr [[CALL]])
; CHECK-NEXT:    call void @__cxa_end_catch()
; CHECK-NEXT:    br label [[FUN_RET]]
; CHECK:       fun.ret:
; CHECK-NEXT:    ret void
;
entry:
  %call = call ptr @malloc(i64 4)
  br label %for.body

for.body:
  %i.0 = phi i32 [ 0, %entry  ], [ %inc, %for.latch ]
  %0 = load i32, ptr %call, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %call, align 4
  br label %for.call

for.call:
  invoke void @boo()
  to label %invoke.cont unwind label %lpad

invoke.cont:
  br label %for.latch

for.latch:
  %inc = add i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, 1024
  br i1 %cmp, label %for.body, label %for.end

for.end:
  br label %fun.ret

lpad:
  %1 = landingpad { ptr, i32 }
  catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  %3 = extractvalue { ptr, i32 } %1, 1
  br label %catch

catch:
  %4 = call ptr @__cxa_begin_catch(ptr %2) #4
  call void @free(ptr %call)
  call void @__cxa_end_catch()
  br label %fun.ret

fun.ret:
  ret void
}

; The malloc'ed memory can be captured and therefore only loads can be promoted.
define void @malloc_capture(ptr noalias %A) personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @malloc_capture(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @malloc(i64 4)
; CHECK-NEXT:    [[CALL_PROMOTED:%.*]] = load i32, ptr [[CALL]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ADD1:%.*]] = phi i32 [ [[CALL_PROMOTED]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_LATCH:%.*]] ]
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_LATCH]] ]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[ADD1]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr [[CALL]], align 4
; CHECK-NEXT:    br label [[FOR_CALL:%.*]]
; CHECK:       for.call:
; CHECK-NEXT:    invoke void @boo_readnone()
; CHECK-NEXT:    to label [[INVOKE_CONT:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       invoke.cont:
; CHECK-NEXT:    br label [[FOR_LATCH]]
; CHECK:       for.latch:
; CHECK-NEXT:    store ptr [[CALL]], ptr [[A:%.*]], align 8
; CHECK-NEXT:    [[INC]] = add i32 [[I_0]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I_0]], 1024
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FUN_RET:%.*]]
; CHECK:       lpad:
; CHECK-NEXT:    [[TMP0:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { ptr, i32 } [[TMP0]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { ptr, i32 } [[TMP0]], 1
; CHECK-NEXT:    br label [[CATCH:%.*]]
; CHECK:       catch:
; CHECK-NEXT:    [[TMP3:%.*]] = call ptr @__cxa_begin_catch(ptr [[TMP1]])
; CHECK-NEXT:    call void @free(ptr [[CALL]])
; CHECK-NEXT:    call void @__cxa_end_catch()
; CHECK-NEXT:    br label [[FUN_RET]]
; CHECK:       fun.ret:
; CHECK-NEXT:    ret void
;
entry:
  %call = call ptr @malloc(i64 4)
  br label %for.body

for.body:
  %i.0 = phi i32 [ 0, %entry  ], [ %inc, %for.latch ]
  %0 = load i32, ptr %call, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %call, align 4
  br label %for.call

for.call:
  invoke void @boo_readnone()
  to label %invoke.cont unwind label %lpad

invoke.cont:
  br label %for.latch

for.latch:
  store ptr %call, ptr %A
  %inc = add i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, 1024
  br i1 %cmp, label %for.body, label %for.end

for.end:
  br label %fun.ret

lpad:
  %1 = landingpad { ptr, i32 }
  catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  %3 = extractvalue { ptr, i32 } %1, 1
  br label %catch

catch:
  %4 = call ptr @__cxa_begin_catch(ptr %2) #4
  call void @free(ptr %call)
  call void @__cxa_end_catch()
  br label %fun.ret

fun.ret:
  ret void
}

; Function Attrs: nounwind
declare noalias ptr @malloc(i64)

; Function Attrs: nounwind
declare void @free(ptr nocapture)

declare void @boo()

; This is an artifical example, readnone functions by definition cannot unwind
; exceptions by calling the C++ exception throwing methods
; This function should only be used to test malloc_capture.
declare void @boo_readnone() readnone

declare i32 @__gxx_personality_v0(...)

declare ptr @__cxa_begin_catch(ptr)

declare void @__cxa_end_catch()

declare i32 @llvm.eh.typeid.for(ptr)

declare void @f() uwtable
