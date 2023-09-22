package com.realman.becore.service.account;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.ERoleRequest;
import com.realman.becore.controller.api.account.models.LoginRequest;
import com.realman.becore.controller.api.account.models.LoginResponse;
import com.realman.becore.dto.account.Account;

import jakarta.transaction.Transactional;
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

    @Transactional
    public void save(Account account, ERoleRequest roleRequest) {
        accountCommandService.save(account, roleRequest);
    }

    public Account findAccountByUsername(String username) {
        return accountQueryService.findAccountByUsername(username);
    }

    public Account findAccountByPhone(String phone) {
        return accountQueryService.findAccountByPhone(phone);
    }

    public LoginResponse login(LoginRequest loginRequest) {
        return accountQueryService.login(loginRequest);
    }
}
