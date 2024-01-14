package com.realman.becore.controller.api.booking.service.models;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.booking.result.BookingResult;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BookingResultModelMapper {
    BookingResult toDto(BookingResultRequest model);
}
