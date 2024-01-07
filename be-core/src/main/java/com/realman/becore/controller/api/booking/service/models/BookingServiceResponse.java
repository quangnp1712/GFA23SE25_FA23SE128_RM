package com.realman.becore.controller.api.booking.service.models;

import com.realman.becore.dto.enums.EBookingServiceStatus;
import com.realman.becore.dto.enums.EProfessional;

import java.time.Duration;
import java.time.LocalTime;
import java.util.Objects;

public record BookingServiceResponse(
        Long bookingServiceId,
        Long bookingId,
        Long serviceId,
        Long staffId,
        String serviceName,
        Long servicePrice,
        String staffName,
        String staffPhone,
        LocalTime startAppointment,
        LocalTime actualStartAppointment,
        LocalTime endAppointment,
        LocalTime actualEndAppointment,
        Duration duration,
        String durationText,
        EBookingServiceStatus bookingServiceStatus,
        EProfessional professional,
        Boolean allowUpdate) {
    public String durationText() {
        StringBuilder builder = new StringBuilder();
        if (Objects.nonNull(duration)) {
            return builder.append(duration.toHours()).append(":")
                    .append(duration.toMinutes()).append(":")
                    .append(duration.toSeconds())
                    .toString();
        }
        return builder.append(0).toString();
    }
}
