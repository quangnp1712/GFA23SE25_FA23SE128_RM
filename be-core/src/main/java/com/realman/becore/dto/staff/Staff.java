package com.realman.becore.dto.staff;

import com.realman.becore.enums.EStaffProfession;

public record Staff(
        Long staffId,
        Long accountId,
        EStaffProfession profession) {

}
