package com.realman.becore.repository.database.booking_staff;

import com.realman.becore.repository.database.booking.BookingEntity;
import com.realman.becore.repository.database.staff.StaffEntity;

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
@Table(name = "booking_staff")
public class BookingStaffEntity {
    @EmbeddedId
    private BookingStaffId bookingStaffId = new BookingStaffId();
    @MapsId("bookingId")
    @ManyToOne
    private BookingEntity booking;
    @MapsId("staffId")
    @ManyToOne
    private StaffEntity staff;
}
