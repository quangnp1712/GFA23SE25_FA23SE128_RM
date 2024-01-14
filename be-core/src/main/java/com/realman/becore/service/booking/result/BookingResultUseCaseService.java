package com.realman.becore.service.booking.result;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.booking.result.BookingResult;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingResultUseCaseService {
    @NonNull
    private final BookingResultCommandService bookingResultCommandService;
    @NonNull
    private final BookingResultQueryService bookingResultQueryService;

    @Transactional
    public void saveAll(Long bookingServiceId, List<BookingResult> bookingResults) {
        bookingResultCommandService.saveAll(bookingServiceId, bookingResults);
    }

    public List<BookingResult> findByBookingId(Long bookingId) {
        return bookingResultQueryService.findByBookingId(bookingId);
    }
}
