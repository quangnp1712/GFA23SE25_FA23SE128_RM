package com.realman.becore.dto.branch;

import com.realman.becore.dto.enums.EBranchStatus;

public record Branch(
    Long branchId,
    String address,
    EBranchStatus status,
    Integer currentStaffs,
    Integer totalStaffs,
    Long profit
) {
    
}
