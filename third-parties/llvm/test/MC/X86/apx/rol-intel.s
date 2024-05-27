# RUN: llvm-mc -triple x86_64 -show-encoding -x86-asm-syntax=intel -output-asm-variant=1 %s | FileCheck %s

# CHECK: {evex}	rol	bl, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xc0,0xc3,0x7b]
         {evex}	rol	bl, 123
# CHECK: {nf}	rol	bl, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xc0,0xc3,0x7b]
         {nf}	rol	bl, 123
# CHECK: rol	bl, bl, 123
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xc0,0xc3,0x7b]
         rol	bl, bl, 123
# CHECK: {nf}	rol	bl, bl, 123
# CHECK: encoding: [0x62,0xf4,0x64,0x1c,0xc0,0xc3,0x7b]
         {nf}	rol	bl, bl, 123
# CHECK: {evex}	rol	dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xc1,0xc2,0x7b]
         {evex}	rol	dx, 123
# CHECK: {nf}	rol	dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xc1,0xc2,0x7b]
         {nf}	rol	dx, 123
# CHECK: rol	dx, dx, 123
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xc1,0xc2,0x7b]
         rol	dx, dx, 123
# CHECK: {nf}	rol	dx, dx, 123
# CHECK: encoding: [0x62,0xf4,0x6d,0x1c,0xc1,0xc2,0x7b]
         {nf}	rol	dx, dx, 123
# CHECK: {evex}	rol	ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xc1,0xc1,0x7b]
         {evex}	rol	ecx, 123
# CHECK: {nf}	rol	ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xc1,0xc1,0x7b]
         {nf}	rol	ecx, 123
# CHECK: rol	ecx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xc1,0xc1,0x7b]
         rol	ecx, ecx, 123
# CHECK: {nf}	rol	ecx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0xc1,0xc1,0x7b]
         {nf}	rol	ecx, ecx, 123
# CHECK: {evex}	rol	r9, 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xc1,0xc1,0x7b]
         {evex}	rol	r9, 123
# CHECK: {nf}	rol	r9, 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xc1,0xc1,0x7b]
         {nf}	rol	r9, 123
# CHECK: rol	r9, r9, 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xc1,0xc1,0x7b]
         rol	r9, r9, 123
# CHECK: {nf}	rol	r9, r9, 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xc1,0xc1,0x7b]
         {nf}	rol	r9, r9, 123
# CHECK: {evex}	rol	byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xc0,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rol	byte ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xc0,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	byte ptr [r8 + 4*rax + 291], 123
# CHECK: rol	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xc0,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         rol	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xc0,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	rol	word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rol	word ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	word ptr [r8 + 4*rax + 291], 123
# CHECK: rol	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         rol	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	rol	dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rol	dword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	dword ptr [r8 + 4*rax + 291], 123
# CHECK: rol	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         rol	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	rol	qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rol	qword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	qword ptr [r8 + 4*rax + 291], 123
# CHECK: rol	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         rol	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	rol	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xc1,0x84,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	rol	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	rol	bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd0,0xc3]
         {evex}	rol	bl
# CHECK: {nf}	rol	bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd0,0xc3]
         {nf}	rol	bl
# CHECK: {evex}	rol	bl, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd2,0xc3]
         {evex}	rol	bl, cl
# CHECK: {nf}	rol	bl, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd2,0xc3]
         {nf}	rol	bl, cl
# CHECK: rol	bl, bl, cl
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd2,0xc3]
         rol	bl, bl, cl
# CHECK: {nf}	rol	bl, bl, cl
# CHECK: encoding: [0x62,0xf4,0x64,0x1c,0xd2,0xc3]
         {nf}	rol	bl, bl, cl
# CHECK: {evex}	rol	dx, cl
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd3,0xc2]
         {evex}	rol	dx, cl
# CHECK: {nf}	rol	dx, cl
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xd3,0xc2]
         {nf}	rol	dx, cl
# CHECK: rol	dx, dx, cl
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xd3,0xc2]
         rol	dx, dx, cl
# CHECK: {nf}	rol	dx, dx, cl
# CHECK: encoding: [0x62,0xf4,0x6d,0x1c,0xd3,0xc2]
         {nf}	rol	dx, dx, cl
# CHECK: {evex}	rol	ecx, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd3,0xc1]
         {evex}	rol	ecx, cl
# CHECK: {nf}	rol	ecx, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd3,0xc1]
         {nf}	rol	ecx, cl
# CHECK: rol	ecx, ecx, cl
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xd3,0xc1]
         rol	ecx, ecx, cl
# CHECK: {nf}	rol	ecx, ecx, cl
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0xd3,0xc1]
         {nf}	rol	ecx, ecx, cl
# CHECK: {evex}	rol	r9, cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd3,0xc1]
         {evex}	rol	r9, cl
# CHECK: {nf}	rol	r9, cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd3,0xc1]
         {nf}	rol	r9, cl
# CHECK: rol	r9, r9, cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd3,0xc1]
         rol	r9, r9, cl
# CHECK: {nf}	rol	r9, r9, cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd3,0xc1]
         {nf}	rol	r9, r9, cl
# CHECK: {evex}	rol	byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd2,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	byte ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd2,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	byte ptr [r8 + 4*rax + 291], cl
# CHECK: rol	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd2,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xd2,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	rol	word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	word ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	word ptr [r8 + 4*rax + 291], cl
# CHECK: rol	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	rol	dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	dword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	dword ptr [r8 + 4*rax + 291], cl
# CHECK: rol	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	rol	qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	qword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	qword ptr [r8 + 4*rax + 291], cl
# CHECK: rol	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	rol	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd3,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	rol	dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd1,0xc2]
         {evex}	rol	dx
# CHECK: {nf}	rol	dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xd1,0xc2]
         {nf}	rol	dx
# CHECK: rol	dx, dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xd1,0xc2]
         rol	dx, dx
# CHECK: {nf}	rol	dx, dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x1c,0xd1,0xc2]
         {nf}	rol	dx, dx
# CHECK: {evex}	rol	ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd1,0xc1]
         {evex}	rol	ecx
# CHECK: {nf}	rol	ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd1,0xc1]
         {nf}	rol	ecx
# CHECK: rol	ecx, ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xd1,0xc1]
         rol	ecx, ecx
# CHECK: {nf}	rol	ecx, ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0xd1,0xc1]
         {nf}	rol	ecx, ecx
# CHECK: {evex}	rol	r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0xc1]
         {evex}	rol	r9
# CHECK: {nf}	rol	r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd1,0xc1]
         {nf}	rol	r9
# CHECK: rol	r9, r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd1,0xc1]
         rol	r9, r9
# CHECK: {nf}	rol	r9, r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd1,0xc1]
         {nf}	rol	r9, r9
# CHECK: {evex}	rol	byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd0,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	byte ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd0,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	byte ptr [r8 + 4*rax + 291]
# CHECK: rol	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd0,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xd0,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {evex}	rol	word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	word ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	word ptr [r8 + 4*rax + 291]
# CHECK: rol	dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	dx, word ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	dx, word ptr [r8 + 4*rax + 291]
# CHECK: {evex}	rol	dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	dword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	dword ptr [r8 + 4*rax + 291]
# CHECK: rol	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {evex}	rol	qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {evex}	rol	qword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	qword ptr [r8 + 4*rax + 291]
# CHECK: rol	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         rol	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	rol	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd1,0x84,0x80,0x23,0x01,0x00,0x00]
         {nf}	rol	r9, qword ptr [r8 + 4*rax + 291]
