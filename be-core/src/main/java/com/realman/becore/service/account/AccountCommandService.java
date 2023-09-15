package com.realman.becore.service.account;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.enums.ERole;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.repository.database.customer.CustomerEntity;
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

    @Transactional
    public void createAccountCustomer(Account account) {
        AccountEntity entity = accountMapper.toEntity(account);
        CustomerEntity customerEntity = new CustomerEntity();
        entity.setRole(ERole.CUSTOMER);
        Long customerId = customerUserCaseService.save(customerMapper.toDto(customerEntity));
        entity.setCustomerId(customerId);
        AccountEntity saveEntity = accountRepository.save(entity);
        customerUserCaseService.updateAccountId(customerId, saveEntity.getAccountId());
    }
}
