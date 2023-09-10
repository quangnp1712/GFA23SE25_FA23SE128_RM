package com.realman.becore.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EItimacyLevel {
    LEVEL_1(0),
    LEVEL_2(1),
    LEVEL_3(2);

    private Integer value;
}
