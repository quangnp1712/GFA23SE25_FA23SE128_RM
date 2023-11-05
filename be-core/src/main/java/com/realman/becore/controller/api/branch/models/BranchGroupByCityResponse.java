package com.realman.becore.controller.api.branch.models;

import java.util.List;

public record BranchGroupByCityResponse(
    String city,
    List<BranchResponse> branches
) {
    
}
