package com.realman.becore.service.account;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.customer.Customer;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.repository.database.branch_manager.BranchManagerRepository;
import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerRepository;
import com.realman.becore.repository.database.staff.StaffRepository;
import com.realman.becore.service.customer.CustomerUserCaseService;

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
    private final AccountMapper accountMapper;
    @NonNull
    private final CustomerMapper customerMapper;

    public void createAccountCustomer(Account account) {
        AccountEntity accountEntity = accountMapper.toEntity(account);
        customerUserCaseService.save(customerMapper.toDto(new CustomerEntity()));
        
    }
}
