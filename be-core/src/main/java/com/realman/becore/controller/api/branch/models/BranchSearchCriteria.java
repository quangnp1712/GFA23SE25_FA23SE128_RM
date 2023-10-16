package com.realman.becore.controller.api.branch.models;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Builder;

@Builder
public record BranchSearchCriteria(
        LocalDateTime from,
        LocalDateTime to,
        List<String> searches) {

    public static BranchSearchCriteria from(List<LocalDateTime> timeRanges,
            List<String> searches) {
        BranchSearchCriteriaBuilder builder = BranchSearchCriteria.builder();
        if (!timeRanges.isEmpty()) {
            List<LocalDateTime> sortedTimeRanges = timeRanges.stream().sorted().toList();
            builder.from(sortedTimeRanges.get(0)).to(sortedTimeRanges.get(1));
        }

        return builder.searches(searches).build();
    }
}
