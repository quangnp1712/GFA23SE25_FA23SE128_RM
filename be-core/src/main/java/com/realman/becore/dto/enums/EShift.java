package com.realman.becore.dto.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EShift {
    DAY(0),
    NIGHT(1);

    private Integer value;
}
