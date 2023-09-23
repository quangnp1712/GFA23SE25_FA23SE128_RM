package com.realman.becore.controller.api.account;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.account.models.AccountModelMapper;
import com.realman.becore.controller.api.account.models.AccountRequest;
import com.realman.becore.controller.api.account.models.ERoleRequest;
import com.realman.becore.controller.api.account.models.LoginRequest;
import com.realman.becore.controller.api.account.models.LoginResponse;
import com.realman.becore.service.account.AccountUseCaseService;
import com.realman.becore.util.ValueResponse;

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
    public void createCustomerAccount(AccountRequest accountRequest, ERoleRequest roleRequest) {
        accountUseCaseService.save(accountModelMapper.toDto(accountRequest.toAccountRequest()), roleRequest);
    }

    @Override
    public ValueResponse<LoginResponse> login(LoginRequest loginRequest) {
        return new ValueResponse<LoginResponse>(accountUseCaseService.login(loginRequest));
    }
}
