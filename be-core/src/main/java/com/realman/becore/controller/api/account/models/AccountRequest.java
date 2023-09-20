package com.realman.becore.controller.api.account.models;

import java.time.LocalDateTime;

import com.realman.becore.enums.EGender;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Builder;

@Builder
public record AccountRequest(
        String username,
        String phone,
        String address,
        @Enumerated(EnumType.STRING) EGender gender,
        LocalDateTime dob) {
    public AccountRequest toAccountRequest() {
        return AccountRequest.builder()
                .username(username)
                .phone(phone.replace(String.valueOf(phone.charAt(0)), "+84"))
                .address(address)
                .gender(gender)
                .dob(dob)
                .build();
    }
}
