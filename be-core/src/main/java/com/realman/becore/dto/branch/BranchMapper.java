package com.realman.becore.dto.branch;

import java.util.List;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.branch.BranchEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BranchMapper {
    @Mapping(source = "lat", target = "lat")
    @Mapping(source = "lng", target = "lng")
    BranchEntity toEntity(Branch dto, String city, Double lat, Double lng);

    Branch toDto(BranchEntity entity, List<String> branchUrlList, Double distance);

    Branch toDto(BranchEntity entity, List<String> displayUrlList);

    @Mapping(source = "distanceKilometer", target = "distanceKilometer")
    Branch updateDto(Branch updateDto, String distanceKilometer);

    @Mapping(target = "branchId", ignore = true)
    void updateEntity(@MappingTarget BranchEntity entity, Branch dto);

}
