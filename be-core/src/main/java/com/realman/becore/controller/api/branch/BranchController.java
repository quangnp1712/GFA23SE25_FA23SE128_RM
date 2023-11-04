package com.realman.becore.controller.api.branch;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.branch.models.BranchModelMapper;
import com.realman.becore.controller.api.branch.models.BranchRequest;
import com.realman.becore.controller.api.branch.models.BranchResponse;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchId;
import com.realman.becore.service.branch.BranchUseCaseService;
import com.realman.becore.util.response.ValueResponse;

import jakarta.validation.Valid;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BranchController implements BranchAPI {

    @NonNull
    private final BranchUseCaseService branchUseCaseService;

    @NonNull
    private final BranchModelMapper branchModelMapper;

    @Override
    public void update(Long branchId, @Valid BranchRequest branch) {
        Branch dto = branchModelMapper.toDto(branch, branch.open().toLocalTime(),
                branch.close().toLocalTime());
        branchUseCaseService.update(new BranchId(branchId), dto);
    }

    @Override
    public ValueResponse<BranchResponse> findById(Long branchId) {
        Branch dto = branchUseCaseService.findById(new BranchId(branchId));
        BranchResponse response = branchModelMapper.toModel(dto);
        return new ValueResponse<BranchResponse>(response);
    }

}
