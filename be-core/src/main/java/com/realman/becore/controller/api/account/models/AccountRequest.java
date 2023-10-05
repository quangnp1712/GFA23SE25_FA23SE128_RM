package com.realman.becore.controller.api.account.models;

import java.time.LocalDateTime;

import com.realman.becore.enums.EGender;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record AccountRequest(
        @NotNull String username,
        @NotNull String phone,
        String address,
        @Enumerated(EnumType.STRING) EGender gender,
        LocalDateTime dob) {
}
