package com.realman.becore.dto.branch;

import java.time.LocalTime;
import java.util.List;

import com.realman.becore.dto.enums.EBranchStatus;

public record Branch(
    Long branchId,
    Long shopOwnerId,
    String branchName,
    String phone,
    String address,
    String placeId,
    EBranchStatus status,
    Integer numberStaffs,
    LocalTime open,
    LocalTime close,
    List<String> displayUrlList,
    List<Long> serviceIdList
) {
    
}
