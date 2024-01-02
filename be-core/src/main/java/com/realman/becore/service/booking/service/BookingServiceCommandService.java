package com.realman.becore.service.booking.service;

import java.util.List;

import org.springframework.stereotype.Service;

import java.time.LocalTime;

import com.realman.becore.controller.api.booking.service.models.AccountId;
import com.realman.becore.controller.api.booking.service.models.BookingServiceId;
import com.realman.becore.dto.booking.service.BookingService;
import com.realman.becore.dto.booking.service.BookingServiceInfo;
import com.realman.becore.dto.booking.service.BookingServiceMapper;
import com.realman.becore.dto.enums.EBookingServiceStatus;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.booking.service.BookingServiceEntity;
import com.realman.becore.repository.database.booking.service.BookingServiceRepository;
import java.time.LocalDate;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingServiceCommandService {
    @NonNull
    private final BookingServiceRepository bookingServiceRepository;
    @NonNull
    private final BookingServiceMapper bookingServiceMapper;

    public void saveAll(Long bookingId, List<BookingService> bookingServiceList) {
        List<BookingServiceEntity> bookingServiceEntities = bookingServiceList.stream()
                .map(booking -> bookingServiceMapper.toEntity(booking, bookingId, EBookingServiceStatus.PENDING))
                .toList();
        bookingServiceRepository.saveAll(bookingServiceEntities);
    }

    public void startService(BookingServiceId bookingServiceId, AccountId accountId) {
        BookingServiceInfo bookingInfo = bookingServiceRepository
                .findInfoById(bookingServiceId.value(), accountId.value())
                .orElseThrow(ResourceNotFoundException::new);
        if (bookingInfo.getAllowUpdate()) {
            BookingServiceEntity foundBookingServiceEntity = bookingServiceMapper.toEntity(bookingInfo);
            foundBookingServiceEntity.setBookingServiceStatus(EBookingServiceStatus.PROCESSING);
            foundBookingServiceEntity.setActualStartTime(LocalTime.now());
            bookingServiceRepository.save(foundBookingServiceEntity);
        }
    }

    public void finishService(BookingServiceId bookingServiceId, AccountId accountId) {
        BookingServiceInfo bookingInfo = bookingServiceRepository
                .findInfoById(bookingServiceId.value(), accountId.value())
                .orElseThrow(ResourceNotFoundException::new);
        if (bookingInfo.getAllowUpdate()) {
            BookingServiceEntity foundBookingServiceEntity = bookingServiceMapper.toEntity(bookingInfo);
            foundBookingServiceEntity.setBookingServiceStatus(EBookingServiceStatus.FINISHED);
            foundBookingServiceEntity.setActualEndTime(LocalTime.now());
            bookingServiceRepository.save(foundBookingServiceEntity);
            BookingServiceInfo info = bookingServiceRepository
                    .findNearBookingService(foundBookingServiceEntity.getStaffId(), LocalDate.now())
                    .stream().findFirst().orElse(null);

        }
    }
}
