package com.realman.becore.controller.api.branch.models;

import java.time.LocalTime;
import java.util.List;

import lombok.Builder;

@Builder
public record BranchSearchCriteria(
        LocalTime from,
        LocalTime to,
        Double originLat,
        Double originLng,
        Long distance,
        List<String> searches) {

    // public static BranchSearchCriteria from(List<LocalTime> timeRanges, Double
    // originLat, Double originLng,
    // List<String> searches) {
    // BranchSearchCriteriaBuilder builder = BranchSearchCriteria.builder();
    // if (!timeRanges.isEmpty()) {
    // List<LocalTime> sortedTimeRanges = timeRanges.stream()
    // .sorted().toList();
    // builder.from(sortedTimeRanges.get(0)).to(sortedTimeRanges.get(1));
    // }

    // return
    // builder.originLat(originLat).originLng(originLng).searches(searches).build();
    // }
    public static BranchSearchCriteria from(List<LocalTime> timeRanges,
            List<String> searches) {
        BranchSearchCriteriaBuilder builder = BranchSearchCriteria.builder();
        if (!timeRanges.isEmpty()) {
            List<LocalTime> sortedTimeRanges = timeRanges.stream()
                    .sorted().toList();
            builder.from(sortedTimeRanges.get(0)).to(sortedTimeRanges.get(1));
        }

        return builder.searches(searches).build();
    }
}
