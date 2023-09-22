package com.realman.becore.service.otp;

import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.otp.models.AccountPhone;
import com.realman.becore.dto.otp.OTP;

import jakarta.transaction.Transactional;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OTPUserCaseService {
    @NonNull
    private final OTPCommandService otpCommandService;
    @NonNull
    private final OTPQueryService otpQueryService;

    @Transactional
    public void save(AccountPhone accountPhone) {
        otpCommandService.save(accountPhone);
    }

    public OTP findByAccountId(Long accountId) {
        return otpQueryService.findByAccountId(accountId);
    }
}
