package com.realman.becore.dto.category.services;
import com.realman.becore.dto.enums.EServiceStatus;

public record CategoryService(
    Long categoryServiceId,
    Long categoryId,
    Long serviceId,
    String title,
    String name,
    Integer duration,
    EServiceStatus status
) {
}
