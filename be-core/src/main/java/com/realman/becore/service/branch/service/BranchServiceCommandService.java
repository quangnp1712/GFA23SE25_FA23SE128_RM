package com.realman.becore.service.branch.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.realman.becore.dto.branch.service.BranchService;
import com.realman.becore.repository.database.branch.service.BranchServiceEntity;
import com.realman.becore.repository.database.branch.service.BranchServiceRepository;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchServiceCommandService {
    @NonNull
    private final BranchServiceRepository branchServiceRepository;

    public void save(Long branchId, List<BranchService> branchServices) {
        List<BranchServiceEntity> entityList = branchServices.stream()
                .map(branchService -> BranchServiceEntity.builder()
                        .branchId(branchId)
                        .serviceId(branchService.serviceId())
                        .price(branchService.price())
                        .build())
                .toList();
        branchServiceRepository.saveAll(entityList);
    }
}
