package com.realman.becore.service.account;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
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
                .orElseThrow(ResourceNotFoundException::new);
        return accountMapper.toDto(entity);
    }

}
