package com.realman.becore.dto.service;

import java.util.List;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.enums.EServiceStatus;
import com.realman.becore.repository.database.service.ShopServiceEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ShopServiceMapper {
    @Mapping(source = "status", target = "status")
    ShopServiceEntity toEntity(ShopService dto, EServiceStatus status);

    ShopService toDto(ShopServiceEntity entity, List<Branch> branchList);

    ShopService toDto(ShopServiceEntity entity);
}
