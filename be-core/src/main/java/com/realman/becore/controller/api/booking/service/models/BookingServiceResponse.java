package com.realman.becore.controller.api.booking.service.models;

import com.realman.becore.dto.enums.EBookingServiceStatus;
import com.realman.becore.dto.enums.EBookingServiceType;
import com.realman.becore.dto.enums.EProfessional;
import com.realman.becore.util.TimeZoneConfig;

import java.time.Duration;
import java.time.LocalTime;
import java.time.LocalDate;
import java.util.Objects;
import java.util.List;
import java.time.ZonedDateTime;

public record BookingServiceResponse(
        Long bookingServiceId,
        Long bookingId,
        Long serviceId,
        Long staffId,
        Long ratingId,
        String bookingCode,
        String serviceName,
        Long servicePrice,
        String staffName,
        String staffPhone,
        String customerName,
        String customerPhone,
        LocalDate appointmentDate,
        LocalTime startAppointment,
        LocalTime actualStartAppointment,
        LocalTime endAppointment,
        LocalTime actualEndAppointment,
        Duration duration,
        String durationText,
        EBookingServiceStatus bookingServiceStatus,
        EProfessional professional,
        EBookingServiceType bookingServiceType,
        String bookingServiceTypeText,
        List<BookingResultResponse> bookingResults,
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

    public String bookingServiceTypeText() {
        return Objects.nonNull(bookingServiceType) ? bookingServiceType.getText() : null;
    }

    public LocalTime startAppointment() {
        return ZonedDateTime.of(startAppointment.atDate(LocalDate.now()), TimeZoneConfig.zoneId())
                .toLocalTime();
    }

    public LocalTime endAppointment() {
        return ZonedDateTime.of(endAppointment.atDate(LocalDate.now()), TimeZoneConfig.zoneId())
                .toLocalTime();
    }

    public LocalTime actualStartAppointment() {
        return ZonedDateTime.of(actualStartAppointment.atDate(LocalDate.now()), TimeZoneConfig.zoneId())
                .toLocalTime();
    }

    public LocalTime actualEndAppointment() {
        return ZonedDateTime.of(actualEndAppointment.atDate(LocalDate.now()), TimeZoneConfig.zoneId())
                .toLocalTime();
    }

    public LocalDate appointmentDate() {
        return ZonedDateTime.of(appointmentDate.atStartOfDay(), TimeZoneConfig.zoneId()).toLocalDate();
    }
}
