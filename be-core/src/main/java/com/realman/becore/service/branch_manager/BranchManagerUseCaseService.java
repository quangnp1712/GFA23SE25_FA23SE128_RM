package com.realman.becore.service.branch_manager;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.branch_manager.BranchManager;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchManagerUseCaseService {
    @NonNull
    private final BranchManagerCommandService branchManagerCommandService;
    @NonNull
    private final BranchManagerQueryService branchManagerQueryService;

    @Transactional
    public Long save(BranchManager branchManager) {
        return branchManagerCommandService.save(branchManager);
    }

    @Transactional
    public void updateAccountId(Long managerId, Long accountId) {
        branchManagerCommandService.updateAccountId(managerId, accountId);
    }

    public BranchManager findByAccountId(Long accountId) {
        return branchManagerQueryService.findByAccountId(accountId);
    }
}
