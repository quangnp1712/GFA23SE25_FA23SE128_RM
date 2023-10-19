package com.realman.becore.service.branch;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.branch.models.BranchId;
import com.realman.becore.controller.api.branch.models.BranchSearchCriteria;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchMapper;
import com.realman.becore.dto.branch.display.BranchDisplay;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.branch.BranchRepository;
import com.realman.becore.service.branch.display.BranchDisplayQueryService;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchQueryService {
        @NonNull
        private final BranchRepository branchRepository;

        @NonNull
        private final BranchDisplayQueryService branchDisplayQueryService;

        @NonNull
        private final BranchMapper branchMapper;

        public Branch findById(BranchId branchId) {
                BranchEntity entity = branchRepository.findById(branchId.value())
                                .orElseThrow(ResourceNotFoundException::new);
                List<BranchDisplay> branchDisplayList = branchDisplayQueryService
                                .findAll(branchId.value());
                List<String> displayUrlList = branchDisplayList.stream()
                                .map(BranchDisplay::url).toList();
                return branchMapper.toDto(entity, displayUrlList);
        }

        public Page<Branch> findAll(BranchSearchCriteria criteria, PageRequestCustom pageRequestCustom) {
                Page<BranchEntity> entities = branchRepository.findAll(criteria.from(), criteria.to(),
                                criteria.searches(),
                                pageRequestCustom.pageRequest());
                Map<Long, List<BranchDisplay>> branchDisplayMap = branchDisplayQueryService
                                .findAll().stream()
                                .collect(Collectors.groupingBy(BranchDisplay::branchId));
                return entities.map(entity -> {
                        List<BranchDisplay> branchDisplayList = branchDisplayMap
                                        .get(entity.getBranchId());
                        List<String> branchUrlList = branchDisplayList.stream()
                                        .map(BranchDisplay::url).toList();
                        return branchMapper.toDto(entity, branchUrlList);
                });
        }
}
