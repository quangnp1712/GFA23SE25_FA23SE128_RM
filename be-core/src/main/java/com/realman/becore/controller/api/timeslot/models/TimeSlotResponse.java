package com.realman.becore.controller.api.timeslot.models;

import java.time.LocalTime;
import java.time.LocalDate;
import com.realman.becore.util.TimeZoneConfig;
import lombok.Builder;
import java.time.ZonedDateTime;

@Builder
public record TimeSlotResponse(
                Long timeSlotId,
                Long shiftId,
                LocalTime time,
                String timeText,
                Boolean isAvailable) {

        public LocalTime time() {
                return ZonedDateTime.of(time.atDate(LocalDate.now()), TimeZoneConfig.zoneId())
                                .toLocalTime();
        }
}
