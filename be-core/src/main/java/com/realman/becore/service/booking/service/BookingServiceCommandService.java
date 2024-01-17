package com.realman.becore.service.booking.service;

import java.util.List;
import org.springframework.stereotype.Service;
import java.time.LocalTime;
import com.realman.becore.controller.api.booking.service.models.BookingResultRequest;
import com.realman.becore.controller.api.booking.service.models.BookingServiceId;
import com.realman.becore.dto.booking.result.BookingResult;
import com.realman.becore.dto.booking.service.BookingService;
import com.realman.becore.dto.booking.service.BookingServiceInfo;
import com.realman.becore.dto.booking.service.BookingServiceMapper;
import com.realman.becore.dto.enums.EBookingServiceStatus;
import com.realman.becore.dto.enums.EBookingServiceType;
import com.realman.becore.error_handlers.exceptions.ResourceInvalidException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.booking.service.BookingServiceEntity;
import com.realman.becore.repository.database.booking.service.BookingServiceRepository;
import com.realman.becore.service.booking.result.BookingResultCommandService;
import com.realman.becore.util.RequestContext;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingServiceCommandService {
    @NonNull
    private final BookingServiceRepository bookingServiceRepository;
    @NonNull
    private final BookingResultCommandService bookingResultCommandService;
    @NonNull
    private final BookingServiceMapper bookingServiceMapper;
    @NonNull
    private final RequestContext requestContext;

    public void saveAll(Long bookingId, List<BookingService> bookingServiceList) {
        List<BookingServiceEntity> bookingServiceEntities = bookingServiceList.stream()
                .map(booking -> {
                    BookingServiceEntity entity = new BookingServiceEntity();
                    if (booking.bookingServiceType().equals(EBookingServiceType.PICKUP_STYLIST)) {
                        entity = bookingServiceMapper.toEntity(booking, bookingId, EBookingServiceStatus.PENDING,
                                EBookingServiceType.PICKUP_STYLIST);
                    } else if (booking.bookingServiceType().equals(EBookingServiceType.CHOSEN_STYLIST)) {
                        entity = bookingServiceMapper.toEntity(booking, bookingId, EBookingServiceStatus.ONGOING,
                                EBookingServiceType.CHOSEN_STYLIST);
                    }
                    return entity;
                }).toList();
        bookingServiceRepository.saveAll(bookingServiceEntities);
    }

    public void chooseStylist(Long staffId, Long bookingServiceId) {
        BookingServiceEntity foundBookingService = bookingServiceRepository.findById(bookingServiceId)
                .orElseThrow(ResourceNotFoundException::new);
        if (!foundBookingService.getBookingServiceType().equals(EBookingServiceType.PICKUP_STYLIST)) {
            throw new ResourceInvalidException();
        }
        foundBookingService.setStaffId(staffId);
        foundBookingService.setBookingServiceStatus(EBookingServiceStatus.ONGOING);
        bookingServiceRepository.save(foundBookingService);
    }

    public void startService(BookingServiceId bookingServiceId) {
        BookingServiceInfo bookingInfo = bookingServiceRepository
                .findInfoById(bookingServiceId.value(), requestContext.getAccountId())
                .orElseThrow(ResourceNotFoundException::new);
        if (bookingInfo.getAllowUpdate()) {
            List<BookingServiceEntity> otherBookingServices = bookingServiceRepository
                    .findOtherByBookingId(bookingInfo.getBookingId(), bookingInfo.getBookingServiceId());
            if (otherBookingServices.stream()
                    .filter(b -> !b.getBookingServiceStatus().equals(EBookingServiceStatus.CONFIRM)).findAny()
                    .isPresent()) {
                throw new ResourceInvalidException("Có dịch vụ chưa được confirm");
            }
            BookingServiceEntity foundBookingServiceEntity = bookingServiceMapper.toEntity(bookingInfo);
            foundBookingServiceEntity.setBookingServiceStatus(EBookingServiceStatus.PROCESSING);
            foundBookingServiceEntity.setActualStartAppointment(LocalTime.now());
            bookingServiceRepository.save(foundBookingServiceEntity);
            lockBookingService(foundBookingServiceEntity.getBookingId(),
                    foundBookingServiceEntity.getBookingServiceId());
        }
    }

    public void finishService(BookingServiceId bookingServiceId, BookingResultRequest bookingResultRequests) {
        BookingServiceInfo bookingInfo = bookingServiceRepository
                .findInfoById(bookingServiceId.value(), requestContext.getAccountId())
                .orElseThrow(ResourceNotFoundException::new);
        if (bookingInfo.getAllowUpdate()) {
            BookingServiceEntity foundBookingServiceEntity = bookingServiceMapper.toEntity(bookingInfo);
            foundBookingServiceEntity.setBookingServiceStatus(EBookingServiceStatus.FINISHED);
            foundBookingServiceEntity.setActualEndAppointment(LocalTime.now());
            bookingServiceRepository.save(foundBookingServiceEntity);
            unlockBookingService(foundBookingServiceEntity.getBookingId(),
                    foundBookingServiceEntity.getBookingServiceId());
            List<BookingResult> bookingResults = bookingResultRequests.bookingResultImgs().stream().map(
                    b -> BookingResult.builder()
                            .bookingResultImg(b)
                            .bookingServiceId(bookingServiceId.value())
                            .build())
                    .toList();
            bookingResultCommandService.saveAll(bookingResults);
        }
    }

    public void confirmService(BookingServiceId bookingServiceId) {
        BookingServiceInfo bookingInfo = bookingServiceRepository
                .findInfoById(bookingServiceId.value(), requestContext.getAccountId())
                .orElseThrow(ResourceNotFoundException::new);
        if (bookingInfo.getAllowUpdate()) {
            BookingServiceEntity foundBookingService = bookingServiceMapper.toEntity(bookingInfo);
            foundBookingService.setBookingServiceStatus(EBookingServiceStatus.CONFIRM);
            List<BookingServiceEntity> otherBookingServices = bookingServiceRepository
                    .findOtherByBookingId(foundBookingService.getBookingId(), bookingServiceId.value());
            List<BookingServiceEntity> updateBookingServices = otherBookingServices.stream()
                    .map(bs -> {
                        if (bs.getBookingServiceStatus().equals(EBookingServiceStatus.ONGOING)) {
                            bs.setBookingServiceStatus(EBookingServiceStatus.REQUEST_CONFIRM);
                        }
                        return bs;
                    }).toList();
            bookingServiceRepository.save(foundBookingService);
            bookingServiceRepository.saveAll(updateBookingServices);
        }
    }

    public void cancelBookingService(Long bookingServiceId) {
        BookingServiceEntity bookingService = bookingServiceRepository.findById(bookingServiceId)
                .orElseThrow(ResourceNotFoundException::new);
        if (!bookingService.getBookingServiceStatus().equals(EBookingServiceStatus.ONGOING) &&
                !bookingService.getBookingServiceStatus().equals(EBookingServiceStatus.CONFIRM) &&
                !bookingService.getBookingServiceStatus().equals(EBookingServiceStatus.REQUEST_CONFIRM)) {
            throw new ResourceInvalidException();
        }
        bookingService.setBookingServiceStatus(EBookingServiceStatus.CANCLED);
        bookingServiceRepository.save(bookingService);
    }

    private void lockBookingService(Long bookingId, Long bookingServiceId) {
        List<BookingServiceEntity> foundBookingServices = bookingServiceRepository.findAllNotEqualId(bookingId,
                bookingServiceId);
        List<BookingServiceEntity> updatedBookingServices = foundBookingServices.stream().map(bookingService -> {
            bookingService.setBookingServiceStatus(EBookingServiceStatus.LOCKED);
            return bookingService;
        }).toList();
        bookingServiceRepository.saveAll(updatedBookingServices);
    }

    private void unlockBookingService(Long bookingId, Long bookingServiceId) {
        List<BookingServiceEntity> foundBookingServices = bookingServiceRepository.findAllNotEqualId(bookingId,
                bookingServiceId);
        List<BookingServiceEntity> updatedBookingServices = foundBookingServices.stream().map(bookingService -> {
            if (!bookingService.getBookingServiceStatus().equals(EBookingServiceStatus.FINISHED)) {
                bookingService.setBookingServiceStatus(EBookingServiceStatus.PROCESSING);
            }
            return bookingService;
        }).toList();
        bookingServiceRepository.saveAll(updatedBookingServices);
    }

}
