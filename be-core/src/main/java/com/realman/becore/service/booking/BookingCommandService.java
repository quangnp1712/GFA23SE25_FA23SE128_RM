package com.realman.becore.service.booking;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.booking.models.BookingId;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountId;
import com.realman.becore.dto.booking.Booking;
import com.realman.becore.dto.booking.BookingMapper;
import com.realman.becore.dto.enums.EBookingStatus;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.booking.BookingEntity;
import com.realman.becore.repository.database.booking.BookingRepository;
import com.realman.becore.service.account.AccountUseCaseService;
import com.realman.becore.service.booking.service.BookingServiceCommandService;
import com.realman.becore.service.twilio.TwilioUseCaseService;
import java.time.LocalDate;

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
    private final AccountUseCaseService accountUseCaseService;
    @NonNull
    private final TwilioUseCaseService twilioUseCaseService;
    @NonNull
    private final BookingMapper bookingMapper;

    public void save(Booking booking) {

        StringBuilder bookingCode = new StringBuilder();
        bookingCode.append("BOOK").append("_").append(booking.accountId().toString())
                .append("__").append(LocalDate.now().getDayOfMonth()).append(LocalDate.now().getMonthValue())
                .append(LocalDate.now().getYear());
        BookingEntity bookingEntity = bookingMapper.toEntity(booking, bookingCode.toString(), EBookingStatus.ONGOING);
        BookingEntity savedBooking = bookingRepository.save(bookingEntity);
        bookingServiceCommandService.saveAll(savedBooking.getBookingId(), booking.bookingServices());
    }

    public void confirmBooking(BookingId bookingId, Boolean isAccepted) {
        BookingEntity bookingEntity = bookingRepository.findById(bookingId.value())
                .orElseThrow(ResourceNotFoundException::new);
        Account account = accountUseCaseService.findById(new AccountId(bookingEntity.getAccountId()));
        EBookingStatus newStatus = isAccepted ? EBookingStatus.COMFIRMED : EBookingStatus.REJECTED;
        bookingEntity.setBookingStatus(newStatus);
        bookingRepository.save(bookingEntity);
        if (isAccepted) {
            twilioUseCaseService.acceptBooking(account.phone(), bookingEntity.getBookingCode());
        } else {
            twilioUseCaseService.denyBooking(account.phone(), bookingEntity.getBookingCode());
        }
    }
}
