package com.realman.becore.service.branch.display;

import java.util.List;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.branch.display.BranchDisplayMapper;
import com.realman.becore.repository.database.branch.display.BranchDisplayEntity;
import com.realman.becore.repository.database.branch.display.BranchDisplayRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchDisplayCommandService {

    @NonNull
    private final BranchDisplayRepository branchDisplayRepository;

    @NonNull
    private final BranchDisplayMapper branchDisplayMapper;

    public void saveOrUpdate(List<String> displayUrlList, Long branchId,
            Boolean isUpdate) {
        if (isUpdate) {
            List<BranchDisplayEntity> entityList = branchDisplayRepository
                    .findAllByBranchId(branchId);
            branchDisplayRepository.deleteAll(entityList);
        }
        List<BranchDisplayEntity> entityList = displayUrlList.stream()
                .map(display -> BranchDisplayEntity
                        .builder()
                        .branchId(branchId)
                        .url(display)
                        .build())
                .toList();
        branchDisplayRepository.saveAll(entityList);
    }

    public void delete(Long branchId) {
        List<BranchDisplayEntity> entityList = branchDisplayRepository
                .findAllByBranchId(branchId);
        branchDisplayRepository.deleteAll(entityList);
    }
}
