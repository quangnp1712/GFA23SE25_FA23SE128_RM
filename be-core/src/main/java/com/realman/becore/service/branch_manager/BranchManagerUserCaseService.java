package com.realman.becore.service.branch_manager;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.branch_manager.BranchManager;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchManagerUserCaseService {
    @NonNull
    private final BranchManagerCommandService branchManagerCommandService;

    public Long save(BranchManager branchManager) {
        return branchManagerCommandService.save(branchManager);
    }

    public void updateAccountId(Long managerId, Long accountId) {
        branchManagerCommandService.updateAccountId(managerId, accountId);
    }
}
