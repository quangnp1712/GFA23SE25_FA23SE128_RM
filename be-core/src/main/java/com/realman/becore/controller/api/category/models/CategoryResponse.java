package com.realman.becore.controller.api.category.models;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.realman.becore.controller.api.services.models.ShopServiceResponse;

public record CategoryResponse(
    Long categoryId,
    String title,
    @JsonProperty(value = "description")
    String categoryDescription,
    List<ShopServiceResponse> serviceList
) {  
}
