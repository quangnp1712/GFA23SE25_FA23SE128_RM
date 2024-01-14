package com.realman.becore.controller.api.booking.service;

import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.booking.service.models.BookingServiceModelMapper;
import com.realman.becore.controller.api.booking.service.models.BookingServiceResponse;
import com.realman.becore.service.booking.service.BookingServiceUseCaseService;
import com.realman.becore.util.response.PageImplResponse;
import com.realman.becore.util.response.PageRequestCustom;

import jakarta.validation.constraints.Min;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BookingServicesController implements BookingServicesAPI {
    @NonNull
    private final BookingServiceUseCaseService bookingServiceUseCaseService;
    @NonNull
    private final BookingServiceModelMapper bookingServiceModelMapper;

    @Override
    public PageImplResponse<BookingServiceResponse> findByStaffId(Long staffId, String sorter, @Min(1) Integer current,
            Integer pageSize) {
        PageRequestCustom pageRequestCustom = PageRequestCustom.of(pageSize, current, sorter);
        Page<BookingServiceResponse> responses = bookingServiceUseCaseService.findByStaffId(staffId, pageRequestCustom)
                .map(bookingServiceModelMapper::toModel);
        return new PageImplResponse<>(
                responses.getContent(),
                responses.getTotalElements(),
                responses.getTotalPages(),
                pageSize,
                pageRequestCustom.current());
    }

}
