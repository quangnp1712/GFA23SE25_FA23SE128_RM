package com.realman.becore.service.otp;

import java.util.Random;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.otp.models.AccountPhone;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.otp.OTPMapper;
import com.realman.becore.repository.database.otp.OTPEntity;
import com.realman.becore.repository.database.otp.OTPRepository;
import com.realman.becore.service.account.AccountCommandService;
import com.realman.becore.service.account.AccountUseCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OTPCommandService {
    @NonNull
    private final OTPRepository otpRepository;
    @NonNull
    private final AccountUseCaseService accountUseCaseService;
    @NonNull
    private final AccountCommandService accountCommandService;
    @NonNull
    private final OTPMapper otpMapper;
    @NonNull
    private final PasswordEncoder passwordEncoder;

    public void save(AccountPhone accountPhone) {
        StringBuilder otpBuilder = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            otpBuilder.append(new Random().nextInt(9));
        }
        System.out.println("OTP: " + otpBuilder.toString());
        Account account = accountUseCaseService.findAccountByPhone(accountPhone.value());
        OTPEntity otpEntity = otpMapper.toEntity(passwordEncoder.encode(otpBuilder.toString()), account.accountId());
        OTPEntity savedEntity = otpRepository.save(otpEntity);
        accountCommandService.updateOTPId(account.accountId(), savedEntity.getOtpId());
        // TwilioUtil.sendOTP(accountPhone.value(), otpBuilder.toString());
    }
}
