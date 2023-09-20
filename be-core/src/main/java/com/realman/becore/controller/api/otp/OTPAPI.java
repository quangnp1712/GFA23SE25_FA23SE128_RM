package com.realman.becore.controller.api.otp;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.realman.becore.controller.api.otp.models.AccountPhone;

import io.swagger.v3.oas.annotations.tags.Tag;

@RequestMapping("/v1/otp")
@Tag(name = "OTP")
public interface OTPAPI {

    @PostMapping
    void save(@RequestBody AccountPhone phone);
}
