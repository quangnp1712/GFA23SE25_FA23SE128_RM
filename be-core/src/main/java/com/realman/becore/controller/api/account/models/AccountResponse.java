package com.realman.becore.controller.api.account.models;

import java.time.LocalDateTime;

import com.realman.becore.controller.api.account.models.staff.StaffResponse;
import com.realman.becore.dto.enums.EAccountStatus;
import com.realman.becore.dto.enums.EGender;
import com.realman.becore.dto.enums.EItimacyLevel;
import com.realman.becore.dto.enums.ERole;
import lombok.Builder;

@Builder
public record AccountResponse(
                Long accountId,
                Long branchId,
                String thumbnailUrl,
                String firstName,
                String lastName,
                String phone,
                String address,
                LocalDateTime dob,
                EGender gender,
                EAccountStatus status,
                String branchName,
                String branchAddress,
                EItimacyLevel itimacyLevel,
                StaffResponse staff,
                ERole role) {

}
