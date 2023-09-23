package com.realman.becore.service.account;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.ERoleRequest;
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

    @Transactional
    public void save(Account account, Long otpId, ERoleRequest roleRequest) {
        accountCommandService.save(account, otpId, roleRequest);
    }

    public Account findAccountByUsername(String username) {
        return accountQueryService.findAccountByUsername(username);
    }

    public Account findAccountByPhone(String phone) {
        return accountQueryService.findAccountByPhone(phone);
    }
}
