package com.realman.becore.dto.account;

import java.time.LocalDateTime;

import com.realman.becore.enums.EGender;
import com.realman.becore.enums.ERole;

public record Account(
                Long id,
                String username,
                String password,
                String phone,
                String address,
                LocalDateTime dob,
                EGender gender,
                ERole role) {

}
