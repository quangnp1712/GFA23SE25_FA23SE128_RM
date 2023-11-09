package com.realman.becore.service.branch.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.branch.service.BranchService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchServiceUseCaseService {
    @NonNull
    private final BranchServiceCommandService branchServiceCommandService;

    @Transactional
    public void save(Long branchId, List<BranchService> branchService) {
        branchServiceCommandService.save(branchId, branchService);
    }
}
