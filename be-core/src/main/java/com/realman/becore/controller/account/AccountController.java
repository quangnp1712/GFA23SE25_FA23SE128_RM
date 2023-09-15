package com.realman.becore.controller.account;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.account.models.AccountModelMapper;
import com.realman.becore.controller.account.models.AccountRequest;
import com.realman.becore.service.account.AccountUseCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AccountController implements AccountApi {
    @NonNull
    final AccountUseCaseService accountUseCaseService;
    @NonNull
    final AccountModelMapper accountModelMapper;

    @Override
    public void createCustomerAccount(AccountRequest accountRequest) {
        accountUseCaseService.createCustomerAccount(accountModelMapper.toDto(accountRequest));
    }
}
