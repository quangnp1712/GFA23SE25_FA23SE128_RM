package com.realman.becore.service.booking.service;

import java.util.List;
import java.util.Map;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import com.realman.becore.dto.booking.result.BookingResult;
import com.realman.becore.dto.booking.service.BookingService;
import com.realman.becore.dto.booking.service.BookingServiceMapper;
import com.realman.becore.repository.database.booking.service.BookingServiceRepository;
import com.realman.becore.service.booking.result.BookingResultUseCaseService;
import com.realman.becore.util.RequestContext;
import com.realman.becore.util.response.PageRequestCustom;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingServiceQueryService {
    @NonNull
    private final BookingServiceRepository bookingServiceRepository;
    @NonNull
    private final BookingResultUseCaseService bookingResultUseCaseService;
    @NonNull
    private final BookingServiceMapper bookingServiceMapper;
    @NonNull
    private final RequestContext requestContext;

    public List<BookingService> findByBookingId(Long bookingId) {
        Map<Long, List<BookingResult>> bookingResults = bookingResultUseCaseService.findAll();
        List<BookingService> bookingServices = bookingServiceRepository.findInfoByBookingId(bookingId).stream()
                .map(r -> bookingServiceMapper.toDto(r, bookingResults.get(r.getBookingServiceId()))).toList();
        return bookingServices;
    }

    public Page<BookingService> findByStaffId(PageRequestCustom pageRequestCustom) {
        Map<Long, List<BookingResult>> bookingResults = bookingResultUseCaseService.findAll();
        Page<BookingService> bookingServices = bookingServiceRepository
                .findByStaffId(requestContext.getStaffId(), pageRequestCustom.pageRequest())
                .map(r -> bookingServiceMapper.toDto(r, bookingResults.get(r.getBookingServiceId())));
        return bookingServices;
    }

    public List<BookingService> findAll() {
        Map<Long, List<BookingResult>> bookingResults = bookingResultUseCaseService.findAll();
        return bookingServiceRepository.findAllInfo(requestContext.getAccountId()).stream()
                .map(r -> bookingServiceMapper.toDto(r, bookingResults.get(r.getBookingServiceId()))).toList();
    }
}
