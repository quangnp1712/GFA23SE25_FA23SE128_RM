package com.realman.becore.controller.api.account.auth;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.realman.becore.controller.api.account.models.AccountRequest;
import com.realman.becore.dto.enums.EProfessional;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;

@Tag(name = "Account", description = "manage account by owner API")
@PreAuthorize("hasRole('ROLE_OWNER')")
@RequestMapping("/v1/auth/account")
public interface AccountsAuthAPI {
    @PostMapping("/staff")
    void saveStaff(
            @RequestBody @Valid AccountRequest account,
            @RequestParam(required = false, value = "professional", defaultValue = "STYLIST") EProfessional professional,
            @RequestParam(required = true, value = "branchId") Long branchId);

    @PostMapping("/manager")
    void saveManager(
            @RequestBody @Valid AccountRequest account,
            @RequestParam(required = true, value = "branchId") Long branchId);
}
