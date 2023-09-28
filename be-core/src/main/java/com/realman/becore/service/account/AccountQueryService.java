package com.realman.becore.service.account;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.AccountId;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.branch_manager.BranchManagerMapper;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.dto.receptionist.ReceptionistMapper;
import com.realman.becore.dto.shop_owner.ShopOwnerMapper;
import com.realman.becore.dto.staff.StaffMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceDuplicateException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;
import com.realman.becore.repository.database.branch_manager.BranchManagerRepository;
import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.customer.CustomerRepositoty;
import com.realman.becore.repository.database.receptionist.ReceptionistEntity;
import com.realman.becore.repository.database.receptionist.ReceptionistRepository;
import com.realman.becore.repository.database.shop_owner.ShopOwnerEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerRepository;
import com.realman.becore.repository.database.staff.StaffEntity;
import com.realman.becore.repository.database.staff.StaffRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountQueryService {
    @NonNull
    private final AccountRepository accountRepository;
    @NonNull
    private final CustomerRepositoty customerRepositoty;
    @NonNull
    private final StaffRepository staffRepository;
    @NonNull
    private final ReceptionistRepository receptionistRepository;
    @NonNull
    private final BranchManagerRepository branchManagerRepository;
    @NonNull
    private final ShopOwnerRepository shopOwnerRepository;
    @NonNull
    private final AccountMapper accountMapper;
    @NonNull
    private final CustomerMapper customerMapper;
    @NonNull
    private final StaffMapper staffMapper;
    @NonNull
    private final ReceptionistMapper receptionistMapper;
    @NonNull
    private final BranchManagerMapper branchManagerMapper;
    @NonNull
    private final ShopOwnerMapper shopOwnerMapper;

    public Account findAccountByUsername(String username) {
        AccountEntity entity = accountRepository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        return accountMapper.toDto(entity);
    }

    public Account findAccountByPhone(String phone) {
        AccountEntity entity = accountRepository.findByPhone(phone)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        return accountMapper.toDto(entity);
    }

    public void verifyAccount(Account account) {
        if (accountRepository.findByUsername(account.username()).isPresent()) {
            throw new ResourceDuplicateException(EErrorMessage.USERNAME_DUPLICATED.name());
        }

        if (accountRepository.findByPhone(account.phone()).isPresent()) {
            throw new ResourceDuplicateException(EErrorMessage.PHONE_DUPLICATED.name());
        }
    }

    public Account findCustomerAccount(AccountId accountId) {
        AccountEntity accountEntity = accountRepository.findById(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        CustomerEntity customerEntity = customerRepositoty.findByAccountId(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.CUSOMTER_NOT_FOUND.name()));
        return accountMapper.toCustomerDto(accountEntity, customerMapper.toDto(customerEntity));
    }

    public Account findStaffAccount(AccountId accountId) {
        AccountEntity accountEntity = accountRepository.findById(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        StaffEntity staffEntity = staffRepository.findByAccountId(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.STAFF_NOT_FOUND.name()));
        return accountMapper.toStaffDto(accountEntity, staffMapper.toDto(staffEntity));
    }

    public Account findReceptionistAccount(AccountId accountId) {
        AccountEntity accountEntity = accountRepository.findById(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        ReceptionistEntity receptionistEntity = receptionistRepository.findByAccountId(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.RECEPTIONIST_NOT_FOUND.name()));
        return accountMapper.toReceptDto(accountEntity, receptionistMapper.toDto(receptionistEntity));
    }

    public Account findBranchManagerAccount(AccountId accountId) {
        AccountEntity accountEntity = accountRepository.findById(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        BranchManagerEntity receptionistEntity = branchManagerRepository.findByAccountId(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.MANAGER_NOT_FOUND.name()));
        return accountMapper.toManagerDto(accountEntity, branchManagerMapper.toDto(receptionistEntity));
    }

    public Account findShopOwnerAccount(AccountId accountId) {
        AccountEntity accountEntity = accountRepository.findById(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        ShopOwnerEntity receptionistEntity = shopOwnerRepository.findByAccountId(accountId.value())
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.SHOPOWNER_NOT_FOUND.name()));
        return accountMapper.toShopOwnerDto(accountEntity, shopOwnerMapper.toDto(receptionistEntity));
    }

}
