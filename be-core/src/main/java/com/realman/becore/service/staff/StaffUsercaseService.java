package com.realman.becore.service.staff;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.staff.Staff;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StaffUsercaseService {
    @NonNull
    private final StaffCommandService staffCommandService;

    public Long save(Staff staff) {
        return staffCommandService.save(staff);
    }

    public void updateAccountId(Long staffId, Long accountId) {
        staffCommandService.updateAccountId(staffId, accountId);
    }
}
