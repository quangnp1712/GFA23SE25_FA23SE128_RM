package com.realman.becore.dto.receptionist;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.receptionist.ReceptionistEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ReceptionistMapper {
    Receptionist toDto(ReceptionistEntity entity);

    ReceptionistEntity toEntity(Receptionist dto);
}
