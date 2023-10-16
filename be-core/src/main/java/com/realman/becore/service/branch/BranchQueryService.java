package com.realman.becore.service.branch;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.branch.models.BranchId;
import com.realman.becore.controller.api.branch.models.BranchSearchCriteria;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.branch.BranchRepository;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchQueryService {
    @NonNull
    private final BranchRepository branchRepository;

    @NonNull
    private final BranchMapper branchMapper;

    public Branch findById(BranchId branchId) {
        BranchEntity entity = branchRepository.findById(branchId.value())
                .orElseThrow(ResourceNotFoundException::new);
        return branchMapper.toDto(entity);
    }

    public Page<Branch> findAll(BranchSearchCriteria criteria, PageRequestCustom pageRequestCustom) {
        Page<BranchEntity> entities = branchRepository.findAll(criteria.from(), criteria.to(), criteria.searches(),
                pageRequestCustom.pageRequest());
        
        return entities.map(branchMapper::toDto);
    }
}
