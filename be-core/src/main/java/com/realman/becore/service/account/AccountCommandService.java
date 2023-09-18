package com.realman.becore.service.account;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.controller.account.models.ERoleRequest;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.branch_manager.BranchManagerMapper;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.dto.receptionist.ReceptionistMapper;
import com.realman.becore.dto.shop_owner.ShopOwnerMapper;
import com.realman.becore.dto.staff.StaffMapper;
import com.realman.becore.enums.EProfessional;
import com.realman.becore.enums.ERole;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;
import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.receptionist.ReceptionistEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerEntity;
import com.realman.becore.repository.database.staff.StaffEntity;
import com.realman.becore.service.branch_manager.BranchManagerUserCaseService;
import com.realman.becore.service.customer.CustomerUserCaseService;
import com.realman.becore.service.receptionist.ReceptionistUseCaseService;
import com.realman.becore.service.shop_owner.ShopOwnerUserCaseService;
import com.realman.becore.service.staff.StaffUsercaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountCommandService {
    @NonNull
    private final AccountRepository accountRepository;
    @NonNull
    private final CustomerUserCaseService customerUserCaseService;
    @NonNull
    private final StaffUsercaseService staffUsercaseService;
    @NonNull
    private final BranchManagerUserCaseService branchManagerUserCaseService;
    @NonNull
    private final ShopOwnerUserCaseService shopOwnerUserCaseService;
    @NonNull
    private final ReceptionistUseCaseService receptionistUseCaseService;
    @NonNull
    private final AccountQueryService accountQueryService;
    @NonNull
    private final AccountMapper accountMapper;
    @NonNull
    private final CustomerMapper customerMapper;
    @NonNull
    private final StaffMapper staffMapper;
    @NonNull
    private final BranchManagerMapper branchManagerMapper;
    @NonNull
    private final ShopOwnerMapper shopOwnerMapper;
    @NonNull
    private final ReceptionistMapper receptionistMapper;

    @Transactional
    public void save(Account account, ERoleRequest roleRequest) {
        accountQueryService.verifyAccount(account);

        switch (roleRequest) {
            case CUSTOMER:

                Long customerId = customerUserCaseService.save(customerMapper.toDto(new CustomerEntity()));
                AccountEntity customerAccountEntity = accountMapper.toCustomerEntity(account, ERole.CUSTOMER,
                        customerId);
                customerAccountEntity.setCustomerId(customerId);
                AccountEntity customerAccountSavedEntity = accountRepository.save(customerAccountEntity);
                customerUserCaseService.updateAccountId(customerId, customerAccountSavedEntity.getAccountId());
                break;
            case STAFF_MESSEUR:
                Long staffMesId = staffUsercaseService.save(staffMapper.toDto(new StaffEntity()),
                        EProfessional.MASSEUR);
                AccountEntity staffMesAccountEntity = accountMapper.toStaffEntity(account, ERole.STAFF, staffMesId);
                AccountEntity staffMesAccountSavedEntity = accountRepository.save(staffMesAccountEntity);
                staffUsercaseService.updateAccountId(staffMesId, staffMesAccountSavedEntity.getAccountId());
                break;
            case STAFF_STYLIST:
                Long staffStylId = staffUsercaseService.save(staffMapper.toDto(new StaffEntity()),
                        EProfessional.STYLIST);
                AccountEntity staffStylAccountEntity = accountMapper.toStaffEntity(account, ERole.STAFF, staffStylId);
                AccountEntity staffStylAccountSavedEntity = accountRepository.save(staffStylAccountEntity);
                staffUsercaseService.updateAccountId(staffStylId, staffStylAccountSavedEntity.getAccountId());
                break;
            case BRANCH_MANAGER:
                Long managerId = branchManagerUserCaseService
                        .save(branchManagerMapper.toDto(new BranchManagerEntity()));
                AccountEntity managerAccountEntity = accountMapper.toManagerEntity(account, ERole.BRANCH_MANAGER,
                        managerId);
                AccountEntity managerAccountSavedEntity = accountRepository.save(managerAccountEntity);
                branchManagerUserCaseService.updateAccountId(managerId, managerAccountSavedEntity.getAccountId());
                break;
            case SHOP_OWNER:
                Long shopOwnerId = shopOwnerUserCaseService.save(shopOwnerMapper.toDto(new ShopOwnerEntity()));
                AccountEntity shopOwnerAccountEntity = accountMapper.toShopOwnerEntity(account, ERole.SHOP_OWNER,
                        shopOwnerId);
                AccountEntity shopOwnerAccountSavedEntity = accountRepository.save(shopOwnerAccountEntity);
                shopOwnerUserCaseService.updateAccountId(shopOwnerId, shopOwnerAccountSavedEntity.getAccountId());
                break;
            case RECEPTIONIST:
                Long receptId = receptionistUseCaseService.save(receptionistMapper.toDto(new ReceptionistEntity()));
                AccountEntity receptAccountEntity = accountMapper.toReceptEntity(account, ERole.RECEPTIONIST, receptId);
                AccountEntity receptAccountSavedEntity = accountRepository.save(receptAccountEntity);
                receptionistUseCaseService.updateAccountId(receptId, receptAccountSavedEntity.getAccountId());
                break;
        }
    }

}
