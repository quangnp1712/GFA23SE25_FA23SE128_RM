package com.realman.becore.controller.api.booking.service;

import org.springframework.web.bind.annotation.RestController;
import com.realman.becore.controller.api.booking.service.models.AccountId;
import com.realman.becore.controller.api.booking.service.models.BookingResultRequest;
import com.realman.becore.controller.api.booking.service.models.BookingServiceId;
import com.realman.becore.service.booking.service.BookingServiceUseCaseService;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BookingServiceController implements BookingServiceAPI {
    @NonNull
    private final BookingServiceUseCaseService bookingServiceUseCaseService;

    @Override
    public void startService(Long bookingServiceId, Long accountId) {
        bookingServiceUseCaseService.startService(new BookingServiceId(bookingServiceId), new AccountId(accountId));
    }

    @Override
    public void endService(Long bookingServiceId, BookingResultRequest bookingResultRequest, Long accountId) {
        bookingServiceUseCaseService.endService(new BookingServiceId(bookingServiceId),
                bookingResultRequest,
                new AccountId(accountId));
    }

    @Override
    public void confirmService(Long bookingServiceId, Long accountId) {
        bookingServiceUseCaseService.confirmService(new BookingServiceId(bookingServiceId), new AccountId(accountId));
    }

    @Override
    public void cancelBookingService(Long bookingServiceId) {
        bookingServiceUseCaseService.cancelBookingService(bookingServiceId);
    }

}
