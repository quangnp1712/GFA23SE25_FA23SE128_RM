package com.realman.becore.controller.api.category.models;

import java.util.List;
import com.realman.becore.controller.api.services.models.ShopServiceResponse;
import com.realman.becore.dto.enums.ECategoryType;

public record CategoryResponse(
        Long categoryId,
        String name,
        ECategoryType categoryType,
        List<ShopServiceResponse> serviceList) {
}
