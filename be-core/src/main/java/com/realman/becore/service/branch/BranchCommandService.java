package com.realman.becore.service.branch;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.branch.models.BranchId;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.branch.BranchRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchCommandService {
    @NonNull
    private final BranchRepository branchRepository;

    @NonNull
    private final BranchMapper branchMapper;

    public void save(Branch branch) {
        BranchEntity entity = branchMapper.toEntity(branch);
        branchRepository.save(entity);
    }

    public void update(BranchId branchId, Branch branch) {
        BranchEntity foundEntity = branchRepository.findById(branchId.value())
                .orElseThrow(ResourceNotFoundException::new);
        branchMapper.updateEntity(foundEntity, branch);
        branchRepository.save(foundEntity);
    }

    public void delete(BranchId branchId) {
        branchRepository.deleteById(branchId.value());
    }
}
