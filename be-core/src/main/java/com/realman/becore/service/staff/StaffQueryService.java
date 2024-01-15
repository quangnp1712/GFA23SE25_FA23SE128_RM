package com.realman.becore.service.staff;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.schedule.Schedule;
import com.realman.becore.dto.staff.Staff;
import com.realman.becore.dto.staff.StaffMapper;
import com.realman.becore.dto.staff.booking.BookingStaff;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.staff.StaffEntity;
import com.realman.becore.repository.database.staff.StaffRepository;
import com.realman.becore.service.booking.BookingUseCaseService;
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
    @NonNull
    private final BookingUseCaseService bookingUseCaseService;

    public Staff findByAccountId(Long accountId) {
        Optional<StaffEntity> staffEntity = staffRepository.findByAccountId(accountId);
        if (staffEntity.isPresent()) {
            StaffEntity staff = staffEntity.get();
            List<BookingStaff> bookings = bookingUseCaseService.findByStaffId(staff.getStaffId());
            List<Schedule> schedules = scheduleQueryService.findById(staff.getStaffId());
            return staffMapper.toDto(staffEntity.get(), schedules, bookings);
        }
        return staffMapper.toDto(null, List.<Schedule>of(), List.<BookingStaff>of());

    }

    public Staff findById(Long staffId) {
        StaffEntity staff = staffRepository.findById(staffId).orElseThrow(ResourceNotFoundException::new);
        return staffMapper.toDto(staff);
    }
}
