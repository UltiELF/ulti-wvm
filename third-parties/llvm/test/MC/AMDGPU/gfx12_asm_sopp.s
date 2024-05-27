// RUN: llvm-mc -arch=amdgcn -show-encoding -mcpu=gfx1200 %s | FileCheck --check-prefix=GFX12 %s

s_wait_loadcnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc0,0xbf]

s_wait_loadcnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc0,0xbf]

s_wait_storecnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc1,0xbf]

s_wait_storecnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc1,0xbf]

s_wait_samplecnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc2,0xbf]

s_wait_samplecnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc2,0xbf]

s_wait_bvhcnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc3,0xbf]

s_wait_bvhcnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc3,0xbf]

s_wait_expcnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc4,0xbf]

s_wait_expcnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc4,0xbf]

s_wait_dscnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc6,0xbf]

s_wait_dscnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc6,0xbf]

s_wait_kmcnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc7,0xbf]

s_wait_kmcnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc7,0xbf]

s_wait_loadcnt_dscnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc8,0xbf]

s_wait_loadcnt_dscnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc8,0xbf]

s_wait_storecnt_dscnt 0x1234
// GFX12: encoding: [0x34,0x12,0xc9,0xbf]

s_wait_storecnt_dscnt 0xc1d1
// GFX12: encoding: [0xd1,0xc1,0xc9,0xbf]

s_wait_alu 0xfffe
// GFX12: encoding: [0xfe,0xff,0x88,0xbf]

s_wait_alu 0
// GFX12: encoding: [0x00,0x00,0x88,0xbf]

s_wait_alu depctr_va_sdst(0)
// GFX12: encoding: [0x9f,0xf1,0x88,0xbf]

s_wait_alu depctr_va_sdst(3)
// GFX12: encoding: [0x9f,0xf7,0x88,0xbf]

s_wait_alu depctr_va_vdst(14) depctr_va_sdst(6) depctr_vm_vsrc(6)
// GFX12: encoding: [0x9b,0xed,0x88,0xbf]

s_singleuse_vdst 0x0000
// GFX12: encoding: [0x00,0x00,0x93,0xbf]

s_singleuse_vdst 0xffff
// GFX12: encoding: [0xff,0xff,0x93,0xbf]

s_singleuse_vdst 0x1234
// GFX12: encoding: [0x34,0x12,0x93,0xbf]

s_barrier_wait 0xffff
// GFX12: encoding: [0xff,0xff,0x94,0xbf]

s_barrier_wait 1
// GFX12: encoding: [0x01,0x00,0x94,0xbf]

s_barrier_leave
// GFX12: encoding: [0x00,0x00,0x95,0xbf]

//===----------------------------------------------------------------------===//
// s_waitcnt
//===----------------------------------------------------------------------===//

s_waitcnt 0
// GFX12: s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0) ; encoding: [0x00,0x00,0x89,0xbf]

s_waitcnt 0x1234
// GFX12: s_waitcnt vmcnt(4) expcnt(4) lgkmcnt(35) ; encoding: [0x34,0x12,0x89,0xbf]

s_waitcnt vmcnt(0) & expcnt(0) & lgkmcnt(0)
// GFX12: s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0) ; encoding: [0x00,0x00,0x89,0xbf]

s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
// GFX12: s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0) ; encoding: [0x00,0x00,0x89,0xbf]

s_waitcnt vmcnt(0), expcnt(0), lgkmcnt(0)
// GFX12: s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0) ; encoding: [0x00,0x00,0x89,0xbf]

s_waitcnt vmcnt(1)
// GFX12: s_waitcnt vmcnt(1) ; encoding: [0xf7,0x07,0x89,0xbf]

s_waitcnt vmcnt(9)
// GFX12: s_waitcnt vmcnt(9) ; encoding: [0xf7,0x27,0x89,0xbf]

s_waitcnt expcnt(2)
// GFX12: s_waitcnt expcnt(2) ; encoding: [0xf2,0xff,0x89,0xbf]

s_waitcnt lgkmcnt(3)
// GFX12: s_waitcnt lgkmcnt(3) ; encoding: [0x37,0xfc,0x89,0xbf]

s_waitcnt lgkmcnt(9)
// GFX12: s_waitcnt lgkmcnt(9) ; encoding: [0x97,0xfc,0x89,0xbf]

s_waitcnt vmcnt(0), expcnt(0)
// GFX12: s_waitcnt vmcnt(0) expcnt(0) ; encoding: [0xf0,0x03,0x89,0xbf]

s_waitcnt vmcnt(15)
// GFX12: s_waitcnt vmcnt(15) ; encoding: [0xf7,0x3f,0x89,0xbf]

s_waitcnt vmcnt(15) expcnt(6)
// GFX12: s_waitcnt vmcnt(15) expcnt(6) ; encoding: [0xf6,0x3f,0x89,0xbf]

s_waitcnt vmcnt(15) lgkmcnt(14)
// GFX12: s_waitcnt vmcnt(15) lgkmcnt(14) ; encoding: [0xe7,0x3c,0x89,0xbf]

s_waitcnt vmcnt(15) expcnt(6) lgkmcnt(14)
// GFX12: s_waitcnt vmcnt(15) expcnt(6) lgkmcnt(14) ; encoding: [0xe6,0x3c,0x89,0xbf]

s_waitcnt vmcnt(31)
// GFX12: s_waitcnt vmcnt(31) ; encoding: [0xf7,0x7f,0x89,0xbf]

s_waitcnt vmcnt(31) expcnt(6)
// GFX12: s_waitcnt vmcnt(31) expcnt(6) ; encoding: [0xf6,0x7f,0x89,0xbf]

s_waitcnt vmcnt(31) lgkmcnt(14)
// GFX12: s_waitcnt vmcnt(31) lgkmcnt(14) ; encoding: [0xe7,0x7c,0x89,0xbf]

s_waitcnt vmcnt(31) expcnt(6) lgkmcnt(14)
// GFX12: s_waitcnt vmcnt(31) expcnt(6) lgkmcnt(14) ; encoding: [0xe6,0x7c,0x89,0xbf]

s_waitcnt vmcnt(62)
// GFX12: s_waitcnt vmcnt(62) ; encoding: [0xf7,0xfb,0x89,0xbf]

s_waitcnt vmcnt(62) expcnt(6)
// GFX12: s_waitcnt vmcnt(62) expcnt(6) ; encoding: [0xf6,0xfb,0x89,0xbf]

s_waitcnt vmcnt(62) lgkmcnt(14)
// GFX12: s_waitcnt vmcnt(62) lgkmcnt(14) ; encoding: [0xe7,0xf8,0x89,0xbf]

s_waitcnt vmcnt(62) expcnt(6) lgkmcnt(14)
// GFX12: s_waitcnt vmcnt(62) expcnt(6) lgkmcnt(14) ; encoding: [0xe6,0xf8,0x89,0xbf]

//===----------------------------------------------------------------------===//
// s_sendmsg
//===----------------------------------------------------------------------===//

s_sendmsg 2
// GFX12: s_sendmsg sendmsg(MSG_HS_TESSFACTOR) ; encoding: [0x02,0x00,0xb6,0xbf]

s_sendmsg 0xc1d1
// GFX12: s_sendmsg 49617                      ; encoding: [0xd1,0xc1,0xb6,0xbf]

s_sendmsg sendmsg(MSG_HS_TESSFACTOR)
// GFX12: s_sendmsg sendmsg(MSG_HS_TESSFACTOR) ; encoding: [0x02,0x00,0xb6,0xbf]

s_sendmsg 3
// GFX12: s_sendmsg sendmsg(MSG_DEALLOC_VGPRS) ; encoding: [0x03,0x00,0xb6,0xbf]

s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
// GFX12: s_sendmsg sendmsg(MSG_DEALLOC_VGPRS) ; encoding: [0x03,0x00,0xb6,0xbf]

//===----------------------------------------------------------------------===//
// s_delay_alu
//===----------------------------------------------------------------------===//

s_delay_alu 0
// GFX12: s_delay_alu 0                           ; encoding: [0x00,0x00,0x87,0xbf]

s_delay_alu 0x91
// GFX12: s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1) ; encoding: [0x91,0x00,0x87,0xbf]

s_delay_alu instid0(VALU_DEP_1)
// GFX12: s_delay_alu instid0(VALU_DEP_1)         ; encoding: [0x01,0x00,0x87,0xbf]

s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
// GFX12: s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1) ; encoding: [0x81,0x04,0x87,0xbf]

s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
// GFX12: s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3) ; encoding: [0x91,0x01,0x87,0xbf]

s_delay_alu instid1(SALU_CYCLE_2)
// GFX12: s_delay_alu instid1(SALU_CYCLE_2) ; encoding: [0x00,0x05,0x87,0xbf]

s_delay_alu instid1(SALU_CYCLE_3)
// GFX12: s_delay_alu instid1(SALU_CYCLE_3) ; encoding: [0x80,0x05,0x87,0xbf]

s_wait_idle
// GFX12: s_wait_idle ; encoding: [0x00,0x00,0x8a,0xbf]

s_nop 0x0
// GFX12: s_nop 0 ; encoding: [0x00,0x00,0x80,0xbf]

s_nop 0x1234
// GFX12: s_nop 0x1234 ; encoding: [0x34,0x12,0x80,0xbf]

s_nop 0xc1d1
// GFX12: s_nop 0xc1d1 ; encoding: [0xd1,0xc1,0x80,0xbf]

s_endpgm
// GFX12: s_endpgm ; encoding: [0x00,0x00,0xb0,0xbf]

s_endpgm 1
// GFX12: s_endpgm 1 ; encoding: [0x01,0x00,0xb0,0xbf]

s_endpgm 65535
// GFX12: s_endpgm 65535 ; encoding: [0xff,0xff,0xb0,0xbf]

s_branch 0x0
// GFX12: s_branch 0 ; encoding: [0x00,0x00,0xa0,0xbf]

s_branch 0x1234
// GFX12: s_branch 4660 ; encoding: [0x34,0x12,0xa0,0xbf]

s_wakeup
// GFX12: s_wakeup ; encoding: [0x00,0x00,0xb4,0xbf]

s_cbranch_scc0 0x0
// GFX12: s_cbranch_scc0 0 ; encoding: [0x00,0x00,0xa1,0xbf]

s_cbranch_scc0 0x1234
// GFX12: s_cbranch_scc0 4660 ; encoding: [0x34,0x12,0xa1,0xbf]

s_cbranch_scc1 0x0
// GFX12: s_cbranch_scc1 0 ; encoding: [0x00,0x00,0xa2,0xbf]

s_cbranch_scc1 0x1234
// GFX12: s_cbranch_scc1 4660 ; encoding: [0x34,0x12,0xa2,0xbf]

s_cbranch_vccz 0x0
// GFX12: s_cbranch_vccz 0 ; encoding: [0x00,0x00,0xa3,0xbf]

s_cbranch_vccz 0x1234
// GFX12: s_cbranch_vccz 4660 ; encoding: [0x34,0x12,0xa3,0xbf]

s_cbranch_vccnz 0x0
// GFX12: s_cbranch_vccnz 0 ; encoding: [0x00,0x00,0xa4,0xbf]

s_cbranch_vccnz 0x1234
// GFX12: s_cbranch_vccnz 4660 ; encoding: [0x34,0x12,0xa4,0xbf]

s_cbranch_execz 0x0
// GFX12: s_cbranch_execz 0 ; encoding: [0x00,0x00,0xa5,0xbf]

s_cbranch_execz 0x1234
// GFX12: s_cbranch_execz 4660 ; encoding: [0x34,0x12,0xa5,0xbf]

s_cbranch_execnz 0x0
// GFX12: s_cbranch_execnz 0 ; encoding: [0x00,0x00,0xa6,0xbf]

s_cbranch_execnz 0x1234
// GFX12: s_cbranch_execnz 4660 ; encoding: [0x34,0x12,0xa6,0xbf]

s_barrier
// GFX12: s_barrier ; encoding: [0x00,0x00,0xbd,0xbf]

s_setkill 0x0
// GFX12: s_setkill 0 ; encoding: [0x00,0x00,0x81,0xbf]

s_setkill 0x1234
// GFX12: s_setkill 0x1234 ; encoding: [0x34,0x12,0x81,0xbf]

s_setkill 0xc1d1
// GFX12: s_setkill 0xc1d1 ; encoding: [0xd1,0xc1,0x81,0xbf]

s_sethalt 0x0
// GFX12: s_sethalt 0 ; encoding: [0x00,0x00,0x82,0xbf]

s_sethalt 0x1234
// GFX12: s_sethalt 0x1234 ; encoding: [0x34,0x12,0x82,0xbf]

s_sethalt 0xc1d1
// GFX12: s_sethalt 0xc1d1 ; encoding: [0xd1,0xc1,0x82,0xbf]

s_sleep 0x0
// GFX12: s_sleep 0 ; encoding: [0x00,0x00,0x83,0xbf]

s_sleep 0x1234
// GFX12: s_sleep 0x1234 ; encoding: [0x34,0x12,0x83,0xbf]

s_sleep 0xc1d1
// GFX12: s_sleep 0xc1d1 ; encoding: [0xd1,0xc1,0x83,0xbf]

s_setprio 0x0
// GFX12: s_setprio 0 ; encoding: [0x00,0x00,0xb5,0xbf]

s_setprio 0x1234
// GFX12: s_setprio 0x1234 ; encoding: [0x34,0x12,0xb5,0xbf]

s_setprio 0xc1d1
// GFX12: s_setprio 0xc1d1 ; encoding: [0xd1,0xc1,0xb5,0xbf]

s_sendmsghalt 0x0
// GFX12: s_sendmsghalt sendmsg(0, 0, 0) ; encoding: [0x00,0x00,0xb7,0xbf]

s_sendmsghalt 0x1234
// GFX12: s_sendmsghalt 4660 ; encoding: [0x34,0x12,0xb7,0xbf]

s_sendmsghalt 0xc1d1
// GFX12: s_sendmsghalt 49617 ; encoding: [0xd1,0xc1,0xb7,0xbf]

s_trap 0x0
// GFX12: s_trap 0 ; encoding: [0x00,0x00,0x90,0xbf]

s_trap 0x1234
// GFX12: s_trap 0x1234 ; encoding: [0x34,0x12,0x90,0xbf]

s_trap 0xc1d1
// GFX12: s_trap 0xc1d1 ; encoding: [0xd1,0xc1,0x90,0xbf]

s_icache_inv
// GFX12: s_icache_inv ; encoding: [0x00,0x00,0xbc,0xbf]

s_incperflevel 0x0
// GFX12: s_incperflevel 0 ; encoding: [0x00,0x00,0xb8,0xbf]

s_incperflevel 0x1234
// GFX12: s_incperflevel 0x1234 ; encoding: [0x34,0x12,0xb8,0xbf]

s_incperflevel 0xc1d1
// GFX12: s_incperflevel 0xc1d1 ; encoding: [0xd1,0xc1,0xb8,0xbf]

s_decperflevel 0x0
// GFX12: s_decperflevel 0 ; encoding: [0x00,0x00,0xb9,0xbf]

s_decperflevel 0x1234
// GFX12: s_decperflevel 0x1234 ; encoding: [0x34,0x12,0xb9,0xbf]

s_decperflevel 0xc1d1
// GFX12: s_decperflevel 0xc1d1 ; encoding: [0xd1,0xc1,0xb9,0xbf]

s_ttracedata
// GFX12: s_ttracedata ; encoding: [0x00,0x00,0xba,0xbf]

s_endpgm_saved
// GFX12: s_endpgm_saved ; encoding: [0x00,0x00,0xb1,0xbf]

s_code_end
// GFX12: s_code_end ; encoding: [0x00,0x00,0x9f,0xbf]

s_clause 0x0
// GFX12: s_clause 0x0 ; encoding: [0x00,0x00,0x85,0xbf]

s_clause 0x1234
// GFX12: s_clause 0x1234 ; encoding: [0x34,0x12,0x85,0xbf]

s_clause 0xc1d1
// GFX12: s_clause 0xc1d1 ; encoding: [0xd1,0xc1,0x85,0xbf]

s_round_mode 0x0
// GFX12: s_round_mode 0x0 ; encoding: [0x00,0x00,0x91,0xbf]

s_round_mode 0x1234
// GFX12: s_round_mode 0x1234 ; encoding: [0x34,0x12,0x91,0xbf]

s_round_mode 0xc1d1
// GFX12: s_round_mode 0xc1d1 ; encoding: [0xd1,0xc1,0x91,0xbf]

s_denorm_mode 0x0
// GFX12: s_denorm_mode 0 ; encoding: [0x00,0x00,0x92,0xbf]

s_denorm_mode 0x1234
// GFX12: s_denorm_mode 0x1234 ; encoding: [0x34,0x12,0x92,0xbf]

s_denorm_mode 0xc1d1
// GFX12: s_denorm_mode 0xc1d1 ; encoding: [0xd1,0xc1,0x92,0xbf]

s_ttracedata_imm 0x0
// GFX12: s_ttracedata_imm 0x0 ; encoding: [0x00,0x00,0xbb,0xbf]

s_ttracedata_imm 0x1234
// GFX12: s_ttracedata_imm 0x1234 ; encoding: [0x34,0x12,0xbb,0xbf]

s_ttracedata_imm 0xc1d1
// GFX12: s_ttracedata_imm 0xc1d1 ; encoding: [0xd1,0xc1,0xbb,0xbf]

s_wait_event 0x3141
// GFX12: s_wait_event 0x3141 ; encoding: [0x41,0x31,0x8b,0xbf]

s_wait_event 0xc1d1
// GFX12: s_wait_event 0xc1d1 ; encoding: [0xd1,0xc1,0x8b,0xbf]
