package com.realman.becore.controller.api.services.models;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.realman.becore.dto.branch.service.BranchService;

public record ShopServiceResponse(
    String name,
    @JsonProperty(value = "description")
    String serviceDescription,
    List<BranchService> branchServiceList
) {
    
}
