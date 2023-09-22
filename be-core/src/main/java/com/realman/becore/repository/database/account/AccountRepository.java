package com.realman.becore.repository.database.account;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.account_otp.AccountOtp;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {
    Optional<AccountEntity> findByUsername(String username);

    Optional<AccountEntity> findByPhone(String phone);

    @Query("""
                SELECT a, o FROM AccountEntity a INNER JOIN OTPEntity o ON a.otpId = o.otpId
                WHERE a.phone = :phone
            """)
    List<Object[]> findAccountAndOtpByPhone(String phone);
}
