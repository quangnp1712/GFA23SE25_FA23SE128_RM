package com.realman.becore.dto.category.services;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.category.services.CategoryServiceEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CategoryServiceMapper {
    CategoryServiceEntity toEntity(CategoryService dto);

    CategoryService toDto(CategoryServiceInfo info);
}
