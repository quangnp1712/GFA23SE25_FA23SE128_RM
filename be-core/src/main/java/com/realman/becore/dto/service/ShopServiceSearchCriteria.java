package com.realman.becore.dto.service;

import com.realman.becore.dto.enums.EProfessional;
import java.util.Objects;
import lombok.Builder;

@Builder
public record ShopServiceSearchCriteria(
        String search,
        String professional) {

    public static ShopServiceSearchCriteria of(String search, EProfessional professional) {
        return ShopServiceSearchCriteria.builder()
                .search(search)
                .professional(Objects.nonNull(professional) ? professional.name() : "")
                .build();
    }

    public ShopServiceSearchCriteria toLowerCase() {
        return ShopServiceSearchCriteria.builder()
                .search(search.toLowerCase())
                .professional(professional.toLowerCase())
                .build();
    }

    public Boolean hasSearchEmpty() {
        return Objects.isNull(search) || search.isEmpty();
    }

    public Boolean hasProfessionalEmpty() {
        return Objects.isNull(professional) || professional.isEmpty();
    }
}
