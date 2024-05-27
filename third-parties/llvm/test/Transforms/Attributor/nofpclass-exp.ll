; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT

declare float @llvm.exp.f32(float)
declare float @llvm.exp2.f32(float)
declare float @llvm.exp10.f32(float)

define float @ret_exp(float %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_noinf(float nofpclass(inf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp_noinf
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_nopinf(float nofpclass(pinf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp_nopinf
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_noninf(float nofpclass(ninf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp_noninf
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_nonan(float nofpclass(nan) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp_nonan
; CHECK-SAME: (float nofpclass(nan ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_nonan_noinf(float nofpclass(nan inf) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp_nonan_noinf
; CHECK-SAME: (float nofpclass(nan inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_nonan_noinf_nozero(float nofpclass(nan inf zero) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp_nonan_noinf_nozero
; CHECK-SAME: (float nofpclass(nan inf zero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_noinf_nozero(float nofpclass(inf zero) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp_noinf_nozero
; CHECK-SAME: (float nofpclass(inf zero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_noinf_nonegzero(float nofpclass(inf nzero) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp_noinf_nonegzero
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp.f32(float %arg0)
  ret float %call
}

define float @ret_exp_positive_source(i32 %arg) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp_positive_source
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[UITOFP:%.*]] = uitofp i32 [[ARG]] to float
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp.f32(float [[UITOFP]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %uitofp = uitofp i32 %arg to float
  %call = call float @llvm.exp.f32(float %uitofp)
  ret float %call
}

; Could produce a nan because we don't know if the multiply is negative.
define float @ret_exp_unknown_sign(float nofpclass(nan) %arg0, float nofpclass(nan) %arg1) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp_unknown_sign
; CHECK-SAME: (float nofpclass(nan ninf nzero nsub nnorm) [[ARG0:%.*]], float nofpclass(nan ninf nzero nsub nnorm) [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[UNKNOWN_SIGN_NOT_NAN:%.*]] = fmul nnan float [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp.f32(float [[UNKNOWN_SIGN_NOT_NAN]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %unknown.sign.not.nan = fmul nnan float %arg0, %arg1
  %call = call float @llvm.exp.f32(float %unknown.sign.not.nan)
  ret float %call
}

define float @ret_exp2(float %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp2
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_noinf(float nofpclass(inf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp2_noinf
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_nopinf(float nofpclass(pinf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp2_nopinf
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_noninf(float nofpclass(ninf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp2_noninf
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_nonan(float nofpclass(nan) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp2_nonan
; CHECK-SAME: (float nofpclass(nan ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_nonan_noinf(float nofpclass(nan inf) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp2_nonan_noinf
; CHECK-SAME: (float nofpclass(nan inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_nonan_noinf_nozero(float nofpclass(nan inf zero) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp2_nonan_noinf_nozero
; CHECK-SAME: (float nofpclass(nan inf zero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_noinf_nozero(float nofpclass(inf zero) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp2_noinf_nozero
; CHECK-SAME: (float nofpclass(inf zero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_noinf_nonegzero(float nofpclass(inf nzero) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp2_noinf_nonegzero
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp2.f32(float %arg0)
  ret float %call
}

define float @ret_exp2_positive_source(i32 %arg) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp2_positive_source
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[UITOFP:%.*]] = uitofp i32 [[ARG]] to float
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[UITOFP]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %uitofp = uitofp i32 %arg to float
  %call = call float @llvm.exp2.f32(float %uitofp)
  ret float %call
}

; Could produce a nan because we don't know if the multiply is negative.
define float @ret_exp2_unknown_sign(float nofpclass(nan) %arg0, float nofpclass(nan) %arg1) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp2_unknown_sign
; CHECK-SAME: (float nofpclass(nan ninf nzero nsub nnorm) [[ARG0:%.*]], float nofpclass(nan ninf nzero nsub nnorm) [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[UNKNOWN_SIGN_NOT_NAN:%.*]] = fmul nnan float [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp2.f32(float [[UNKNOWN_SIGN_NOT_NAN]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %unknown.sign.not.nan = fmul nnan float %arg0, %arg1
  %call = call float @llvm.exp2.f32(float %unknown.sign.not.nan)
  ret float %call
}

define float @ret_exp10(float %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp10
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_noinf(float nofpclass(inf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp10_noinf
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_nopinf(float nofpclass(pinf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp10_nopinf
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_noninf(float nofpclass(ninf) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp10_noninf
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_nonan(float nofpclass(nan) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp10_nonan
; CHECK-SAME: (float nofpclass(nan ninf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_nonan_noinf(float nofpclass(nan inf) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp10_nonan_noinf
; CHECK-SAME: (float nofpclass(nan inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_nonan_noinf_nozero(float nofpclass(nan inf zero) %arg0) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp10_nonan_noinf_nozero
; CHECK-SAME: (float nofpclass(nan inf zero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_noinf_nozero(float nofpclass(inf zero) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp10_noinf_nozero
; CHECK-SAME: (float nofpclass(inf zero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_noinf_nonegzero(float nofpclass(inf nzero) %arg0) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_exp10_noinf_nonegzero
; CHECK-SAME: (float nofpclass(inf nzero nsub nnorm) [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[ARG0]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.exp10.f32(float %arg0)
  ret float %call
}

define float @ret_exp10_positive_source(i32 %arg) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp10_positive_source
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[UITOFP:%.*]] = uitofp i32 [[ARG]] to float
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[UITOFP]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %uitofp = uitofp i32 %arg to float
  %call = call float @llvm.exp10.f32(float %uitofp)
  ret float %call
}

; Could produce a nan because we don't know if the multiply is negative.
define float @ret_exp10_unknown_sign(float nofpclass(nan) %arg0, float nofpclass(nan) %arg1) {
; CHECK-LABEL: define nofpclass(nan ninf nzero nsub nnorm) float @ret_exp10_unknown_sign
; CHECK-SAME: (float nofpclass(nan ninf nzero nsub nnorm) [[ARG0:%.*]], float nofpclass(nan ninf nzero nsub nnorm) [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[UNKNOWN_SIGN_NOT_NAN:%.*]] = fmul nnan float [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(nan ninf nzero nsub nnorm) float @llvm.exp10.f32(float [[UNKNOWN_SIGN_NOT_NAN]]) #[[ATTR2]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %unknown.sign.not.nan = fmul nnan float %arg0, %arg1
  %call = call float @llvm.exp10.f32(float %unknown.sign.not.nan)
  ret float %call
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; TUNIT: {{.*}}
