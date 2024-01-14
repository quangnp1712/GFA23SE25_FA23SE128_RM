package com.realman.becore.dto.booking.result;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.booking.result.BookingResultEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BookingResultMapper {
    @Mapping(source = "bookingServiceId", target = "bookingServiceId")
    BookingResultEntity toEntity(BookingResult dto, Long bookingServiceId);

    BookingResult toDto(BookingResultEntity entity);
}
