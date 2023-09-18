package com.realman.becore.dto.account;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.enums.ERole;
import com.realman.becore.repository.database.account.AccountEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    Account toDto(AccountEntity accountEntity);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "customerId", target = "customerId")
    AccountEntity toCustomerEntity(Account account, ERole role, Long customerId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "staffId", target = "staffId")
    AccountEntity toStaffEntity(Account account, ERole role, Long staffId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "receptId", target = "receptionistId")
    AccountEntity toReceptEntity(Account account, ERole role, Long receptId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "managerId", target = "branchManagerId")
    AccountEntity toManagerEntity(Account account, ERole role, Long managerId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "shopOwnerId", target = "shopOwnerId")
    AccountEntity toShopOwnerEntity(Account account, ERole role, Long shopOwnerId);
}
