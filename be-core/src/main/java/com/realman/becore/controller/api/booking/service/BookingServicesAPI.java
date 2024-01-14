package com.realman.becore.controller.api.booking.service;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.realman.becore.controller.api.booking.service.models.BookingServiceResponse;
import com.realman.becore.util.response.PageImplResponse;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Min;

@Tag(name = "Booking Service", description = "Booking service management")
@RequestMapping("/v1/booking-service")
@PreAuthorize("hasRole('ROLE_STAFF')")
public interface BookingServicesAPI {
    @GetMapping
    PageImplResponse<BookingServiceResponse> findByStaffId(
            @RequestParam(value = "staffId") Long staffId,
            @RequestParam(required = false, value = "sorter", defaultValue = "appointmentDate") String sorter,
            @RequestParam(required = false, value = "current", defaultValue = "1") @Min(1) Integer current,
            @RequestParam(required = false, value = "pageSize", defaultValue = "20") Integer pageSize);
}
