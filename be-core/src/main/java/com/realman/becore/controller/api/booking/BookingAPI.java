package com.realman.becore.controller.api.booking;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.realman.becore.controller.api.booking.models.BookingResponse;
import com.realman.becore.util.response.ValueResponse;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Booking", description = "Booking API")
@RequestMapping("/v1/booking/{bookingId}")
public interface BookingAPI {
    @PutMapping
    void confirmBooking(@PathVariable Long bookingId, @RequestParam(value = "isAccepted") Boolean isAccepted);

    @GetMapping
    ValueResponse<BookingResponse> findById(@PathVariable Long bookingId);
}
