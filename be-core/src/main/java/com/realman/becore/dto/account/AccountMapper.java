package com.realman.becore.dto.account;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.account.AccountEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    Account toDto(AccountEntity accountEntity);

    AccountEntity toEntity(Account account);
}
