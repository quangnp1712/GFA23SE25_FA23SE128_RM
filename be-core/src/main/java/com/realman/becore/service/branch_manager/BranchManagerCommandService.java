package com.realman.becore.service.branch_manager;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.branch_manager.BranchManager;
import com.realman.becore.dto.branch_manager.BranchManagerMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;
import com.realman.becore.repository.database.branch_manager.BranchManagerRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchManagerCommandService {
    @NonNull
    private final BranchManagerRepository branchManagerRepository;

    @NonNull
    private final BranchManagerMapper branchManagerMapper;

    @Transactional
    public Long save(BranchManager branchManager) {
        BranchManagerEntity entity = branchManagerRepository
                .save(branchManagerMapper.toEntity(new BranchManager()));
        return entity.getBranchManagerId();
    }

    @Transactional
    public void updateAccountId(Long managerId, Long accountId) {
        BranchManagerEntity entity = branchManagerRepository.findById(managerId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.MANAGER_NOT_FOUND.name()));
        entity.setAccountId(accountId);
        branchManagerRepository.save(entity);
    }
}
