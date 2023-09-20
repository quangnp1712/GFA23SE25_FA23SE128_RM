package com.realman.becore.service.account;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceDuplicateException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountQueryService {
    @NonNull
    private final AccountRepository accountRepository;

    @NonNull
    private final AccountMapper accountMapper;

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
}
