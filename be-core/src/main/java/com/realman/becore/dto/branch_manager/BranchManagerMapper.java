package com.realman.becore.dto.branch_manager;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BranchManagerMapper {
    public BranchManager toDto(BranchManagerEntity entity);

    public BranchManagerEntity toEntity(BranchManager dto);
}
