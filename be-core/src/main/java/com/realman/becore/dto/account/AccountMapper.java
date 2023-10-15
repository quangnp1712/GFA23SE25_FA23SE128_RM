package com.realman.becore.dto.account;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.account.AccountEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    AccountEntity toEntity(Account account);

    @Mapping(source = "branchId", target = "branchId")
    AccountEntity toEntity(Account account, Long branchId);

    Account toDto(AccountEntity entity);

    Account fromInfo(AccountInfo info);
}
