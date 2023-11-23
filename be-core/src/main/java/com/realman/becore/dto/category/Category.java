package com.realman.becore.dto.category;

import com.realman.becore.dto.service.ShopService;
import lombok.Builder;
import java.util.List;

@Builder
public record Category(
    Long categoryId,
    String title,
    String categoryDescription,
    List<ShopService> serviceList
) {
}
