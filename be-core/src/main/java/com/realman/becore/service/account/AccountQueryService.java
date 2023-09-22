package com.realman.becore.service.account;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.LoginRequest;
import com.realman.becore.controller.api.account.models.LoginResponse;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.account_otp.AccountOtp;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.AuthFailException;
import com.realman.becore.error_handlers.exceptions.ResourceDuplicateException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.repository.database.otp.OTPEntity;
import com.realman.becore.security.jwt.JwtConfiguration;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountQueryService {
    @NonNull
    private final AccountRepository accountRepository;
    @NonNull
    private final AccountMapper accountMapper;
    @NonNull
    private final PasswordEncoder passwordEncoder;
    @NonNull
    private final JwtConfiguration jwtConfiguration;

    public Account findAccountByUsername(String username) {
        AccountEntity entity = accountRepository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        return accountMapper.toDto(entity);
    }

    public Account findAccountByPhone(String phone) {
        AccountEntity entity = accountRepository.findByPhone(phone)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name()));
        return accountMapper.toDto(entity);
    }

    public void verifyAccount(Account account) {
        if (accountRepository.findByUsername(account.username()).isPresent()) {
            throw new ResourceDuplicateException(EErrorMessage.USERNAME_DUPLICATED.name());
        }

        if (accountRepository.findByPhone(account.phone()).isPresent()) {
            throw new ResourceDuplicateException(EErrorMessage.PHONE_DUPLICATED.name());
        }
    }

    public LoginResponse login(LoginRequest loginRequest) {
        List<Object[]> query = accountRepository.findAccountAndOtpByPhone(loginRequest.phone());

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
                .build();
    }
}
