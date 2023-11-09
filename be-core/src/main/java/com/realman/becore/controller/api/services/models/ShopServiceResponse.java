package com.realman.becore.controller.api.services.models;

import java.util.List;

import com.realman.becore.dto.branch.Branch;

public record ShopServiceResponse(
    String name,
    String description,
    Long price,
    List<Branch> branchList
) {
    
}
