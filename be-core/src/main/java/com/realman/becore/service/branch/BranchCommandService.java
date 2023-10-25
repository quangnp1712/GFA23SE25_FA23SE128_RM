package com.realman.becore.service.branch;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.branch.models.BranchId;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchMapper;
import com.realman.becore.dto.place.detail.PlaceDetailRequest;
import com.realman.becore.dto.place.detail.PlaceDetailResponse;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.branch.BranchRepository;
import com.realman.becore.service.branch.display.BranchDisplayCommandService;
import com.realman.becore.service.place.detail.PlaceDetailUseCaseService;

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
    private final PlaceDetailUseCaseService placeDetailUseCaseService;

    @NonNull
    private final BranchMapper branchMapper;

    public void save(Branch branch) {
        PlaceDetailRequest request = PlaceDetailRequest.builder()
                .placeId(branch.placeId()).build();
        PlaceDetailResponse placeDetail = placeDetailUseCaseService
                .requestPlaceDetail(request);
        BranchEntity entity = branchMapper.toEntity(
                branch,
                placeDetail.result().geometry().location().lat(),
                placeDetail.result().geometry().location().lng());
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
                savedEntity.getBranchId(), true);
    }

    public void delete(BranchId branchId) {
        branchRepository.deleteById(branchId.value());
        branchDisplayCommandService.delete(branchId.value());
    }
}
