package com.realman.becore.controller.api.booking.models;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.booking.Booking;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BookingModelMapper {
    Booking toDto(BookingRequest model);

    BookingResponse toModel(Booking dto);
}