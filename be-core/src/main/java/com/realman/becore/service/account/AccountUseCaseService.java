package com.realman.becore.service.account;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.controller.api.account.models.AccountId;
import com.realman.becore.controller.api.account.models.AccountRole;
import com.realman.becore.controller.api.otp.models.OTPId;
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

    @Transactional
    public void save(Account account, OTPId otpId, AccountRole roleRequest) {
        accountCommandService.save(account, otpId, roleRequest);
    }

    @Transactional
    public void update(AccountId accountId, Account account) {
        accountCommandService.update(accountId, account);
    }

    public Account findByUsername(String username) {
        return accountQueryService.findByUsername(username);
    }

    public Account findByPhone(String phone) {
        return accountQueryService.findByPhone(phone);
    }

    public Account findById(AccountId accountId) {
        return accountQueryService.findById(accountId);
    }
}
