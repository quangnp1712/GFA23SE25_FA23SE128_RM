package com.realman.becore.controller.account.models;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import com.realman.becore.dto.account.Account;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface AccountModelMapper {
    Account toDto(AccountRequest accountRequest);
}
