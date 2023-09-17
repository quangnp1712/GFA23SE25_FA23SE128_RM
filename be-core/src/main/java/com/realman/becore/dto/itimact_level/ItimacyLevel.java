package com.realman.becore.dto.itimact_level;

import com.realman.becore.enums.EItimacyLevel;

public record ItimacyLevel(
        Long itimacyId,
        Long requirePoint,
        EItimacyLevel itimacyLevel,
        Integer percentDiscount) {

}
