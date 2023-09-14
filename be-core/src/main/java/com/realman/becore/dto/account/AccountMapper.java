package com.realman.becore.dto.account;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import com.realman.becore.repository.database.account.AccountEntity;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface AccountMapper {
    Account toDto(AccountEntity accountEntity);

    AccountEntity toEntity(Account account);
}
