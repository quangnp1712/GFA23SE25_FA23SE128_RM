package com.realman.becore.controller.api.category.models;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.category.Category;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CategoryModelMapper {
    CategoryResponse toModel(Category dto);

    CategoryFieldResponse toFieldModel(Category dto);

    Category toDto(CategoryRequest model);
}
