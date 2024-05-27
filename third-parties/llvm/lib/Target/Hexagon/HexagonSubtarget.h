//===- HexagonSubtarget.h - Define Subtarget for the Hexagon ----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares the Hexagon specific subclass of TargetSubtarget.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_HEXAGON_HEXAGONSUBTARGET_H
#define LLVM_LIB_TARGET_HEXAGON_HEXAGONSUBTARGET_H

#include "HexagonDepArch.h"
#include "HexagonFrameLowering.h"
#include "HexagonISelLowering.h"
#include "HexagonInstrInfo.h"
#include "HexagonRegisterInfo.h"
#include "HexagonSelectionDAGInfo.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/CodeGen/ScheduleDAGMutation.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/MC/MCInstrItineraries.h"
#include "llvm/Support/Alignment.h"
#include <memory>
#include <string>
#include <vector>

#define GET_SUBTARGETINFO_HEADER
#include "HexagonGenSubtargetInfo.inc"

namespace llvm {

class MachineInstr;
class SDep;
class SUnit;
class TargetMachine;
class Triple;

class HexagonSubtarget : public HexagonGenSubtargetInfo {
  virtual void anchor();

  bool UseHVX64BOps = false;
  bool UseHVX128BOps = false;

  bool UseAudioOps = false;
  bool UseCompound = false;
  bool UseLongCalls = false;
  bool UseMemops = false;
  bool UsePackets = false;
  bool UseNewValueJumps = false;
  bool UseNewValueStores = false;
  bool UseSmallData = false;
  bool UseUnsafeMath = false;
  bool UseZRegOps = false;
  bool UseHVXIEEEFPOps = false;
  bool UseHVXQFloatOps = false;
  bool UseHVXFloatingPoint = false;
  bool UseCabac = false;

  bool HasPreV65 = false;
  bool HasMemNoShuf = false;
  bool EnableDuplex = false;
  bool ReservedR19 = false;
  bool NoreturnStackElim = false;

public:
  Hexagon::ArchEnum HexagonArchVersion;
  Hexagon::ArchEnum HexagonHVXVersion = Hexagon::ArchEnum::NoArch;
  CodeGenOptLevel OptLevel;
  /// True if the target should use Back-Skip-Back scheduling. This is the
  /// default for V60.
  bool UseBSBScheduling;

  struct UsrOverflowMutation : public ScheduleDAGMutation {
    void apply(ScheduleDAGInstrs *DAG) override;
  };
  struct HVXMemLatencyMutation : public ScheduleDAGMutation {
    void apply(ScheduleDAGInstrs *DAG) override;
  };
  struct CallMutation : public ScheduleDAGMutation {
    void apply(ScheduleDAGInstrs *DAG) override;
  private:
    bool shouldTFRICallBind(const HexagonInstrInfo &HII,
          const SUnit &Inst1, const SUnit &Inst2) const;
  };
  struct BankConflictMutation : public ScheduleDAGMutation {
    void apply(ScheduleDAGInstrs *DAG) override;
  };

private:
  enum HexagonProcFamilyEnum { Others, TinyCore };

  std::string CPUString;
  HexagonProcFamilyEnum HexagonProcFamily = Others;
  Triple TargetTriple;

  // The following objects can use the TargetTriple, so they must be
  // declared after it.
  HexagonInstrInfo InstrInfo;
  HexagonRegisterInfo RegInfo;
  HexagonTargetLowering TLInfo;
  HexagonSelectionDAGInfo TSInfo;
  HexagonFrameLowering FrameLowering;
  InstrItineraryData InstrItins;

public:
  HexagonSubtarget(const Triple &TT, StringRef CPU, StringRef FS,
                   const TargetMachine &TM);

  const Triple &getTargetTriple() const { return TargetTriple; }
  bool isEnvironmentMusl() const {
    return TargetTriple.getEnvironment() == Triple::Musl;
  }

  /// getInstrItins - Return the instruction itineraries based on subtarget
  /// selection.
  const InstrItineraryData *getInstrItineraryData() const override {
    return &InstrItins;
  }
  const HexagonInstrInfo *getInstrInfo() const override { return &InstrInfo; }
  const HexagonRegisterInfo *getRegisterInfo() const override {
    return &RegInfo;
  }
  const HexagonTargetLowering *getTargetLowering() const override {
    return &TLInfo;
  }
  const HexagonFrameLowering *getFrameLowering() const override {
    return &FrameLowering;
  }
  const HexagonSelectionDAGInfo *getSelectionDAGInfo() const override {
    return &TSInfo;
  }

  HexagonSubtarget &initializeSubtargetDependencies(StringRef CPU,
                                                    StringRef FS);

  /// ParseSubtargetFeatures - Parses features string setting specified
  /// subtarget options.  Definition of function is auto generated by tblgen.
  void ParseSubtargetFeatures(StringRef CPU, StringRef TuneCPU, StringRef FS);

  bool isXRaySupported() const override { return true; }

  bool hasV5Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V5;
  }
  bool hasV5OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V5;
  }
  bool hasV55Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V55;
  }
  bool hasV55OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V55;
  }
  bool hasV60Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V60;
  }
  bool hasV60OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V60;
  }
  bool hasV62Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V62;
  }
  bool hasV62OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V62;
  }
  bool hasV65Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V65;
  }
  bool hasV65OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V65;
  }
  bool hasV66Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V66;
  }
  bool hasV66OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V66;
  }
  bool hasV67Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V67;
  }
  bool hasV67OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V67;
  }
  bool hasV68Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V68;
  }
  bool hasV68OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V68;
  }
  bool hasV69Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V69;
  }
  bool hasV69OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V69;
  }
  bool hasV71Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V71;
  }
  bool hasV71OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V71;
  }
  bool hasV73Ops() const {
    return getHexagonArchVersion() >= Hexagon::ArchEnum::V73;
  }
  bool hasV73OpsOnly() const {
    return getHexagonArchVersion() == Hexagon::ArchEnum::V73;
  }

  bool useAudioOps() const { return UseAudioOps; }
  bool useCompound() const { return UseCompound; }
  bool useLongCalls() const { return UseLongCalls; }
  bool useMemops() const { return UseMemops; }
  bool usePackets() const { return UsePackets; }
  bool useNewValueJumps() const { return UseNewValueJumps; }
  bool useNewValueStores() const { return UseNewValueStores; }
  bool useSmallData() const { return UseSmallData; }
  bool useUnsafeMath() const { return UseUnsafeMath; }
  bool useZRegOps() const { return UseZRegOps; }
  bool useCabac() const { return UseCabac; }

  bool isTinyCore() const { return HexagonProcFamily == TinyCore; }
  bool isTinyCoreWithDuplex() const { return isTinyCore() && EnableDuplex; }

  bool useHVXIEEEFPOps() const { return UseHVXIEEEFPOps && useHVXOps(); }
  bool useHVXQFloatOps() const {
    return UseHVXQFloatOps && HexagonHVXVersion >= Hexagon::ArchEnum::V68;
  }
  bool useHVXFloatingPoint() const { return UseHVXFloatingPoint; }
  bool useHVXOps() const {
    return HexagonHVXVersion > Hexagon::ArchEnum::NoArch;
  }
  bool useHVXV60Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V60;
  }
  bool useHVXV62Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V62;
  }
  bool useHVXV65Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V65;
  }
  bool useHVXV66Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V66;
  }
  bool useHVXV67Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V67;
  }
  bool useHVXV68Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V68;
  }
  bool useHVXV69Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V69;
  }
  bool useHVXV71Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V71;
  }
  bool useHVXV73Ops() const {
    return HexagonHVXVersion >= Hexagon::ArchEnum::V73;
  }
  bool useHVX128BOps() const { return useHVXOps() && UseHVX128BOps; }
  bool useHVX64BOps() const { return useHVXOps() && UseHVX64BOps; }

  bool hasMemNoShuf() const { return HasMemNoShuf; }
  bool hasReservedR19() const { return ReservedR19; }
  bool usePredicatedCalls() const;

  bool noreturnStackElim() const { return NoreturnStackElim; }

  bool useBSBScheduling() const { return UseBSBScheduling; }
  bool enableMachineScheduler() const override;

  // Always use the TargetLowering default scheduler.
  // FIXME: This will use the vliw scheduler which is probably just hurting
  // compiler time and will be removed eventually anyway.
  bool enableMachineSchedDefaultSched() const override { return false; }

  // For use with PostRAScheduling: get the anti-dependence breaking that should
  // be performed before post-RA scheduling.
  AntiDepBreakMode getAntiDepBreakMode() const override { return ANTIDEP_ALL; }
  /// True if the subtarget should run a scheduler after register
  /// allocation.
  bool enablePostRAScheduler() const override { return true; }

  bool enableSubRegLiveness() const override;

  const std::string &getCPUString () const { return CPUString; }

  const Hexagon::ArchEnum &getHexagonArchVersion() const {
    return HexagonArchVersion;
  }

  void getPostRAMutations(
      std::vector<std::unique_ptr<ScheduleDAGMutation>> &Mutations)
      const override;

  void getSMSMutations(
      std::vector<std::unique_ptr<ScheduleDAGMutation>> &Mutations)
      const override;

  /// Enable use of alias analysis during code generation (during MI
  /// scheduling, DAGCombine, etc.).
  bool useAA() const override;

  /// Perform target specific adjustments to the latency of a schedule
  /// dependency.
  void adjustSchedDependency(SUnit *Def, int DefOpIdx, SUnit *Use, int UseOpIdx,
                             SDep &Dep) const override;

  unsigned getVectorLength() const {
    assert(useHVXOps());
    if (useHVX64BOps())
      return 64;
    if (useHVX128BOps())
      return 128;
    llvm_unreachable("Invalid HVX vector length settings");
  }

  ArrayRef<MVT> getHVXElementTypes() const {
    static MVT Types[] = {MVT::i8, MVT::i16, MVT::i32};
    static MVT TypesV68[] = {MVT::i8, MVT::i16, MVT::i32, MVT::f16, MVT::f32};

    if (useHVXV68Ops() && useHVXFloatingPoint())
      return ArrayRef(TypesV68);
    return ArrayRef(Types);
  }

  bool isHVXElementType(MVT Ty, bool IncludeBool = false) const;
  bool isHVXVectorType(EVT VecTy, bool IncludeBool = false) const;
  bool isTypeForHVX(Type *VecTy, bool IncludeBool = false) const;

  Align getTypeAlignment(MVT Ty) const {
    if (isHVXVectorType(Ty, true))
      return Align(getVectorLength());
    return Align(std::max<unsigned>(1, Ty.getSizeInBits() / 8));
  }

  unsigned getL1CacheLineSize() const;
  unsigned getL1PrefetchDistance() const;

  Intrinsic::ID getIntrinsicId(unsigned Opc) const;

private:
  // Helper function responsible for increasing the latency only.
  int updateLatency(MachineInstr &SrcInst, MachineInstr &DstInst,
                    bool IsArtificial, int Latency) const;
  void restoreLatency(SUnit *Src, SUnit *Dst) const;
  void changeLatency(SUnit *Src, SUnit *Dst, unsigned Lat) const;
  bool isBestZeroLatency(SUnit *Src, SUnit *Dst, const HexagonInstrInfo *TII,
      SmallSet<SUnit*, 4> &ExclSrc, SmallSet<SUnit*, 4> &ExclDst) const;
};

} // end namespace llvm

#endif // LLVM_LIB_TARGET_HEXAGON_HEXAGONSUBTARGET_H
