package com.realman.becore.controller.api.services.models;

import java.util.List;
import com.realman.becore.dto.branch.service.BranchService;

public record ShopServiceResponse(
    String name,
    String description,
    List<BranchService> branchServiceList
) {
    
}
