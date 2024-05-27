; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=PPC
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=PPC64LE

define i1 @test_srem_odd(i29 %X) nounwind {
; PPC-LABEL: test_srem_odd:
; PPC:       # %bb.0:
; PPC-NEXT:    lis 4, 8026
; PPC-NEXT:    ori 4, 4, 33099
; PPC-NEXT:    mullw 3, 3, 4
; PPC-NEXT:    addi 3, 3, 24493
; PPC-NEXT:    lis 4, 82
; PPC-NEXT:    addis 3, 3, 41
; PPC-NEXT:    ori 4, 4, 48987
; PPC-NEXT:    clrlwi 3, 3, 3
; PPC-NEXT:    cmplw 3, 4
; PPC-NEXT:    li 3, 0
; PPC-NEXT:    li 4, 1
; PPC-NEXT:    bc 12, 0, .LBB0_1
; PPC-NEXT:    blr
; PPC-NEXT:  .LBB0_1:
; PPC-NEXT:    addi 3, 4, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_srem_odd:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    lis 4, 8026
; PPC64LE-NEXT:    ori 4, 4, 33099
; PPC64LE-NEXT:    mullw 3, 3, 4
; PPC64LE-NEXT:    lis 4, 82
; PPC64LE-NEXT:    ori 4, 4, 48987
; PPC64LE-NEXT:    addi 3, 3, 24493
; PPC64LE-NEXT:    addis 3, 3, 41
; PPC64LE-NEXT:    clrlwi 3, 3, 3
; PPC64LE-NEXT:    cmplw 3, 4
; PPC64LE-NEXT:    li 3, 0
; PPC64LE-NEXT:    li 4, 1
; PPC64LE-NEXT:    isellt 3, 4, 3
; PPC64LE-NEXT:    blr
  %srem = srem i29 %X, 99
  %cmp = icmp eq i29 %srem, 0
  ret i1 %cmp
}

define i1 @test_srem_even(i4 %X) nounwind {
; PPC-LABEL: test_srem_even:
; PPC:       # %bb.0:
; PPC-NEXT:    slwi 5, 3, 28
; PPC-NEXT:    srawi 5, 5, 28
; PPC-NEXT:    mulli 5, 5, 3
; PPC-NEXT:    rlwinm 6, 5, 25, 31, 31
; PPC-NEXT:    srwi 5, 5, 4
; PPC-NEXT:    add 5, 5, 6
; PPC-NEXT:    mulli 5, 5, 6
; PPC-NEXT:    sub 3, 3, 5
; PPC-NEXT:    clrlwi 3, 3, 28
; PPC-NEXT:    li 4, 0
; PPC-NEXT:    cmpwi 3, 1
; PPC-NEXT:    li 3, 1
; PPC-NEXT:    bclr 12, 2, 0
; PPC-NEXT:  # %bb.1:
; PPC-NEXT:    ori 3, 4, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_srem_even:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    slwi 4, 3, 28
; PPC64LE-NEXT:    srawi 4, 4, 28
; PPC64LE-NEXT:    slwi 5, 4, 1
; PPC64LE-NEXT:    add 4, 4, 5
; PPC64LE-NEXT:    rlwinm 5, 4, 25, 31, 31
; PPC64LE-NEXT:    srwi 4, 4, 4
; PPC64LE-NEXT:    add 4, 4, 5
; PPC64LE-NEXT:    mulli 4, 4, 6
; PPC64LE-NEXT:    sub 3, 3, 4
; PPC64LE-NEXT:    li 4, 1
; PPC64LE-NEXT:    clrlwi 3, 3, 28
; PPC64LE-NEXT:    cmpwi 3, 1
; PPC64LE-NEXT:    li 3, 0
; PPC64LE-NEXT:    iseleq 3, 4, 3
; PPC64LE-NEXT:    blr
  %srem = srem i4 %X, 6
  %cmp = icmp eq i4 %srem, 1
  ret i1 %cmp
}

define i1 @test_srem_pow2_setne(i6 %X) nounwind {
; PPC-LABEL: test_srem_pow2_setne:
; PPC:       # %bb.0:
; PPC-NEXT:    slwi 4, 3, 26
; PPC-NEXT:    srawi 4, 4, 26
; PPC-NEXT:    rlwinm 4, 4, 23, 30, 31
; PPC-NEXT:    add 4, 3, 4
; PPC-NEXT:    rlwinm 4, 4, 0, 26, 29
; PPC-NEXT:    sub 3, 3, 4
; PPC-NEXT:    clrlwi 3, 3, 26
; PPC-NEXT:    cntlzw 3, 3
; PPC-NEXT:    not 3, 3
; PPC-NEXT:    rlwinm 3, 3, 27, 31, 31
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_srem_pow2_setne:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    slwi 4, 3, 26
; PPC64LE-NEXT:    srawi 4, 4, 26
; PPC64LE-NEXT:    rlwinm 4, 4, 23, 30, 31
; PPC64LE-NEXT:    add 4, 3, 4
; PPC64LE-NEXT:    rlwinm 4, 4, 0, 26, 29
; PPC64LE-NEXT:    sub 3, 3, 4
; PPC64LE-NEXT:    clrlwi 3, 3, 26
; PPC64LE-NEXT:    cntlzw 3, 3
; PPC64LE-NEXT:    not 3, 3
; PPC64LE-NEXT:    rlwinm 3, 3, 27, 31, 31
; PPC64LE-NEXT:    blr
  %srem = srem i6 %X, 4
  %cmp = icmp ne i6 %srem, 0
  ret i1 %cmp
}

define <3 x i1> @test_srem_vec(<3 x i33> %X) nounwind {
; PPC-LABEL: test_srem_vec:
; PPC:       # %bb.0:
; PPC-NEXT:    mflr 0
; PPC-NEXT:    stwu 1, -48(1)
; PPC-NEXT:    stw 0, 52(1)
; PPC-NEXT:    clrlwi 5, 5, 31
; PPC-NEXT:    stw 29, 36(1) # 4-byte Folded Spill
; PPC-NEXT:    mr 29, 6
; PPC-NEXT:    clrlwi 6, 7, 31
; PPC-NEXT:    clrlwi 3, 3, 31
; PPC-NEXT:    stw 27, 28(1) # 4-byte Folded Spill
; PPC-NEXT:    neg 27, 6
; PPC-NEXT:    stw 28, 32(1) # 4-byte Folded Spill
; PPC-NEXT:    neg 28, 5
; PPC-NEXT:    neg 3, 3
; PPC-NEXT:    li 5, 0
; PPC-NEXT:    li 6, 9
; PPC-NEXT:    stw 25, 20(1) # 4-byte Folded Spill
; PPC-NEXT:    stw 26, 24(1) # 4-byte Folded Spill
; PPC-NEXT:    stw 30, 40(1) # 4-byte Folded Spill
; PPC-NEXT:    mr 30, 8
; PPC-NEXT:    bl __moddi3
; PPC-NEXT:    mr 26, 3
; PPC-NEXT:    mr 25, 4
; PPC-NEXT:    mr 3, 27
; PPC-NEXT:    mr 4, 30
; PPC-NEXT:    li 5, -1
; PPC-NEXT:    li 6, -9
; PPC-NEXT:    bl __moddi3
; PPC-NEXT:    mr 30, 3
; PPC-NEXT:    mr 27, 4
; PPC-NEXT:    mr 3, 28
; PPC-NEXT:    mr 4, 29
; PPC-NEXT:    li 5, 0
; PPC-NEXT:    li 6, 9
; PPC-NEXT:    bl __moddi3
; PPC-NEXT:    not 3, 3
; PPC-NEXT:    xori 4, 4, 65533
; PPC-NEXT:    xori 5, 27, 3
; PPC-NEXT:    xori 6, 25, 3
; PPC-NEXT:    clrlwi 3, 3, 31
; PPC-NEXT:    xoris 4, 4, 65535
; PPC-NEXT:    or 5, 5, 30
; PPC-NEXT:    or 6, 6, 26
; PPC-NEXT:    or 4, 4, 3
; PPC-NEXT:    cntlzw 6, 6
; PPC-NEXT:    cntlzw 5, 5
; PPC-NEXT:    cntlzw 4, 4
; PPC-NEXT:    not 3, 6
; PPC-NEXT:    not 5, 5
; PPC-NEXT:    not 4, 4
; PPC-NEXT:    rlwinm 3, 3, 27, 31, 31
; PPC-NEXT:    rlwinm 5, 5, 27, 31, 31
; PPC-NEXT:    rlwinm 4, 4, 27, 31, 31
; PPC-NEXT:    lwz 30, 40(1) # 4-byte Folded Reload
; PPC-NEXT:    lwz 29, 36(1) # 4-byte Folded Reload
; PPC-NEXT:    lwz 28, 32(1) # 4-byte Folded Reload
; PPC-NEXT:    lwz 27, 28(1) # 4-byte Folded Reload
; PPC-NEXT:    lwz 26, 24(1) # 4-byte Folded Reload
; PPC-NEXT:    lwz 25, 20(1) # 4-byte Folded Reload
; PPC-NEXT:    lwz 0, 52(1)
; PPC-NEXT:    addi 1, 1, 48
; PPC-NEXT:    mtlr 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_srem_vec:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    lis 6, 1820
; PPC64LE-NEXT:    sldi 3, 3, 31
; PPC64LE-NEXT:    sldi 4, 4, 31
; PPC64LE-NEXT:    sldi 5, 5, 31
; PPC64LE-NEXT:    ori 6, 6, 29127
; PPC64LE-NEXT:    sradi 3, 3, 31
; PPC64LE-NEXT:    sradi 4, 4, 31
; PPC64LE-NEXT:    sradi 5, 5, 31
; PPC64LE-NEXT:    rldic 6, 6, 34, 3
; PPC64LE-NEXT:    oris 6, 6, 29127
; PPC64LE-NEXT:    ori 7, 6, 7282
; PPC64LE-NEXT:    mulhd 8, 3, 7
; PPC64LE-NEXT:    rldicl 9, 8, 1, 63
; PPC64LE-NEXT:    add 8, 8, 9
; PPC64LE-NEXT:    sldi 9, 8, 3
; PPC64LE-NEXT:    add 8, 8, 9
; PPC64LE-NEXT:    sub 3, 3, 8
; PPC64LE-NEXT:    mtfprd 0, 3
; PPC64LE-NEXT:    mulhd 3, 4, 7
; PPC64LE-NEXT:    rldicl 7, 3, 1, 63
; PPC64LE-NEXT:    add 3, 3, 7
; PPC64LE-NEXT:    sldi 7, 3, 3
; PPC64LE-NEXT:    add 3, 3, 7
; PPC64LE-NEXT:    sub 3, 4, 3
; PPC64LE-NEXT:    mtfprd 1, 3
; PPC64LE-NEXT:    ori 3, 6, 7281
; PPC64LE-NEXT:    mulhd 3, 5, 3
; PPC64LE-NEXT:    sub 3, 3, 5
; PPC64LE-NEXT:    rldicl 4, 3, 1, 63
; PPC64LE-NEXT:    sradi 3, 3, 3
; PPC64LE-NEXT:    add 3, 3, 4
; PPC64LE-NEXT:    sldi 4, 3, 3
; PPC64LE-NEXT:    add 3, 3, 4
; PPC64LE-NEXT:    add 3, 5, 3
; PPC64LE-NEXT:    xxmrghd 34, 1, 0
; PPC64LE-NEXT:    mtfprd 0, 3
; PPC64LE-NEXT:    addis 3, 2, .LCPI3_1@toc@ha
; PPC64LE-NEXT:    addi 3, 3, .LCPI3_1@toc@l
; PPC64LE-NEXT:    xxswapd 35, 0
; PPC64LE-NEXT:    lxvd2x 0, 0, 3
; PPC64LE-NEXT:    addis 3, 2, .LCPI3_2@toc@ha
; PPC64LE-NEXT:    addi 3, 3, .LCPI3_2@toc@l
; PPC64LE-NEXT:    xxswapd 36, 0
; PPC64LE-NEXT:    lxvd2x 0, 0, 3
; PPC64LE-NEXT:    addis 3, 2, .LCPI3_0@toc@ha
; PPC64LE-NEXT:    addi 3, 3, .LCPI3_0@toc@l
; PPC64LE-NEXT:    xxswapd 37, 0
; PPC64LE-NEXT:    lxvd2x 0, 0, 3
; PPC64LE-NEXT:    xxland 34, 34, 0
; PPC64LE-NEXT:    xxland 35, 35, 0
; PPC64LE-NEXT:    vcmpequd 2, 2, 4
; PPC64LE-NEXT:    xxlnor 0, 34, 34
; PPC64LE-NEXT:    vcmpequd 2, 3, 5
; PPC64LE-NEXT:    xxlnor 34, 34, 34
; PPC64LE-NEXT:    mffprwz 4, 0
; PPC64LE-NEXT:    xxswapd 1, 0
; PPC64LE-NEXT:    mffprwz 3, 1
; PPC64LE-NEXT:    xxswapd 2, 34
; PPC64LE-NEXT:    mffprwz 5, 2
; PPC64LE-NEXT:    blr
  %srem = srem <3 x i33> %X, <i33 9, i33 9, i33 -9>
  %cmp = icmp ne <3 x i33> %srem, <i33 3, i33 -3, i33 3>
  ret <3 x i1> %cmp
}
