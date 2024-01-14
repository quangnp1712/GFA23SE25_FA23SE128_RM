package com.realman.becore.controller.api.booking.service;

import java.util.List;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.booking.service.models.AccountId;
import com.realman.becore.controller.api.booking.service.models.BookingResultModelMapper;
import com.realman.becore.controller.api.booking.service.models.BookingResultRequest;
import com.realman.becore.controller.api.booking.service.models.BookingServiceId;
import com.realman.becore.dto.booking.result.BookingResult;
import com.realman.becore.service.booking.service.BookingServiceUseCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BookingServiceController implements BookingServiceAPI {
    @NonNull
    private final BookingServiceUseCaseService bookingServiceUseCaseService;
    @NonNull
    private final BookingResultModelMapper bookingResultModelMapper;

    @Override
    public void startService(Long bookingServiceId, Long accountId) {
        bookingServiceUseCaseService.startService(new BookingServiceId(bookingServiceId), new AccountId(accountId));
    }

    @Override
    public void endService(Long bookingServiceId, List<BookingResultRequest> bookingResults, Long accountId) {
        List<BookingResult> saveBookingResults = bookingResults.stream().map(bookingResultModelMapper::toDto).toList();
        bookingServiceUseCaseService.endService(new BookingServiceId(bookingServiceId), saveBookingResults,
                new AccountId(accountId));
    }

    @Override
    public void confirmService(Long bookingServiceId, Long accountId) {
        bookingServiceUseCaseService.confirmService(new BookingServiceId(bookingServiceId), new AccountId(accountId));
    }

}
