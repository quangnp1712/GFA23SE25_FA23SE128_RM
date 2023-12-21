package com.realman.becore.controller.api.booking.models;

import java.time.LocalDate;
import java.util.List;

import com.realman.becore.controller.api.booking.service.models.BookingServiceResponse;
import com.realman.becore.dto.enums.EBookingStatus;

public record BookingResponse(
                Long bookingId,
                Long accountId,
                Long branchId,
                String bookingCode,
                String bookingOwnerName,
                String bookingOwnerPhone,
                String branchAddress,
                String branchName,
                LocalDate appointmentDate,
                List<BookingServiceResponse> bookingServices,
                EBookingStatus bookingStatus) {
}
