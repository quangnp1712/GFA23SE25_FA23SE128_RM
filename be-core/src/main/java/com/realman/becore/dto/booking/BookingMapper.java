package com.realman.becore.dto.booking;

import java.util.List;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import com.realman.becore.dto.booking.service.BookingService;
import com.realman.becore.dto.enums.EBookingStatus;
import com.realman.becore.repository.database.booking.BookingEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BookingMapper {
    @Mapping(source = "bookingStatus", target = "bookingStatus")
    @Mapping(source = "bookingCode", target = "bookingCode")
    BookingEntity toEntity(Booking dto, String bookingCode, EBookingStatus bookingStatus);

    Booking toDto(BookingInfo info, List<BookingService> bookingServices);
}
