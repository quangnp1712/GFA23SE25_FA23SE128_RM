package com.realman.becore.service.staff;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.staff.Staff;
import com.realman.becore.enums.EProfessional;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StaffUsecaseService {
    @NonNull
    private final StaffCommandService staffCommandService;
    @NonNull
    private final StaffQueryService staffQueryService;

    @Transactional
    public Long save(Staff staff, EProfessional professional) {
        return staffCommandService.save(staff, professional);
    }

    @Transactional
    public void updateAccountId(Long staffId, Long accountId) {
        staffCommandService.updateAccountId(staffId, accountId);
    }

    public Staff findByAccount(Long accountId) {
        return staffQueryService.findByAccountId(accountId);
    }
}
