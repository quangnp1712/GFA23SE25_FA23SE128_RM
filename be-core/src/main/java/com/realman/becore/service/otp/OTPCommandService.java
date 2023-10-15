package com.realman.becore.service.otp;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.AccountId;
import com.realman.becore.controller.api.account.models.LoginRequest;
import com.realman.becore.controller.api.account.models.LoginResponse;
import com.realman.becore.controller.api.otp.models.AccountPhone;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.otp.OTPMapper;
import com.realman.becore.error_handlers.exceptions.AuthFailException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.otp.OTPEntity;
import com.realman.becore.repository.database.otp.OTPRepository;
import com.realman.becore.repository.database.otp.OTPEntity.OTPEntityBuilder;
import com.realman.becore.security.jwt.JwtConfiguration;
import com.realman.becore.service.account.AccountQueryService;
import com.realman.becore.util.TwilioUtil;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OTPCommandService {
    @NonNull
    private final OTPRepository otpRepository;
    @NonNull
    private final AccountQueryService accountQueryService;
    @NonNull
    private final OTPMapper otpMapper;
    @NonNull
    private final PasswordEncoder passwordEncoder;
    @NonNull
    private final JwtConfiguration jwtConfiguration;

    public void save(AccountPhone accountPhone) {
        Optional<OTPEntity> otpExisted = otpRepository.findByPhoneAttemp(accountPhone.value());
        if (otpExisted.isPresent()) {
            otpRepository.delete(otpExisted.get());
        }
        StringBuilder passCodeBuilder = new StringBuilder();
        OTPEntityBuilder entityBuilder = OTPEntity.builder();
        for (int i = 0; i < 5; i++) {
            passCodeBuilder.append(new Random().nextInt(9));
        }
        Account account = accountQueryService.findByPhone(accountPhone.value());
        entityBuilder
                .accountId(account.accountId())
                .phoneAttemp(accountPhone.value())
                .passCode(passwordEncoder.encode(passCodeBuilder.toString()))
                .expTime(15)
                .isAvailable(true);
        otpRepository.save(entityBuilder.build());
        TwilioUtil.sendOTP(accountPhone.value(), passCodeBuilder.toString());
    }

    public Boolean accountRegister(AccountPhone accountPhone) {

        Boolean isExist = accountQueryService
                .isAccountExist(accountPhone.value());
        if (isExist) {
            Optional<OTPEntity> otpExisted = otpRepository.findByPhoneAttemp(accountPhone.value());
            if (otpExisted.isPresent()) {
                otpRepository.delete(otpExisted.get());
            }
            StringBuilder passCodeBuilder = new StringBuilder();
            OTPEntityBuilder entityBuilder = OTPEntity.builder();
            for (int i = 0; i < 5; i++) {
                passCodeBuilder.append(new Random().nextInt(9));
            }
            Account account = accountQueryService.findByPhone(accountPhone.value());
            entityBuilder
                    .accountId(account.accountId())
                    .phoneAttemp(accountPhone.value())
                    .passCode(passwordEncoder.encode(passCodeBuilder.toString()))
                    .expTime(15)
                    .isAvailable(true);
            otpRepository.save(entityBuilder.build());
            TwilioUtil.sendOTP(accountPhone.value(), passCodeBuilder.toString());
        }

        return isExist;
    }

    public LoginResponse login(LoginRequest loginRequest) {
        OTPEntity otpEntity = otpRepository
                .findByPhoneAttemp(loginRequest.phone())
                .orElseThrow(ResourceNotFoundException::new);
        Account account = accountQueryService.findById(
                new AccountId(otpEntity.getAccountId()));
        if (!passwordEncoder
                .matches(loginRequest.passCode(), otpEntity.getPassCode())) {
            throw new AuthFailException();
        }
        otpRepository.delete(otpEntity);
        String jwtToken = jwtConfiguration.generateJwt(account.phone());
        LocalDateTime expiredTime = jwtConfiguration.expireTime();
        return LoginResponse.builder()
                .phone(account.phone())
                .jwtToken(jwtToken)
                .expTime(expiredTime)
                .role(account.role())
                .isPhoneRegistered(true)
                .build();
    }

}
