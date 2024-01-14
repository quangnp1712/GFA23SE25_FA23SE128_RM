package com.realman.becore.service.booking.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.realman.becore.dto.booking.service.BookingService;
import com.realman.becore.dto.booking.service.BookingServiceMapper;
import com.realman.becore.repository.database.booking.service.BookingServiceRepository;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingServiceQueryService {
    @NonNull
    private final BookingServiceRepository bookingServiceRepository;
    @NonNull
    private final BookingServiceMapper bookingServiceMapper;

    public List<BookingService> findByBookingId(Long bookingId) {
        List<BookingService> bookingServices = bookingServiceRepository.findInfoByBookingId(bookingId).stream()
                .map(bookingServiceMapper::toDto).toList();
        return bookingServices;
    }

    public Page<BookingService> findByStaffId(Long staffId, PageRequestCustom pageRequestCustom) {
        Page<BookingService> bookingServices = bookingServiceRepository
                .findByStaffId(staffId, pageRequestCustom.pageRequest())
                .map(bookingServiceMapper::toDto);
        return bookingServices;
    }

    public List<BookingService> findAll(Long accountId) {
        return bookingServiceRepository.findAllInfo(accountId).stream()
                .map(bookingServiceMapper::toDto).toList();
    }
}
