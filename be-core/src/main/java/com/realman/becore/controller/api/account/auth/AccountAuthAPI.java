package com.realman.becore.controller.api.account.auth;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.realman.becore.controller.api.account.models.AccountResponse;
import com.realman.becore.util.response.ValueResponse;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Account", description = "manage account API")
@RequestMapping("/v1/auth/account/{accountId}")
@PreAuthorize("hasAuthority('account:view')")
public interface AccountAuthAPI {

    @GetMapping("/staff")
    ValueResponse<AccountResponse> findStaffAccount(@PathVariable Long accountId);

    @GetMapping("/manager")
    ValueResponse<AccountResponse> findManagerAccount(@PathVariable Long accountId);

    @GetMapping("/customer")
    ValueResponse<AccountResponse> findCustomerAccount(@PathVariable Long accountId);

    
}
