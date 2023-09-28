package com.realman.becore.dto.staff;

import com.realman.becore.enums.EProfessional;

public record Staff(
        Long staffId,
        Long accountId,
        EProfessional professional) {

}
