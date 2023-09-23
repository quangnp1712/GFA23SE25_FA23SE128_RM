package com.realman.becore.service.otp;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.LoginRequest;
import com.realman.becore.controller.api.account.models.LoginResponse;
import com.realman.becore.dto.otp.OTP;
import com.realman.becore.dto.otp.OTPMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.AuthFailException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.otp.OTPEntity;
import com.realman.becore.repository.database.otp.OTPRepository;
import com.realman.becore.security.jwt.JwtConfiguration;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OTPQueryService {
    @NonNull
    private final OTPRepository otpRepository;
    @NonNull
    private final OTPMapper otpMapper;
    @NonNull
    private final PasswordEncoder passwordEncoder;
    @NonNull
    private final JwtConfiguration jwtConfiguration;

    public OTP findByAccountId(Long accountId) {
        return otpMapper.toDto(otpRepository.findByAccountId(accountId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name())));
    }

    public OTP findByPhoneAttemp(String phone) {
        return otpMapper.toDto(otpRepository.findByPhoneAttemp(phone)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name())));
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
