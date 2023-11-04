package com.realman.becore.dto.branch;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import lombok.Builder;

@Builder
public record BranchSearchCriteria(
        LocalTime from,
        LocalTime to,
        Double originLat,
        Double originLng,
        Boolean isSortByDistance,
        List<String> searches) {

    public static BranchSearchCriteria from(List<LocalDateTime> timeRanges, List<String> searches,
            Boolean isSortByDistance, Double originLat, Double originLng) {
        BranchSearchCriteriaBuilder builder = BranchSearchCriteria.builder();
        if (!timeRanges.isEmpty()) {
            List<LocalTime> sortedTimeRanges = timeRanges.stream().sorted().map(LocalDateTime::toLocalTime).toList();
            builder.from(sortedTimeRanges.get(0)).to(sortedTimeRanges.get(1));
        }

        return builder.originLat(originLat).originLng(originLng).searches(searches)
                .isSortByDistance(isSortByDistance).build();
    }

}
