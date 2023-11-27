package com.realman.becore.dto.staff;

import com.realman.becore.dto.enums.EProfessional;
import com.realman.becore.dto.schedule.Schedule;

import java.util.List;
import lombok.Builder;

@Builder
public record Staff(
        Long staffId,
        Long accountId,
        Double averageRating,
        List<Schedule> scheduleList,
        EProfessional professional) {

}
