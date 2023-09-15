package com.realman.becore.controller.account;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.account.models.AccountRequest;

import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/v1/account")
@Tag(name = "Account")
public interface AccountApi {
    @PostMapping
    void createCustomerAccount(@RequestBody AccountRequest accountRequest);
}
