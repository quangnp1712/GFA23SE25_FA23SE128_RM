package com.realman.becore.service.booking;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import com.realman.becore.controller.api.booking.models.BookingId;
import com.realman.becore.dto.booking.Booking;
import com.realman.becore.dto.booking.BookingInfo;
import com.realman.becore.dto.booking.BookingMapper;
import com.realman.becore.dto.booking.service.BookingService;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.booking.BookingRepository;
import com.realman.becore.service.booking.service.BookingServiceUseCaseService;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingQueryService {
    @NonNull
    private final BookingRepository bookingRepository;
    @NonNull
    private final BookingServiceUseCaseService bookingServiceUseCaseService;
    @NonNull
    private final BookingMapper bookingMapper;

    public Booking findById(BookingId bookingId) {
        List<BookingService> bookingServices = bookingServiceUseCaseService.findByBookingId(bookingId.value());
        BookingInfo bookingInfo = bookingRepository.findInfoById(bookingId.value())
                .orElseThrow(ResourceNotFoundException::new);
        Booking booking = bookingMapper.toDto(bookingInfo, bookingServices);
        return booking;
    }

    public Page<Booking> findAll(Long accountId, PageRequestCustom pageRequestCustom) {
        Map<Long, List<BookingService>> bookingServiceMap = bookingServiceUseCaseService.findAll(accountId)
                .stream().collect(Collectors.groupingBy(BookingService::bookingId));
        Page<Booking> bookings = bookingRepository.findAllInfo(pageRequestCustom.pageRequest())
                .map(booking -> bookingMapper.toDto(booking, bookingServiceMap.get(booking.getBookingId())));
        return bookings;
    }
}
