package com.realman.becore.controller.api.otp.models;

import lombok.Builder;

@Builder
public record AccountPhone(String value) {
    public AccountPhone toAccountPhone() {
        return AccountPhone.builder().value(value.replace(String.valueOf(value.charAt(0)), "+84")).build();
    }
}
