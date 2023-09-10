package com.realman.becore.repository.database.booking_service;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Embeddable
@NoArgsConstructor
public class BookingServiceId implements Serializable {
    private Long bookingId;
    private Long serviceId;
}
