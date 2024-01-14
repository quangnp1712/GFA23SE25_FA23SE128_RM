package com.realman.becore.dto.booking;

import lombok.Builder;
import java.util.Objects;

@Builder
public record BookingSearchCriteria(Long branchId) {
    Boolean hasBranchIdEmpty() {
        return Objects.isNull(branchId);
    }
}
