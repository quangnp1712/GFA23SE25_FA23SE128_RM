package com.realman.becore.service.otp;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.otp.OTP;
import com.realman.becore.dto.otp.OTPMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.otp.OTPEntity;
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
        OTPEntity entity = otpRepository.findByAccountId(accountId)
                .orElse(OTPEntity.builder().passCode("99999").build());
        return otpMapper.toDto(entity);
    }

    public OTP findByPhoneAttemp(String phone) {
        OTPEntity entity = otpRepository.findByPhoneAttemp(phone)
                .orElseThrow(ResourceNotFoundException::new);
        return otpMapper.toDto(entity);
    }

}
