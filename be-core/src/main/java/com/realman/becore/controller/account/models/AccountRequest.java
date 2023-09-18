package com.realman.becore.controller.account.models;

import java.time.LocalDateTime;

import com.realman.becore.enums.EGender;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;

public record AccountRequest(
                String username,
                String phone,
                String address,
                @Enumerated(EnumType.STRING) EGender gender,
                LocalDateTime dob) {

}
