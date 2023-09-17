package com.realman.becore.service.account;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.branch_manager.BranchManagerMapper;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.dto.receptionist.ReceptionistMapper;
import com.realman.becore.dto.shop_owner.ShopOwnerMapper;
import com.realman.becore.dto.staff.StaffMapper;
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
    public void save(Account account) {
        accountQueryService.verifyAccount(account);
        AccountEntity entity = accountMapper.toEntity(account);
        switch (account.role()) {
            case CUSTOMER:
                Long customerId = customerUserCaseService.save(customerMapper.toDto(new CustomerEntity()));
                entity.setCustomerId(customerId);
                AccountEntity customerAccount = accountRepository.save(entity);
                customerUserCaseService.updateAccountId(customerId, customerAccount.getAccountId());
                break;
            case STAFF_MESSEUR:
            case STAFF_STYLIST:
                Long staffId = staffUsercaseService.save(staffMapper.toDto(new StaffEntity()));
                entity.setStaffId(staffId);
                AccountEntity staffAccount = accountRepository.save(entity);
                staffUsercaseService.updateAccountId(staffId, staffAccount.getAccountId());
                break;
            case BRANCH_MANAGER:
                Long managerId = branchManagerUserCaseService
                        .save(branchManagerMapper.toDto(new BranchManagerEntity()));
                entity.setBranchManagerId(managerId);
                AccountEntity managerAccount = accountRepository.save(entity);
                branchManagerUserCaseService.updateAccountId(managerId, managerAccount.getAccountId());
                break;
            case SHOP_OWNER:
                Long shopOwnerId = shopOwnerUserCaseService.save(shopOwnerMapper.toDto(new ShopOwnerEntity()));
                entity.setShopOwnerId(shopOwnerId);
                AccountEntity shopOwnerAccount = accountRepository.save(entity);
                shopOwnerUserCaseService.updateAccountId(shopOwnerId, shopOwnerAccount.getAccountId());
                break;
            case RECEPTIONIST:
                Long receptId = receptionistUseCaseService.save(receptionistMapper.toDto(new ReceptionistEntity()));
                entity.setReceptionistId(receptId);
                AccountEntity receptAccount = accountRepository.save(entity);
                receptionistUseCaseService.updateAccountId(receptId, receptAccount.getAccountId());
                break;
        }
    }
}
