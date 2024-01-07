package com.realman.becore.dto.service;

import java.util.Objects;
import lombok.Builder;

@Builder
public record ShopServiceSearchCriteria(String search) {

    public static ShopServiceSearchCriteria of(String search) {
        return ShopServiceSearchCriteria.builder()
                .search(search)
                .build();
    }

    public ShopServiceSearchCriteria toLowerCase() {
        return ShopServiceSearchCriteria.builder()
                .search(search.toLowerCase())
                .build();
    }

    public Boolean hasSearchEmpty() {
        return Objects.isNull(search) || search.isEmpty();
    }
}
