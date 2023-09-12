package com.realman.becore.dto.account;

import org.mapstruct.Mapper;

import com.realman.becore.repository.database.account.AccountEntity;

@Mapper
public interface AccountMapper {
    Account toDto(AccountEntity accountEntity);
}
