package com.realman.becore.controller.api.branch.models;

import java.time.LocalTime;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.branch.Branch;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BranchModelMapper {

    @Mapping(source = "open", target = "open")
    @Mapping(source = "close", target = "close")
    Branch toDto(BranchRequest request, LocalTime open, LocalTime close);

    BranchResponse toModel(Branch dto);

}
