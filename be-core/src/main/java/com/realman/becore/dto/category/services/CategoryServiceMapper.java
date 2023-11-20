package com.realman.becore.dto.category.services;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.category.Category;
import com.realman.becore.repository.database.category.CategoryEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CategoryServiceMapper {
    CategoryEntity toEntity(Category dto);

    Category toDto(CategoryServiceInfo info);
}
