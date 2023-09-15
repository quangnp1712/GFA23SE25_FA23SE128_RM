package com.realman.becore.controller.account.models;

import java.time.LocalDateTime;

import com.realman.becore.enums.EGender;

public record AccountRequest(
                String username,
                String phone,
                String address,
                EGender gender,
                LocalDateTime dob) {

}
