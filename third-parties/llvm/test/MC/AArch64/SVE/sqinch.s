// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump --no-print-imm-hex -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump --no-print-imm-hex -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN

// ---------------------------------------------------------------------------//
// Test 64-bit form (x0) and its aliases
// ---------------------------------------------------------------------------//

sqinch  x0
// CHECK-INST: sqinch  x0
// CHECK-ENCODING: [0xe0,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f3e0 <unknown>

sqinch  x0, all
// CHECK-INST: sqinch  x0
// CHECK-ENCODING: [0xe0,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f3e0 <unknown>

sqinch  x0, all, mul #1
// CHECK-INST: sqinch  x0
// CHECK-ENCODING: [0xe0,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f3e0 <unknown>

sqinch  x0, all, mul #16
// CHECK-INST: sqinch  x0, all, mul #16
// CHECK-ENCODING: [0xe0,0xf3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 047ff3e0 <unknown>


// ---------------------------------------------------------------------------//
// Test 32-bit form (x0, w0) and its aliases
// ---------------------------------------------------------------------------//

sqinch  x0, w0
// CHECK-INST: sqinch  x0, w0
// CHECK-ENCODING: [0xe0,0xf3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460f3e0 <unknown>

sqinch  x0, w0, all
// CHECK-INST: sqinch  x0, w0
// CHECK-ENCODING: [0xe0,0xf3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460f3e0 <unknown>

sqinch  x0, w0, all, mul #1
// CHECK-INST: sqinch  x0, w0
// CHECK-ENCODING: [0xe0,0xf3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460f3e0 <unknown>

sqinch  x0, w0, all, mul #16
// CHECK-INST: sqinch  x0, w0, all, mul #16
// CHECK-ENCODING: [0xe0,0xf3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 046ff3e0 <unknown>

sqinch  x0, w0, pow2
// CHECK-INST: sqinch  x0, w0, pow2
// CHECK-ENCODING: [0x00,0xf0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460f000 <unknown>

sqinch  x0, w0, pow2, mul #16
// CHECK-INST: sqinch  x0, w0, pow2, mul #16
// CHECK-ENCODING: [0x00,0xf0,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 046ff000 <unknown>


// ---------------------------------------------------------------------------//
// Test vector form and aliases.
// ---------------------------------------------------------------------------//
sqinch  z0.h
// CHECK-INST: sqinch  z0.h
// CHECK-ENCODING: [0xe0,0xc3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460c3e0 <unknown>

sqinch  z0.h, all
// CHECK-INST: sqinch  z0.h
// CHECK-ENCODING: [0xe0,0xc3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460c3e0 <unknown>

sqinch  z0.h, all, mul #1
// CHECK-INST: sqinch  z0.h
// CHECK-ENCODING: [0xe0,0xc3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460c3e0 <unknown>

sqinch  z0.h, all, mul #16
// CHECK-INST: sqinch  z0.h, all, mul #16
// CHECK-ENCODING: [0xe0,0xc3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 046fc3e0 <unknown>

sqinch  z0.h, pow2
// CHECK-INST: sqinch  z0.h, pow2
// CHECK-ENCODING: [0x00,0xc0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460c000 <unknown>

sqinch  z0.h, pow2, mul #16
// CHECK-INST: sqinch  z0.h, pow2, mul #16
// CHECK-ENCODING: [0x00,0xc0,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 046fc000 <unknown>


// ---------------------------------------------------------------------------//
// Test all patterns for 64-bit form
// ---------------------------------------------------------------------------//

sqinch  x0, pow2
// CHECK-INST: sqinch  x0, pow2
// CHECK-ENCODING: [0x00,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f000 <unknown>

sqinch  x0, vl1
// CHECK-INST: sqinch  x0, vl1
// CHECK-ENCODING: [0x20,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f020 <unknown>

sqinch  x0, vl2
// CHECK-INST: sqinch  x0, vl2
// CHECK-ENCODING: [0x40,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f040 <unknown>

sqinch  x0, vl3
// CHECK-INST: sqinch  x0, vl3
// CHECK-ENCODING: [0x60,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f060 <unknown>

sqinch  x0, vl4
// CHECK-INST: sqinch  x0, vl4
// CHECK-ENCODING: [0x80,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f080 <unknown>

sqinch  x0, vl5
// CHECK-INST: sqinch  x0, vl5
// CHECK-ENCODING: [0xa0,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f0a0 <unknown>

sqinch  x0, vl6
// CHECK-INST: sqinch  x0, vl6
// CHECK-ENCODING: [0xc0,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f0c0 <unknown>

sqinch  x0, vl7
// CHECK-INST: sqinch  x0, vl7
// CHECK-ENCODING: [0xe0,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f0e0 <unknown>

sqinch  x0, vl8
// CHECK-INST: sqinch  x0, vl8
// CHECK-ENCODING: [0x00,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f100 <unknown>

sqinch  x0, vl16
// CHECK-INST: sqinch  x0, vl16
// CHECK-ENCODING: [0x20,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f120 <unknown>

sqinch  x0, vl32
// CHECK-INST: sqinch  x0, vl32
// CHECK-ENCODING: [0x40,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f140 <unknown>

sqinch  x0, vl64
// CHECK-INST: sqinch  x0, vl64
// CHECK-ENCODING: [0x60,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f160 <unknown>

sqinch  x0, vl128
// CHECK-INST: sqinch  x0, vl128
// CHECK-ENCODING: [0x80,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f180 <unknown>

sqinch  x0, vl256
// CHECK-INST: sqinch  x0, vl256
// CHECK-ENCODING: [0xa0,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f1a0 <unknown>

sqinch  x0, #14
// CHECK-INST: sqinch  x0, #14
// CHECK-ENCODING: [0xc0,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f1c0 <unknown>

sqinch  x0, #15
// CHECK-INST: sqinch  x0, #15
// CHECK-ENCODING: [0xe0,0xf1,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f1e0 <unknown>

sqinch  x0, #16
// CHECK-INST: sqinch  x0, #16
// CHECK-ENCODING: [0x00,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f200 <unknown>

sqinch  x0, #17
// CHECK-INST: sqinch  x0, #17
// CHECK-ENCODING: [0x20,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f220 <unknown>

sqinch  x0, #18
// CHECK-INST: sqinch  x0, #18
// CHECK-ENCODING: [0x40,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f240 <unknown>

sqinch  x0, #19
// CHECK-INST: sqinch  x0, #19
// CHECK-ENCODING: [0x60,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f260 <unknown>

sqinch  x0, #20
// CHECK-INST: sqinch  x0, #20
// CHECK-ENCODING: [0x80,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f280 <unknown>

sqinch  x0, #21
// CHECK-INST: sqinch  x0, #21
// CHECK-ENCODING: [0xa0,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f2a0 <unknown>

sqinch  x0, #22
// CHECK-INST: sqinch  x0, #22
// CHECK-ENCODING: [0xc0,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f2c0 <unknown>

sqinch  x0, #23
// CHECK-INST: sqinch  x0, #23
// CHECK-ENCODING: [0xe0,0xf2,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f2e0 <unknown>

sqinch  x0, #24
// CHECK-INST: sqinch  x0, #24
// CHECK-ENCODING: [0x00,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f300 <unknown>

sqinch  x0, #25
// CHECK-INST: sqinch  x0, #25
// CHECK-ENCODING: [0x20,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f320 <unknown>

sqinch  x0, #26
// CHECK-INST: sqinch  x0, #26
// CHECK-ENCODING: [0x40,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f340 <unknown>

sqinch  x0, #27
// CHECK-INST: sqinch  x0, #27
// CHECK-ENCODING: [0x60,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f360 <unknown>

sqinch  x0, #28
// CHECK-INST: sqinch  x0, #28
// CHECK-ENCODING: [0x80,0xf3,0x70,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0470f380 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

sqinch  z0.h
// CHECK-INST: sqinch	z0.h
// CHECK-ENCODING: [0xe0,0xc3,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460c3e0 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

sqinch  z0.h, pow2, mul #16
// CHECK-INST: sqinch	z0.h, pow2, mul #16
// CHECK-ENCODING: [0x00,0xc0,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 046fc000 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

sqinch  z0.h, pow2
// CHECK-INST: sqinch	z0.h, pow2
// CHECK-ENCODING: [0x00,0xc0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0460c000 <unknown>
