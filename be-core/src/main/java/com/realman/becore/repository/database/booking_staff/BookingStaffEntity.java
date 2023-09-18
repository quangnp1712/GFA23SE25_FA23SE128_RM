package com.realman.becore.repository.database.booking_staff;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "booking_staff")
public class BookingStaffEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingStaffId;
    private Long bookingId;
    private Long staffId;
}
