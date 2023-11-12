package com.realman.becore.dto.branch.service;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BranchServiceMapper {
    BranchService toDto(BranchServiceInfo info);
}
