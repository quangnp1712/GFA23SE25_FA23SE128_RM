package com.realman.becore.repository.database.branch_service;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Embeddable
@NoArgsConstructor
public class BranchServiceId {
    private Long branchId;
    private Long serviceId;
}
