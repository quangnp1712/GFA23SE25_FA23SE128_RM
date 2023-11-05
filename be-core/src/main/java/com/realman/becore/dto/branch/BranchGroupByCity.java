package com.realman.becore.dto.branch;

import java.util.List;

import lombok.Builder;

@Builder
public record BranchGroupByCity(
    String city,
    List<Branch> branches
) {
    
}
