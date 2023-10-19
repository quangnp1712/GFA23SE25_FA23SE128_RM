package com.realman.becore.service.branch;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.branch.models.BranchId;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.branch.BranchRepository;
import com.realman.becore.service.branch.display.BranchDisplayCommandService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchCommandService {

    @NonNull
    private final BranchRepository branchRepository;

    @NonNull
    private final BranchDisplayCommandService branchDisplayCommandService;

    @NonNull
    private final BranchMapper branchMapper;

    public void save(Branch branch) {
        BranchEntity entity = branchMapper.toEntity(branch);
        BranchEntity savedEntity = branchRepository.save(entity);
        branchDisplayCommandService.saveOrUpdate(branch.displayUrlList(),
                savedEntity.getBranchId(), false);
    }

    public void update(BranchId branchId, Branch branch) {
        BranchEntity foundEntity = branchRepository.findById(branchId.value())
                .orElseThrow(ResourceNotFoundException::new);
        branchMapper.updateEntity(foundEntity, branch);
        BranchEntity savedEntity = branchRepository.save(foundEntity);
        branchDisplayCommandService.saveOrUpdate(branch.displayUrlList(),
                savedEntity.getBranchId(),  true);
    }

    public void delete(BranchId branchId) {
        branchRepository.deleteById(branchId.value());
        branchDisplayCommandService.delete(branchId.value());
    }
}
