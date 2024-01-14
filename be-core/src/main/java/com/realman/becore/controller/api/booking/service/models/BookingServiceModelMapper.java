package com.realman.becore.controller.api.booking.service.models;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.dto.booking.service.BookingService;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BookingServiceModelMapper {
    BookingServiceResponse toModel(BookingService dto);
}
