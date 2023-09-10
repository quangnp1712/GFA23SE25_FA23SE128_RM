package com.realman.becore.repository.database.booking_staff;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@NoArgsConstructor
public class BookingStaffId implements Serializable {
    private Long bookingId;
    private Long staffId;
}
