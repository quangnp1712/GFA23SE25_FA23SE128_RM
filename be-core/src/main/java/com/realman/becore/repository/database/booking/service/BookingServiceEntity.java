package com.realman.becore.repository.database.booking.service;

import java.time.LocalTime;

import com.realman.becore.dto.enums.EBookingServiceStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "booking_service")
public class BookingServiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingServiceId;
    private Long bookingId;
    private Long serviceId;
    private Long staffId;
    @Temporal(TemporalType.TIME)
    private LocalTime startTime;
    @Temporal(TemporalType.TIME)
    private LocalTime actualStartTime;
    @Temporal(TemporalType.TIME)
    private LocalTime endTime;
    @Temporal(TemporalType.TIME)
    private LocalTime actualEndTime;
    private EBookingServiceStatus bookingServiceStatus;
}
