package com.realman.becore.dto.avatar;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.avatar.AvatarEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AvatarMapper {
    AvatarEntity toEntity(Avatar dto);

    Avatar toDto(AvatarEntity entity);
}
