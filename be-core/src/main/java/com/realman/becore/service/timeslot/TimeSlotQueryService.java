package com.realman.becore.service.timeslot;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.timeslot.TimeSlot;
import com.realman.becore.dto.timeslot.TimeSlotMapper;
import com.realman.becore.repository.database.timeslot.TimeSlotRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TimeSlotQueryService {
    @NonNull
    private final TimeSlotRepository timeSlotRepository;
    @NonNull
    private final TimeSlotMapper timeSlotMapper;

    public List<TimeSlot> findTimeSlots(LocalDate chosenDate, Long staffId) {
        List<TimeSlot> timeSlots = timeSlotRepository.findAllInfoById(chosenDate, staffId).stream()
                .map(timeSlotMapper::toDto).toList();
        return timeSlots;
    }
}
