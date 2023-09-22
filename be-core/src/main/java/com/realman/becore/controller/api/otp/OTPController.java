package com.realman.becore.controller.api.otp;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.otp.models.AccountPhone;
import com.realman.becore.service.otp.OTPUserCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class OTPController implements OTPAPI {
    @NonNull
    public OTPUserCaseService otpUserCaseService;

    @Override
    public void save(AccountPhone phone) {
        otpUserCaseService.save(phone);

    }

}
