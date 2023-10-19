package com.realman.becore.controller.api.branch.models;

import java.time.LocalDateTime;
import java.util.List;

import com.realman.becore.custom_constrain.phone.Phone;
import com.realman.becore.custom_constrain.text.NormalText;
import com.realman.becore.dto.enums.EBranchStatus;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;

public record BranchRequest(
        Long branchId,
        Long shopOwnerId,
        @NormalText String branchName,
        @Phone String phone,
        @NormalText String address,
        @Enumerated(EnumType.STRING) EBranchStatus status,
        Integer numberStaffs,
        LocalDateTime open,
        LocalDateTime close,
        List<String> displayUrlList,
        List<Long> serviceIdList) {

}
