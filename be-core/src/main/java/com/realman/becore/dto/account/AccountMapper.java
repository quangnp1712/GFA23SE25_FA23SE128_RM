package com.realman.becore.dto.account;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.branch_manager.BranchManager;
import com.realman.becore.dto.customer.Customer;
import com.realman.becore.dto.receptionist.Receptionist;
import com.realman.becore.dto.shop_owner.ShopOwner;
import com.realman.becore.dto.staff.Staff;
import com.realman.becore.enums.ERole;
import com.realman.becore.repository.database.account.AccountEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    Account toDto(AccountEntity accountEntity);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "customerId", target = "customerId")
    AccountEntity toCustomerEntity(Account account, ERole role, Long customerId, Long otpId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "staffId", target = "staffId")
    AccountEntity toStaffEntity(Account account, ERole role, Long staffId, Long otpId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "receptId", target = "receptionistId")
    AccountEntity toReceptEntity(Account account, ERole role, Long receptId, Long otpId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "managerId", target = "branchManagerId")
    AccountEntity toManagerEntity(Account account, ERole role, Long managerId, Long otpId);

    @Mapping(source = "role", target = "role")
    @Mapping(source = "shopOwnerId", target = "shopOwnerId")
    AccountEntity toShopOwnerEntity(Account account, ERole role, Long shopOwnerId, Long otpId);

    Account toCustomerDto(AccountEntity entity, Customer customer);

    @Mapping(source = "entity.accountId", target = "accountId")
    Account toStaffDto(AccountEntity entity, Staff staff);

    @Mapping(source = "entity.accountId", target = "accountId")
    Account toReceptDto(AccountEntity entity, Receptionist receptionist);

    @Mapping(source = "entity.accountId", target = "accountId")
    Account toManagerDto(AccountEntity entity, BranchManager manager);

    @Mapping(source = "entity.accountId", target = "accountId")
    Account toShopOwnerDto(AccountEntity entity, ShopOwner shopOwner);
}
