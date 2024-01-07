package com.realman.becore.controller.api.booking;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.realman.becore.controller.api.booking.models.BookingResponse;
import com.realman.becore.util.response.ValueResponse;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Booking", description = "Booking API")
@RequestMapping("/v1/booking/{bookingId}")
public interface BookingAPI {
    @GetMapping
    ValueResponse<BookingResponse> findById(@PathVariable Long bookingId);
}
