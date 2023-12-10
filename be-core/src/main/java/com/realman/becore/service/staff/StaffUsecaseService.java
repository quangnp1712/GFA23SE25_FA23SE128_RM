package com.realman.becore.service.staff;

import org.springframework.stereotype.Service;
import com.realman.becore.dto.staff.Staff;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StaffUsecaseService {
    @NonNull
    private final StaffCommandService staffCommandService;
    @NonNull
    private final StaffQueryService staffQueryService;

    public Staff findByAccountId(Long accountId, Boolean allowNull) {
        return staffQueryService.findByAccountId(accountId, allowNull);
    }

}
