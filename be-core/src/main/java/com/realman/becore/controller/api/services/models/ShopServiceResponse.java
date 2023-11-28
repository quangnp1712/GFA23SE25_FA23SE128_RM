package com.realman.becore.controller.api.services.models;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.realman.becore.dto.branch.service.BranchService;

public record ShopServiceResponse(
        Long serviceId,
        String name,
        @JsonProperty(value = "description") String serviceDescription,
        List<ServiceDisplayResponse> serviceDisplayList,
        List<BranchService> branchServiceList) {

}
