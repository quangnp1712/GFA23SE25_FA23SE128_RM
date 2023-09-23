package com.realman.becore.dto.account_otp;

import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.otp.OTPEntity;

import lombok.Data;

@Data
public class AccountOtp {
        private AccountEntity accountEntity;
        private OTPEntity otpEntity;
}
