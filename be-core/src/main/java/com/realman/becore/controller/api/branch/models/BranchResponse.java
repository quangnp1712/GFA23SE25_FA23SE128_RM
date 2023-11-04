package com.realman.becore.controller.api.branch.models;

import java.time.LocalTime;
import java.util.List;

import com.realman.becore.dto.enums.EBranchStatus;

public record BranchResponse(
    Long branchId,
    Long shopOwnerId,
    String branchName,
    String phone,
    String address,
    EBranchStatus status,
    Integer numberStaffs,
    LocalTime open,
    LocalTime close,
    List<String> displayUrlList,
    List<Long> serviceIdList,
    String distanceKilometer
) {
    
}
