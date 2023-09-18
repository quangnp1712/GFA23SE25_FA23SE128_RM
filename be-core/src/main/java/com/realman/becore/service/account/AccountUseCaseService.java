package com.realman.becore.service.account;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.account.models.ERoleRequest;
import com.realman.becore.dto.account.Account;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountUseCaseService {
    @NonNull
    private final AccountQueryService accountQueryService;

    @NonNull
    private final AccountCommandService accountCommandService;

    @NonNull
    private final AutowireCapableBeanFactory autowireCapableBeanFactory;

    public Account findAccountByUsername(String username) {
        return accountQueryService.findAccountByUsername(username);
    }

    public void save(Account account, ERoleRequest roleRequest) {
        accountCommandService.save(account, roleRequest);
    }
}
