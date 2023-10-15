package com.realman.becore.controller.api.account.auth;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.account.models.AccountModelMapper;
import com.realman.becore.controller.api.account.models.AccountRequest;
import com.realman.becore.controller.api.branch.models.BranchId;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.enums.EProfessional;
import com.realman.becore.dto.enums.ERole;
import com.realman.becore.service.account.AccountUseCaseService;

import jakarta.validation.Valid;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AccountsAuthController implements AccountsAuthAPI {
    @NonNull
    private final AccountUseCaseService accountUseCaseService;

    @NonNull
    private final AccountModelMapper accountModelMapper;

    @Override
    public void saveStaff(@Valid AccountRequest account, EProfessional professional,
            Long branchId) {
        Account dto = accountModelMapper.toDto(account.format(), ERole.STAFF);
        accountUseCaseService.saveStaff(dto, new BranchId(branchId), professional);
    }

    @Override
    public void saveManager(@Valid AccountRequest account, Long branchId) {
        Account dto = accountModelMapper
                .toDto(account.format(), ERole.BRANCH_MANAGER);
        accountUseCaseService.save(dto, new BranchId(branchId));
    }

}
