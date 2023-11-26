package com.realman.becore.dto.service;

import java.util.List;
import com.realman.becore.dto.branch.service.BranchService;
import com.realman.becore.dto.enums.EServiceStatus;
import com.realman.becore.dto.service.display.ServiceDisplay;

import lombok.Builder;

@Builder
public record ShopService(
    Long serviceId,
    Long categoryId,
    String name,
    String serviceDescription,
    Integer duration,
    EServiceStatus status,
    List<ServiceDisplay> serviceDisplayList,
    List<BranchService> branchServiceList
) {
    
}
