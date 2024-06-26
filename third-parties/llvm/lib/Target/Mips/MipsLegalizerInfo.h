﻿//===- MipsLegalizerInfo ----------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
/// \file
/// This file declares the targeting of the Machinelegalizer class for Mips.
/// \todo This should be generated by TableGen.
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_MIPS_MIPSMACHINELEGALIZER_H
#define LLVM_LIB_TARGET_MIPS_MIPSMACHINELEGALIZER_H

#include "llvm/CodeGen/GlobalISel/GISelChangeObserver.h"
#include "llvm/CodeGen/GlobalISel/LegalizerInfo.h"

namespace llvm {

class MipsSubtarget;

/// This class provides legalization strategies.
class MipsLegalizerInfo : public LegalizerInfo {
public:
  MipsLegalizerInfo(const MipsSubtarget &ST);

  bool legalizeCustom(LegalizerHelper &Helper, MachineInstr &MI,
                      LostDebugLocObserver &LocObserver) const override;

  bool legalizeIntrinsic(LegalizerHelper &Helper,
                         MachineInstr &MI) const override;
};
} // end namespace llvm
#endif
