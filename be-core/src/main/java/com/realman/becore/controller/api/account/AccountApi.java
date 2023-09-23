package com.realman.becore.controller.api.account;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.account.models.AccountRequest;
import com.realman.becore.controller.api.account.models.ERoleRequest;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/v1/account")
@Tag(name = "Account")
public interface AccountApi {
    @PostMapping("/{roleRequest}")
    void createCustomerAccount(@RequestBody AccountRequest accountRequest,
            @RequestParam(required = true, value = "otpId") Long otpId, @PathVariable ERoleRequest roleRequest);

}
