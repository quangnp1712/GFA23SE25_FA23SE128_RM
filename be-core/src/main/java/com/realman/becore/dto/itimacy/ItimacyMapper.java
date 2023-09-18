package com.realman.becore.dto.itimacy;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.itimacy.ItimacyEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ItimacyMapper {
    Itimacy toDto(ItimacyEntity entity);

    ItimacyEntity toEntity(Itimacy dto);
}
