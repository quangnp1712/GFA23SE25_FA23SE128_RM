package com.realman.becore.controller.api.category.models;

import lombok.Builder;

@Builder
public record CategoryFieldResponse(
    Long categoryId,
    String title
) {
    
}
