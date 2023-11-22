package com.realman.becore.controller.api.category.models;

import java.util.List;

import com.realman.becore.controller.api.services.models.ShopServiceResponse;

public record CategoryResponse(
    Long categoryId,
    String title,
    List<ShopServiceResponse> serviceList
) {  
}
