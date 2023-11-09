package com.realman.becore.dto.branch;

import lombok.Builder;

@Builder
public record BranchGroupByCitySearchCriteria(
    String city,
    Boolean isSortByDistance,
    Double lat,
    Double lng
) {
    
}
