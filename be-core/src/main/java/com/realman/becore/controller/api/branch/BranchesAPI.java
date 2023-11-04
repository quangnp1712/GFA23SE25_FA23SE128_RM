package com.realman.becore.controller.api.branch;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.realman.becore.controller.api.branch.models.BranchRequest;
import com.realman.becore.controller.api.branch.models.BranchResponse;
import com.realman.becore.util.response.PageImplResponse;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;

@Tag(name = "Branch", description = "manage branch API")
@RequestMapping("/v1/branches")
@PreAuthorize("hasAnyAuthority({'branch:add', 'branch:view'})")
public interface BranchesAPI {
    @PostMapping
    public void save(@RequestBody @Valid BranchRequest branch);

    @GetMapping
    PageImplResponse<BranchResponse> findAll(
            @RequestParam(required = false, value = "timeRanges") @DateTimeFormat(pattern = "HH:mm:ss") List<LocalDateTime> timeRanges,
            @RequestParam(required = false, value = "search", defaultValue = "") String search,
            @RequestParam(required = false, value = "isSortByDistance", defaultValue = "false") Boolean isSortByDistance,
            @RequestParam(required = false, value = "originLat") Double originLat,
            @RequestParam(required = false, value = "originLng") Double originLng,
            @RequestParam(required = false, value = "current", defaultValue = "1") @Min(1) Integer current,
            @RequestParam(required = false, value = "sorter", defaultValue = "createdAt") String sorter,
            @RequestParam(required = false, value = "pageSize", defaultValue = "20") Integer pageSize);
}
