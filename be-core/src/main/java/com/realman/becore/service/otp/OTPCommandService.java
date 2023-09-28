package com.realman.becore.service.otp;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Random;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.LoginRequest;
import com.realman.becore.controller.api.account.models.LoginResponse;
import com.realman.becore.controller.api.otp.models.AccountPhone;
import com.realman.becore.dto.otp.OTP;
import com.realman.becore.dto.otp.OTPMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.AuthFailException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.otp.OTPEntity;
import com.realman.becore.repository.database.otp.OTPRepository;
import com.realman.becore.security.jwt.JwtConfiguration;
import com.realman.becore.service.account.AccountCommandService;
import com.realman.becore.service.account.AccountUseCaseService;
import com.realman.becore.util.TwilioUtil;

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
    @NonNull
    private final JwtConfiguration jwtConfiguration;

    public OTP save(AccountPhone accountPhone) {
        StringBuilder otpBuilder = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            otpBuilder.append(new Random().nextInt(9));
        }
        // System.out.println("OTP: " + otpBuilder.toString());
        OTPEntity otpEntity = otpMapper.toEntity(passwordEncoder.encode(otpBuilder.toString()), accountPhone.value());
        OTPEntity entity = otpRepository.save(otpEntity);
        TwilioUtil.sendOTP(accountPhone.value(), otpBuilder.toString());
        return otpMapper.toDto(entity);
    }

    public LoginResponse login(LoginRequest loginRequest) {
        List<Object[]> query = otpRepository.findAccountAndOtpByPhone(loginRequest.phone());
        if (query.isEmpty() || Objects.isNull(query)) {
            return LoginResponse.builder()
                    .username(null)
                    .jwtToken(null)
                    .expTime(null)
                    .role(null)
                    .isPhoneRegistered(false)
                    .build();
        }
        AccountEntity accountEntity = (AccountEntity) query.get(0)[0];
        OTPEntity otpEntity = (OTPEntity) query.get(0)[1];
        if (!passwordEncoder.matches(loginRequest.passCode(),
                otpEntity.getPassCode())) {
            throw new AuthFailException(EErrorMessage.ACCOUNT_NOT_VALID.name());
        }
        otpRepository.delete(otpEntity);
        String jwtToken = jwtConfiguration.generateJwt(accountEntity.getUsername());
        LocalDateTime expiredTime = jwtConfiguration.expireTime();
        return LoginResponse.builder()
                .username(accountEntity.getUsername())
                .jwtToken(jwtToken)
                .expTime(expiredTime)
                .role(accountEntity.getRole())
                .isPhoneRegistered(true)
                .build();
    }

}
