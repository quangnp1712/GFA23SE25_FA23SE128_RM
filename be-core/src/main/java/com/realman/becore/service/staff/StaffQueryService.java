package com.realman.becore.service.staff;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.schedule.Schedule;
import com.realman.becore.dto.staff.Staff;
import com.realman.becore.dto.staff.StaffMapper;
import com.realman.becore.repository.database.staff.StaffEntity;
import com.realman.becore.repository.database.staff.StaffRepository;
import com.realman.becore.service.schedule.ScheduleQueryService;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StaffQueryService {
    @NonNull
    private final StaffRepository staffRepository;
    @NonNull
    private final ScheduleQueryService scheduleQueryService;
    @NonNull
    private final StaffMapper staffMapper;

    public Staff findByAccountId(Long accountId) {
        StaffEntity staffEntity = staffRepository.findByAccountId(accountId)
                .orElse(null);
        List<Schedule> scheduleList = Objects.nonNull(staffEntity)
                ? scheduleQueryService.findById(staffEntity.getStaffId())
                : new ArrayList<>();
        return staffMapper.toDto(staffEntity, scheduleList);
    }
}
