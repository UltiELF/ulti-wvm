// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2 < %s \
// RUN:        | llvm-objdump -d --mattr=+sve2 - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2 < %s \
// RUN:   | llvm-objdump -d --mattr=-sve2 - | FileCheck %s --check-prefix=CHECK-UNKNOWN

sqcadd   z0.b, z0.b, z0.b, #90
// CHECK-INST: sqcadd   z0.b, z0.b, z0.b, #90
// CHECK-ENCODING: [0x00,0xd8,0x01,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 4501d800 <unknown>

sqcadd   z0.h, z0.h, z0.h, #90
// CHECK-INST: sqcadd   z0.h, z0.h, z0.h, #90
// CHECK-ENCODING: [0x00,0xd8,0x41,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 4541d800 <unknown>

sqcadd   z0.s, z0.s, z0.s, #90
// CHECK-INST: sqcadd   z0.s, z0.s, z0.s, #90
// CHECK-ENCODING: [0x00,0xd8,0x81,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 4581d800 <unknown>

sqcadd   z0.d, z0.d, z0.d, #90
// CHECK-INST: sqcadd   z0.d, z0.d, z0.d, #90
// CHECK-ENCODING: [0x00,0xd8,0xc1,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 45c1d800 <unknown>

sqcadd   z31.b, z31.b, z31.b, #270
// CHECK-INST: sqcadd   z31.b, z31.b, z31.b, #270
// CHECK-ENCODING: [0xff,0xdf,0x01,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 4501dfff <unknown>

sqcadd   z31.h, z31.h, z31.h, #270
// CHECK-INST: sqcadd   z31.h, z31.h, z31.h, #270
// CHECK-ENCODING: [0xff,0xdf,0x41,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 4541dfff <unknown>

sqcadd   z31.s, z31.s, z31.s, #270
// CHECK-INST: sqcadd   z31.s, z31.s, z31.s, #270
// CHECK-ENCODING: [0xff,0xdf,0x81,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 4581dfff <unknown>

sqcadd   z31.d, z31.d, z31.d, #270
// CHECK-INST: sqcadd   z31.d, z31.d, z31.d, #270
// CHECK-ENCODING: [0xff,0xdf,0xc1,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 45c1dfff <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z4, z6
// CHECK-INST: movprfx	z4, z6
// CHECK-ENCODING: [0xc4,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bcc4 <unknown>

sqcadd   z4.d, z4.d, z31.d, #270
// CHECK-INST: sqcadd	z4.d, z4.d, z31.d, #270
// CHECK-ENCODING: [0xe4,0xdf,0xc1,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 45c1dfe4 <unknown>
