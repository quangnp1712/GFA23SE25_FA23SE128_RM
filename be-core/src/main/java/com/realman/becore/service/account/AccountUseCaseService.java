package com.realman.becore.service.account;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.account.Account;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountUseCaseService {
    @NonNull
    private final AccountQueryService accountQueryService;

    public Account findAccountByUsername(String username) {
        return accountQueryService.findAccountByUsername(username);
    }
}
