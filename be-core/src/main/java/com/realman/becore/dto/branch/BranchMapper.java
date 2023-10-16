package com.realman.becore.dto.branch;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.branch.BranchEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BranchMapper {
    
    BranchEntity toEntity(Branch dto);

    Branch toDto(BranchEntity entity);

    @Mapping(target = "branchId", ignore = true)
    void updateEntity(@MappingTarget BranchEntity entity, Branch dto);
}
