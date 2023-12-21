package com.realman.becore.service.booking;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.controller.api.booking.models.BookingId;
import com.realman.becore.dto.booking.Booking;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingUseCaseService {
    @NonNull
    private final BookingCommandService bookingCommandService;
    @NonNull
    private final BookingQueryService bookingQueryService;

    @Transactional
    public void save(Booking booking) {
        bookingCommandService.save(booking);
    }

    @Transactional
    public void confirmBooking(BookingId bookingId, Boolean isAccepted) {
        bookingCommandService.confirmBooking(bookingId, isAccepted);
    }

    public Booking findById(BookingId bookingId) {
        return bookingQueryService.findById(bookingId);
    }

    public Page<Booking> findAll(Long accountId, PageRequestCustom pageRequestCustom) {
        return bookingQueryService.findAll(accountId, pageRequestCustom);
    }
}
