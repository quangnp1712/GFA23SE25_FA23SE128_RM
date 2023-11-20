package com.realman.becore.service.schedule;

import java.util.List;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.schedule.Schedule;
import com.realman.becore.dto.schedule.ScheduleMapper;
import com.realman.becore.dto.staff.Staff;
import com.realman.becore.repository.database.schedule.ScheduleRepository;
import com.realman.becore.service.staff.StaffUsecaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleQueryService {
    @NonNull
    private final ScheduleRepository scheduleRepository;
    @NonNull
    private final ScheduleMapper scheduleMapper;
    @NonNull
    private final StaffUsecaseService staffUsecaseService;

    public List<Schedule> findByAccountId(Long accountId) {
        Staff staff = staffUsecaseService.findByAccount(accountId);
        List<Schedule> scheduleList = scheduleRepository.findInfoByStaffId(staff.staffId()).stream()
            .map(scheduleMapper::toDto).toList();
        return scheduleList;
    }
    
}
