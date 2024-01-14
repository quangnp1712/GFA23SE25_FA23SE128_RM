package com.realman.becore.dto.booking.service;

import java.time.Duration;
import java.time.LocalTime;

import com.realman.becore.dto.enums.EBookingServiceStatus;
import com.realman.becore.dto.enums.EBookingServiceType;
import com.realman.becore.dto.enums.EProfessional;

import lombok.Builder;

@Builder
public record BookingService(
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
        EBookingServiceStatus bookingServiceStatus,
        EProfessional professional,
        EBookingServiceType bookingServiceType,
        Boolean allowUpdate,
        Boolean allowProcess) {

}
