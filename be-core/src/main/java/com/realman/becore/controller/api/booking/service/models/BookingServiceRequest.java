package com.realman.becore.controller.api.booking.service.models;

import java.time.LocalTime;

public record BookingServiceRequest(
        Long serviceId,
        Long staffId,
        LocalTime startTime,
        LocalTime endTime) {
}
