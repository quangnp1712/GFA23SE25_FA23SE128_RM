package com.realman.becore.dto.category;

import com.realman.becore.dto.enums.ECategory;
import com.realman.becore.dto.service.ShopService;

import lombok.Builder;

import java.util.List;

@Builder
public record Category(
    Long categoryId,
    ECategory title,
    List<ShopService> serviceList
) {
    
}
