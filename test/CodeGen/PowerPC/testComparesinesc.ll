; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

@glob = common local_unnamed_addr global i8 0, align 1

define signext i32 @test_inesc(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: test_inesc:
; CHECK:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}

define signext i32 @test_inesc_sext(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: test_inesc_sext:
; CHECK:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define signext i32 @test_inesc_z(i8 signext %a) {
; CHECK-LABEL: test_inesc_z:
; CHECK:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, 0
  %conv1 = zext i1 %cmp to i32
  ret i32 %conv1
}

define signext i32 @test_inesc_sext_z(i8 signext %a) {
; CHECK-LABEL: test_inesc_sext_z:
; CHECK:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, 0
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define void @test_inesc_store(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: test_inesc_store:
; CHECK:    xor r3, r3, r4
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @glob, align 1
  ret void
}

define void @test_inesc_sext_store(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: test_inesc_sext_store:
; CHECK:    xor r3, r3, r4
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    neg r3, r3
; CHECK:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, i8* @glob, align 1
  ret void
}

define void @test_inesc_z_store(i8 signext %a) {
; CHECK-LABEL: test_inesc_z_store:
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, 0
  %conv2 = zext i1 %cmp to i8
  store i8 %conv2, i8* @glob, align 1
  ret void
}

define void @test_inesc_sext_z_store(i8 signext %a) {
; CHECK-LABEL: test_inesc_sext_z_store:
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    neg r3, r3
; CHECK:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, 0
  %conv2 = sext i1 %cmp to i8
  store i8 %conv2, i8* @glob, align 1
  ret void
}
