package com.realman.becore.controller.api.booking.service;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.realman.becore.controller.api.booking.service.models.BookingResultRequest;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Booking Service", description = "Booking service API")
@RequestMapping("/v1/booking-service/{bookingServiceId}")
public interface BookingServiceAPI {
    @PutMapping("/start-service")
    void startService(@PathVariable Long bookingServiceId, @RequestParam Long accountId);

    @PutMapping("/finish-service")
    void endService(
            @PathVariable Long bookingServiceId,
            @RequestParam(required = false, value = "bookingResults", defaultValue = "") List<BookingResultRequest> bookingResults,
            @RequestParam Long accountId);

    @PutMapping("/confirm-service")
    void confirmService(
            @PathVariable Long bookingServiceId,
            @RequestParam Long accountId);
}
