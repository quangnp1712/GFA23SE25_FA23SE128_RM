package com.realman.becore.service.booking;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.booking.Booking;
import com.realman.becore.dto.booking.BookingMapper;
import com.realman.becore.dto.enums.EBookingStatus;
import com.realman.becore.repository.database.booking.BookingEntity;
import com.realman.becore.repository.database.booking.BookingRepository;
import com.realman.becore.service.booking.service.BookingServiceCommandService;
import com.realman.becore.service.twilio.TwilioUseCaseService;
import com.realman.becore.util.RequestContext;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookingCommandService {
    @NonNull
    private final BookingRepository bookingRepository;
    @NonNull
    private final BookingServiceCommandService bookingServiceCommandService;
    @NonNull
    private final TwilioUseCaseService twilioUseCaseService;
    @NonNull
    private final BookingMapper bookingMapper;
    @NonNull
    private final RequestContext requestContext;

    public void save(Booking booking) {
        StringBuilder bookingCode = new StringBuilder();
        bookingCode.append("BOOK")
                .append("__").append(LocalDate.now().getDayOfMonth()).append(LocalDate.now().getMonthValue())
                .append(LocalDate.now().getYear()).append("_").append(LocalTime.now().getHour())
                .append(LocalTime.now().getMinute())
                .append(LocalTime.now().getSecond());
        BookingEntity bookingEntity = bookingMapper.toEntity(booking, bookingCode.toString(), EBookingStatus.ONGOING,
                requestContext.getCustomerId());
        BookingEntity savedBooking = bookingRepository.save(bookingEntity);
        bookingServiceCommandService.saveAll(savedBooking.getBookingId(), booking.bookingServices());
    }
}
