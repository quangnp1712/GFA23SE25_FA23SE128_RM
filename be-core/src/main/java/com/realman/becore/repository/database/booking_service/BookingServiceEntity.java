package com.realman.becore.repository.database.booking_service;

import com.realman.becore.repository.database.booking.BookingEntity;
import com.realman.becore.repository.database.service.ServiceEntity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "booking_service")
public class BookingServiceEntity {
    @EmbeddedId
    private BookingServiceId bookingServiceId = new BookingServiceId();
    @MapsId("bookingId")
    @ManyToOne
    private BookingEntity booking;
    @MapsId("serviceId")
    @ManyToOne
    private ServiceEntity service;
}
