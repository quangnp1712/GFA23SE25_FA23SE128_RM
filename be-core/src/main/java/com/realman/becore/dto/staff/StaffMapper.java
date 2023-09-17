package com.realman.becore.dto.staff;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.staff.StaffEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface StaffMapper {
    Staff toDto(StaffEntity entity);

    StaffEntity toEntity(Staff dto);
}
