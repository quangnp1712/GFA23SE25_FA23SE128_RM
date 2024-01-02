package com.realman.becore.controller.api.schedule.models;

import java.time.LocalDate;
import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.realman.becore.dto.enums.EScheduleStatus;
import com.realman.becore.dto.enums.EShift;

public record ScheduleResponse(
        Long scheduleId,
        Long staffId,
        EShift shift,
        @JsonFormat(pattern = "MM/dd/yyyy") LocalDate workingDate,
        LocalTime start,
        LocalTime end,
        EScheduleStatus scheduleStatus

) {
}
