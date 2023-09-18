package com.realman.becore.service.staff;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.staff.Staff;
import com.realman.becore.enums.EProfessional;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StaffUsercaseService {
    @NonNull
    private final StaffCommandService staffCommandService;

    public Long save(Staff staff, EProfessional professional) {
        return staffCommandService.save(staff, professional);
    }

    public void updateAccountId(Long staffId, Long accountId) {
        staffCommandService.updateAccountId(staffId, accountId);
    }
}
