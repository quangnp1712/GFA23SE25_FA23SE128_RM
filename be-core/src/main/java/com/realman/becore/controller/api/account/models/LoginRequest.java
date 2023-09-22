package com.realman.becore.controller.api.account.models;

import lombok.Builder;

@Builder
public record LoginRequest(
        String phone,
        String passCode) {

}
