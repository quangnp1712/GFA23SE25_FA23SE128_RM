package com.realman.becore.service.booking.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.controller.api.booking.service.models.AccountId;
import com.realman.becore.controller.api.booking.service.models.BookingServiceId;
import com.realman.becore.dto.booking.service.BookingService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingServiceUseCaseService {
    @NonNull
    private final BookingServiceQueryService bookingServiceQueryService;
    @NonNull
    private final BookingServiceCommandService bookingServiceCommandService;

    @Transactional
    public void startService(BookingServiceId bookingServiceId, AccountId accountId) {
        bookingServiceCommandService.startService(bookingServiceId, accountId);
    }

    @Transactional
    public void endService(BookingServiceId bookingServiceId, AccountId accountId) {
        bookingServiceCommandService.finishService(bookingServiceId, accountId);
    }

    public List<BookingService> findByBookingId(Long bookingId) {
        return bookingServiceQueryService.findByBookingId(bookingId);
    }

    public List<BookingService> findAll(Long accountId) {
        return bookingServiceQueryService.findAll(accountId);
    }
}
