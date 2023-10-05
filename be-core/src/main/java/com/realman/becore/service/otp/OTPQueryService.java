package com.realman.becore.service.otp;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.otp.OTP;
import com.realman.becore.dto.otp.OTPMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.otp.OTPRepository;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OTPQueryService {
    @NonNull
    private final OTPRepository otpRepository;
    @NonNull
    private final OTPMapper otpMapper;

    public OTP findByAccountId(Long accountId) {
        return otpMapper.toDto(otpRepository.findByAccountId(accountId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name())));
    }

    public OTP findByPhoneAttemp(String phone) {
        return otpMapper.toDto(otpRepository.findByPhoneAttemp(phone)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name())));
    }

    public OTP validPassCode(Long otpId, String passCode) {
        return otpMapper.toDto(otpRepository.findById(otpId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ACCOUNT_NOT_FOUND.name())));
    }

}
