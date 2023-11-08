package com.realman.becore.dto.service;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.enums.EServiceStatus;
import com.realman.becore.repository.database.service.ShopServiceEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ShopServiceMapper {
    @Mapping(source = "status", target = "status")
    ShopServiceEntity toEntity(ShopService dto, EServiceStatus status);
}
