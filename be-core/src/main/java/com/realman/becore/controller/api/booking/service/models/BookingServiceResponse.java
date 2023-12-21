package com.realman.becore.controller.api.booking.service.models;

import com.realman.becore.dto.enums.EBookingServiceStatus;
import java.time.Duration;
import java.time.LocalTime;

public record BookingServiceResponse(
        Long bookingServiceId,
        Long bookingId,
        Long serviceId,
        Long staffId,
        String serviceName,
        Long servicePrice,
        String staffName,
        String staffPhone,
        LocalTime startTime,
        LocalTime actualStartTime,
        LocalTime endTime,
        LocalTime actualEndTime,
        Duration duration,
        String durationText,
        EBookingServiceStatus bookingServiceStatus,
        Boolean allowUpdate) {
    public String durationText() {
        StringBuilder builder = new StringBuilder();
        return builder.append(duration.toHours()).append(":")
                .append(duration.toMinutes()).append(":")
                .append(duration.toSeconds())
                .toString();
    }
}
