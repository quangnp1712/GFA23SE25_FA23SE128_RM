package com.realman.becore.dto.account;

import java.util.List;
import java.util.Objects;
import com.realman.becore.dto.enums.ECategoryType;
import com.realman.becore.dto.enums.ERole;

import lombok.Builder;

@Builder
public record AccountSearchCriteria(
                List<String> searches,
                Long branchId,
                Boolean isShowDistance,
                Double lat,
                Double lng,
                ERole role,
                String category) {
        public Boolean hasSearchEmpty() {
                return searches.isEmpty();
        }

        public Boolean hasBranchIdEmpty() {
                return Objects.isNull(branchId);
        }

        public Boolean hasCategoryEmpty() {
                return Objects.isNull(category) || category.isEmpty();
        }

        public static AccountSearchCriteria of(List<String> searches, Long branchId, Boolean isShowDistance,
                        Double lat, Double lng, ERole role, ECategoryType category) {
                return AccountSearchCriteria.builder()
                                .searches(searches)
                                .branchId(branchId)
                                .isShowDistance(isShowDistance)
                                .lat(lat)
                                .lng(lng)
                                .role(role)
                                .category(Objects.nonNull(category) ? category.name() : "")
                                .build();
        }

        public AccountSearchCriteria toLowerCase() {
                return AccountSearchCriteria.builder()
                                .branchId(branchId)
                                .searches(searches.stream().map(String::toLowerCase).toList())
                                .isShowDistance(isShowDistance)
                                .lat(lat)
                                .lng(lng)
                                .role(role)
                                .category(category.toLowerCase())
                                .build();
        }
}
