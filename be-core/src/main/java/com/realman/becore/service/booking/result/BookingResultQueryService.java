package com.realman.becore.service.booking.result;

import java.util.List;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.booking.result.BookingResult;
import com.realman.becore.dto.booking.result.BookingResultMapper;
import com.realman.becore.repository.database.booking.result.BookingResultRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingResultQueryService {
    @NonNull
    private final BookingResultRepository bookingResultRepository;
    @NonNull
    private final BookingResultMapper bookingResultMapper;

    public List<BookingResult> findByBookingId(Long bookingId) {
        List<BookingResult> bookingResults = bookingResultRepository.findByBookingId(bookingId).stream()
                .map(bookingResultMapper::toDto).toList();
        return bookingResults;
    }
}
