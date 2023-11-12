package com.realman.becore.controller.api.services.models;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.service.ShopService;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ShopServiceModelMapper {
    ShopService toDto(ShopServiceRequest model);

    ShopServiceResponse toModel(ShopService dto);
}
