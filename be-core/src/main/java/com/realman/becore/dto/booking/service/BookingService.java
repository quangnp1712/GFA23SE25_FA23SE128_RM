package com.realman.becore.dto.booking.service;

import lombok.Builder;

@Builder
public record BookingService(
    Long bookingServiceId,
    Long bookingId,
    Long serviceId
) {
    
}
