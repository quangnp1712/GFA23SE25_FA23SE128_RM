package com.realman.becore.controller.api.schedule.models;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

public record ScheduleRequest(
        Long shiftId,
        @JsonFormat(pattern = "MM/dd/yyyy") LocalDate workingDate) {

}
