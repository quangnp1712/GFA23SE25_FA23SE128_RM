package com.realman.becore.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EGender {
    MALE(0),
    FEMALE(1);

    private Integer value;
}
