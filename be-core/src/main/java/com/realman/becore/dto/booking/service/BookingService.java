package com.realman.becore.dto.booking.service;

import java.time.Duration;
import java.time.LocalTime;

import com.realman.becore.dto.enums.EBookingServiceStatus;
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
                LocalTime startTime,
                LocalTime actualStartTime,
                LocalTime endTime,
                LocalTime actualEndTime,
                Duration duration,
                EBookingServiceStatus bookingServiceStatus,
                EProfessional professional,
                Boolean allowUpdate) {

}
