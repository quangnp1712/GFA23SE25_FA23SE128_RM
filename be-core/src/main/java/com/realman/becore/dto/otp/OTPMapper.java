package com.realman.becore.dto.otp;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.otp.OTPEntity;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface OTPMapper {
    @Mapping(source = "passCode", target = "passCode")
    OTPEntity toEntity(OTP otp, String passCode);
}
