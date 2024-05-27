; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -o - -mtriple=x86_64-apple-darwin -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE2
; RUN: llc < %s -o - -mtriple=x86_64-apple-darwin -mattr=+sse4.2 | FileCheck %s --check-prefixes=CHECK,SSE41

; For a setult against a constant, turn it into a setule and lower via psubusw.

define void @loop_no_const_reload(ptr  %in, ptr %out, i32 %n) {
; SSE2-LABEL: loop_no_const_reload:
; SSE2:       ## %bb.0: ## %entry
; SSE2-NEXT:    testl %edx, %edx
; SSE2-NEXT:    je LBB0_3
; SSE2-NEXT:  ## %bb.1: ## %for.body.preheader
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    movdqa {{.*#+}} xmm0 = [25,25,25,25,25,25,25,25]
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  LBB0_2: ## %for.body
; SSE2-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    movdqa (%rdi,%rax), %xmm2
; SSE2-NEXT:    psubusw %xmm0, %xmm2
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm2, (%rsi,%rax)
; SSE2-NEXT:    addq $16, %rax
; SSE2-NEXT:    decl %edx
; SSE2-NEXT:    jne LBB0_2
; SSE2-NEXT:  LBB0_3: ## %for.end
; SSE2-NEXT:    retq
;
; SSE41-LABEL: loop_no_const_reload:
; SSE41:       ## %bb.0: ## %entry
; SSE41-NEXT:    testl %edx, %edx
; SSE41-NEXT:    je LBB0_3
; SSE41-NEXT:  ## %bb.1: ## %for.body.preheader
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    movdqa {{.*#+}} xmm0 = [25,25,25,25,25,25,25,25]
; SSE41-NEXT:    .p2align 4, 0x90
; SSE41-NEXT:  LBB0_2: ## %for.body
; SSE41-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE41-NEXT:    movdqa (%rdi,%rax), %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm2
; SSE41-NEXT:    pminuw %xmm0, %xmm2
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm2
; SSE41-NEXT:    movdqa %xmm2, (%rsi,%rax)
; SSE41-NEXT:    addq $16, %rax
; SSE41-NEXT:    decl %edx
; SSE41-NEXT:    jne LBB0_2
; SSE41-NEXT:  LBB0_3: ## %for.end
; SSE41-NEXT:    retq
entry:
  %cmp9 = icmp eq i32 %n, 0
  br i1 %cmp9, label %for.end, label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %arrayidx1 = getelementptr inbounds <2 x i64>, ptr %in, i64 %indvars.iv
  %arrayidx1.val = load <2 x i64>, ptr %arrayidx1, align 16
  %0 = bitcast <2 x i64> %arrayidx1.val to <8 x i16>
  %cmp.i.i = icmp ult <8 x i16> %0, <i16 26, i16 26, i16 26, i16 26, i16 26, i16 26, i16 26, i16 26>
  %sext.i.i = sext <8 x i1> %cmp.i.i to <8 x i16>
  %1 = bitcast <8 x i16> %sext.i.i to <2 x i64>
  %arrayidx5 = getelementptr inbounds <2 x i64>, ptr %out, i64 %indvars.iv
  store <2 x i64> %1, ptr %arrayidx5, align 16
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

; Be careful if decrementing the constant would undeflow.

define void @loop_const_folding_underflow(ptr  %in, ptr %out, i32 %n) {
; SSE2-LABEL: loop_const_folding_underflow:
; SSE2:       ## %bb.0: ## %entry
; SSE2-NEXT:    testl %edx, %edx
; SSE2-NEXT:    je LBB1_3
; SSE2-NEXT:  ## %bb.1: ## %for.body.preheader
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    movdqa {{.*#+}} xmm0 = [32768,32768,32768,32768,32768,32768,32768,32768]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [32768,32794,32794,32794,32794,32794,32794,32794]
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  LBB1_2: ## %for.body
; SSE2-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    movdqa (%rdi,%rax), %xmm2
; SSE2-NEXT:    pxor %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm1, %xmm3
; SSE2-NEXT:    pcmpgtw %xmm2, %xmm3
; SSE2-NEXT:    movdqa %xmm3, (%rsi,%rax)
; SSE2-NEXT:    addq $16, %rax
; SSE2-NEXT:    decl %edx
; SSE2-NEXT:    jne LBB1_2
; SSE2-NEXT:  LBB1_3: ## %for.end
; SSE2-NEXT:    retq
;
; SSE41-LABEL: loop_const_folding_underflow:
; SSE41:       ## %bb.0: ## %entry
; SSE41-NEXT:    testl %edx, %edx
; SSE41-NEXT:    je LBB1_3
; SSE41-NEXT:  ## %bb.1: ## %for.body.preheader
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    movdqa {{.*#+}} xmm0 = [0,26,26,26,26,26,26,26]
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE41-NEXT:    .p2align 4, 0x90
; SSE41-NEXT:  LBB1_2: ## %for.body
; SSE41-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE41-NEXT:    movdqa (%rdi,%rax), %xmm2
; SSE41-NEXT:    movdqa %xmm2, %xmm3
; SSE41-NEXT:    pmaxuw %xmm0, %xmm3
; SSE41-NEXT:    pcmpeqw %xmm2, %xmm3
; SSE41-NEXT:    pxor %xmm1, %xmm3
; SSE41-NEXT:    movdqa %xmm3, (%rsi,%rax)
; SSE41-NEXT:    addq $16, %rax
; SSE41-NEXT:    decl %edx
; SSE41-NEXT:    jne LBB1_2
; SSE41-NEXT:  LBB1_3: ## %for.end
; SSE41-NEXT:    retq
entry:
  %cmp9 = icmp eq i32 %n, 0
  br i1 %cmp9, label %for.end, label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %arrayidx1 = getelementptr inbounds <2 x i64>, ptr %in, i64 %indvars.iv
  %arrayidx1.val = load <2 x i64>, ptr %arrayidx1, align 16
  %0 = bitcast <2 x i64> %arrayidx1.val to <8 x i16>
  %cmp.i.i = icmp ult <8 x i16> %0, <i16 0, i16 26, i16 26, i16 26, i16 26, i16 26, i16 26, i16 26>
  %sext.i.i = sext <8 x i1> %cmp.i.i to <8 x i16>
  %1 = bitcast <8 x i16> %sext.i.i to <2 x i64>
  %arrayidx5 = getelementptr inbounds <2 x i64>, ptr %out, i64 %indvars.iv
  store <2 x i64> %1, ptr %arrayidx5, align 16
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

; Test for PSUBUSB

define <16 x i8> @test_ult_byte(<16 x i8> %a) {
; CHECK-LABEL: test_ult_byte:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
; CHECK-NEXT:    pminub %xmm0, %xmm1
; CHECK-NEXT:    pcmpeqb %xmm1, %xmm0
; CHECK-NEXT:    retq
entry:
  %icmp = icmp ult <16 x i8> %a, <i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11, i8 11>
  %sext = sext <16 x i1> %icmp to <16 x i8>
  ret <16 x i8> %sext
}

; Only do this when we can turn the comparison into a setule.  I.e. not for
; register operands.

define <8 x i16> @test_ult_register(<8 x i16> %a, <8 x i16> %b) {
; SSE2-LABEL: test_ult_register:
; SSE2:       ## %bb.0: ## %entry
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [32768,32768,32768,32768,32768,32768,32768,32768]
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    pcmpgtw %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_ult_register:
; SSE41:       ## %bb.0: ## %entry
; SSE41-NEXT:    pmaxuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE41-NEXT:    pxor %xmm1, %xmm0
; SSE41-NEXT:    retq
entry:
  %icmp = icmp ult <8 x i16> %a, %b
  %sext = sext <8 x i1> %icmp to <8 x i16>
  ret <8 x i16> %sext
}

define <16 x i1> @ugt_v16i8_splat(<16 x i8> %x) {
; CHECK-LABEL: ugt_v16i8_splat:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43]
; CHECK-NEXT:    pmaxub %xmm0, %xmm1
; CHECK-NEXT:    pcmpeqb %xmm1, %xmm0
; CHECK-NEXT:    retq
  %cmp = icmp ugt <16 x i8> %x, <i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42>
  ret <16 x i1> %cmp
}

define <8 x i1> @ugt_v8i16_splat(<8 x i16> %x) {
; SSE2-LABEL: ugt_v8i16_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [243,243,243,243,243,243,243,243]
; SSE2-NEXT:    psubusw %xmm0, %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ugt_v8i16_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [243,243,243,243,243,243,243,243]
; SSE41-NEXT:    pmaxuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ugt <8 x i16> %x, <i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242>
  ret <8 x i1> %cmp
}

define <4 x i1> @ugt_v4i32_splat(<4 x i32> %x) {
; SSE2-LABEL: ugt_v4i32_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ugt_v4i32_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [4294967255,4294967255,4294967255,4294967255]
; SSE41-NEXT:    pmaxud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ugt <4 x i32> %x, <i32 -42, i32 -42, i32 -42, i32 -42>
  ret <4 x i1> %cmp
}

define <2 x i1> @ugt_v2i64_splat(<2 x i64> %x) {
; SSE2-LABEL: ugt_v2i64_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[0,0,2,2]
; SSE2-NEXT:    pcmpeqd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pand %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ugt_v2i64_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    pcmpgtq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ugt <2 x i64> %x, <i64 442, i64 442>
  ret <2 x i1> %cmp
}

define <16 x i1> @uge_v16i8_splat(<16 x i8> %x) {
; CHECK-LABEL: uge_v16i8_splat:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42]
; CHECK-NEXT:    pmaxub %xmm0, %xmm1
; CHECK-NEXT:    pcmpeqb %xmm1, %xmm0
; CHECK-NEXT:    retq
  %cmp = icmp uge <16 x i8> %x, <i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42>
  ret <16 x i1> %cmp
}

define <8 x i1> @uge_v8i16_splat(<8 x i16> %x) {
; SSE2-LABEL: uge_v8i16_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [242,242,242,242,242,242,242,242]
; SSE2-NEXT:    psubusw %xmm0, %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: uge_v8i16_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [242,242,242,242,242,242,242,242]
; SSE41-NEXT:    pmaxuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp uge <8 x i16> %x, <i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242>
  ret <8 x i1> %cmp
}

define <4 x i1> @uge_v4i32_splat(<4 x i32> %x) {
; SSE2-LABEL: uge_v4i32_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [2147483606,2147483606,2147483606,2147483606]
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: uge_v4i32_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [4294967254,4294967254,4294967254,4294967254]
; SSE41-NEXT:    pmaxud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp uge <4 x i32> %x, <i32 -42, i32 -42, i32 -42, i32 -42>
  ret <4 x i1> %cmp
}

define <2 x i1> @uge_v2i64_splat(<2 x i64> %x) {
; SSE2-LABEL: uge_v2i64_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE2-NEXT:    pcmpeqd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[0,0,2,2]
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2
; SSE2-NEXT:    pandn %xmm1, %xmm2
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: uge_v2i64_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [9223372036854776250,9223372036854776250]
; SSE41-NEXT:    pcmpgtq %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE41-NEXT:    pxor %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp uge <2 x i64> %x, <i64 442, i64 442>
  ret <2 x i1> %cmp
}

define <16 x i1> @ult_v16i8_splat(<16 x i8> %x) {
; CHECK-LABEL: ult_v16i8_splat:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41]
; CHECK-NEXT:    pminub %xmm0, %xmm1
; CHECK-NEXT:    pcmpeqb %xmm1, %xmm0
; CHECK-NEXT:    retq
  %cmp = icmp ult <16 x i8> %x, <i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42>
  ret <16 x i1> %cmp
}

define <8 x i1> @ult_v8i16_splat(<8 x i16> %x) {
; SSE2-LABEL: ult_v8i16_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    psubusw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ult_v8i16_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [241,241,241,241,241,241,241,241]
; SSE41-NEXT:    pminuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ult <8 x i16> %x, <i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242>
  ret <8 x i1> %cmp
}

define <4 x i1> @ult_v4i32_splat(<4 x i32> %x) {
; SSE2-LABEL: ult_v4i32_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [2147483606,2147483606,2147483606,2147483606]
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ult_v4i32_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [4294967253,4294967253,4294967253,4294967253]
; SSE41-NEXT:    pminud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ult <4 x i32> %x, <i32 -42, i32 -42, i32 -42, i32 -42>
  ret <4 x i1> %cmp
}

define <2 x i1> @ult_v2i64_splat(<2 x i64> %x) {
; SSE2-LABEL: ult_v2i64_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE2-NEXT:    pcmpeqd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,2,2]
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pandn %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ult_v2i64_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [9223372036854776250,9223372036854776250]
; SSE41-NEXT:    pcmpgtq %xmm0, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ult <2 x i64> %x, <i64 442, i64 442>
  ret <2 x i1> %cmp
}

define <16 x i1> @ule_v16i8_splat(<16 x i8> %x) {
; CHECK-LABEL: ule_v16i8_splat:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42]
; CHECK-NEXT:    pminub %xmm0, %xmm1
; CHECK-NEXT:    pcmpeqb %xmm1, %xmm0
; CHECK-NEXT:    retq
  %cmp = icmp ule <16 x i8> %x, <i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42>
  ret <16 x i1> %cmp
}

define <8 x i1> @ule_v8i16_splat(<8 x i16> %x) {
; SSE2-LABEL: ule_v8i16_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    psubusw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ule_v8i16_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [242,242,242,242,242,242,242,242]
; SSE41-NEXT:    pminuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ule <8 x i16> %x, <i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242, i16 242>
  ret <8 x i1> %cmp
}

define <4 x i1> @ule_v4i32_splat(<4 x i32> %x) {
; SSE2-LABEL: ule_v4i32_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ule_v4i32_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [4294967254,4294967254,4294967254,4294967254]
; SSE41-NEXT:    pminud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ule <4 x i32> %x, <i32 -42, i32 -42, i32 -42, i32 -42>
  ret <4 x i1> %cmp
}

define <2 x i1> @ule_v2i64_splat(<2 x i64> %x) {
; SSE2-LABEL: ule_v2i64_splat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[0,0,2,2]
; SSE2-NEXT:    pcmpeqd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pand %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    por %xmm1, %xmm2
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ule_v2i64_splat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    pcmpgtq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE41-NEXT:    pxor %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ule <2 x i64> %x, <i64 442, i64 442>
  ret <2 x i1> %cmp
}

; This should be simplified before we reach lowering, but
; make sure that we are not getting it wrong by underflowing.

define <4 x i1> @ult_v4i32_splat_0_simplify(<4 x i32> %x) {
; CHECK-LABEL: ult_v4i32_splat_0_simplify:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    retq
  %cmp = icmp ult <4 x i32> %x, <i32 0, i32 0, i32 0, i32 0>
  ret <4 x i1> %cmp
}

; This should be simplified before we reach lowering, but
; make sure that we are not getting it wrong by overflowing.

define <4 x i1> @ugt_v4i32_splat_maxval_simplify(<4 x i32> %x) {
; CHECK-LABEL: ugt_v4i32_splat_maxval_simplify:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    retq
  %cmp = icmp ugt <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i1> %cmp
}

define <4 x i1> @ugt_v4i32_nonsplat(<4 x i32> %x) {
; SSE2-LABEL: ugt_v4i32_nonsplat:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ugt_v4i32_nonsplat:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [4294967254,4294967255,4294967256,4294967257]
; SSE41-NEXT:    pmaxud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ugt <4 x i32> %x, <i32 -43, i32 -42, i32 -41, i32 -40>
  ret <4 x i1> %cmp
}

define <4 x i1> @ugt_v4i32_splat_commute(<4 x i32> %x) {
; SSE2-LABEL: ugt_v4i32_splat_commute:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [2147483652,2147483652,2147483652,2147483652]
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ugt_v4i32_splat_commute:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [3,3,3,3]
; SSE41-NEXT:    pminud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ugt <4 x i32> <i32 4, i32 4, i32 4, i32 4>, %x
  ret <4 x i1> %cmp
}

define <8 x i16> @PR39859(<8 x i16> %x, <8 x i16> %y) {
; SSE2-LABEL: PR39859:
; SSE2:       ## %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm3 = [43,43,43,43,43,43,43,43]
; SSE2-NEXT:    psubusw %xmm0, %xmm3
; SSE2-NEXT:    pxor %xmm2, %xmm2
; SSE2-NEXT:    pcmpeqw %xmm3, %xmm2
; SSE2-NEXT:    pand %xmm2, %xmm1
; SSE2-NEXT:    pandn %xmm0, %xmm2
; SSE2-NEXT:    por %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: PR39859:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    movdqa {{.*#+}} xmm0 = [43,43,43,43,43,43,43,43]
; SSE41-NEXT:    pmaxuw %xmm2, %xmm0
; SSE41-NEXT:    pcmpeqw %xmm2, %xmm0
; SSE41-NEXT:    pblendvb %xmm0, %xmm1, %xmm2
; SSE41-NEXT:    movdqa %xmm2, %xmm0
; SSE41-NEXT:    retq
  %cmp = icmp ugt <8 x i16> %x, <i16 42, i16 42, i16 42, i16 42, i16 42, i16 42, i16 42, i16 42>
  %sel = select <8 x i1> %cmp, <8 x i16> %y, <8 x i16> %x
  ret <8 x i16> %sel
}

