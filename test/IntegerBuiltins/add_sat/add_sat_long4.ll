
; RUN: clspv-opt -ReplaceOpenCLBuiltin %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by add_sat_test_gen.cpp.
; Please modify the that file and regenerate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

define <4 x i64> @add_sat_long4(<4 x i64> %a, <4 x i64> %b) {
entry:
 %call = call <4 x i64> @_Z7add_satDv4_lS_(<4 x i64> %a, <4 x i64> %b)
 ret <4 x i64> %call
}

declare <4 x i64> @_Z7add_satDv4_lS_(<4 x i64>, <4 x i64>)

; CHECK: [[add:%[a-zA-Z0-9_.]+]] = add <4 x i64> %a, %b
; CHECK: [[b_lt_0:%[a-zA-Z0-9_.]+]] = icmp slt <4 x i64> %b, zeroinitializer
; CHECK: [[add_gt_a:%[a-zA-Z0-9_.]+]] = icmp sgt <4 x i64> [[add]], %a
; CHECK: [[add_lt_a:%[a-zA-Z0-9_.]+]] = icmp slt <4 x i64> [[add]], %a
; CHECK: [[min_clamp:%[a-zA-Z0-9_.]+]] = select <4 x i1> [[add_gt_a]], <4 x i64> <i64 -9223372036854775808, i64 -9223372036854775808, i64 -9223372036854775808, i64 -9223372036854775808>, <4 x i64> [[add]]
; CHECK: [[max_clamp:%[a-zA-Z0-9_.]+]] = select <4 x i1> [[add_lt_a]], <4 x i64> <i64 9223372036854775807, i64 9223372036854775807, i64 9223372036854775807, i64 9223372036854775807>, <4 x i64> [[add]]
; CHECK: [[sel:%[a-zA-Z0-9_.]+]] = select <4 x i1> [[b_lt_0]], <4 x i64> [[min_clamp]], <4 x i64> [[max_clamp]]
; CHECK: ret <4 x i64> [[sel]]
