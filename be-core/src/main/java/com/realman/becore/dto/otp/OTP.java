package com.realman.becore.dto.otp;

public record OTP(
                Long otpId,
                Long accountId,
                String phoneAttemp,
                String passCode) {

}
