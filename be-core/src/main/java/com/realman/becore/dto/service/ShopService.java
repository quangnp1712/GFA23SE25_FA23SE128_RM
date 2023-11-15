package com.realman.becore.dto.service;

import java.util.List;
import com.realman.becore.dto.branch.service.BranchService;
import com.realman.becore.dto.enums.EServiceStatus;

import lombok.Builder;

@Builder
public record ShopService(
    Long serviceId,
    String name,
    String description,
    Integer duration,
    EServiceStatus status,
    List<BranchService> branchServiceList
) {
    
}
