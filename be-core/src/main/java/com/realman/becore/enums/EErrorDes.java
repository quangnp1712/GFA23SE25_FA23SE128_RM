package com.realman.becore.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum EErrorDes {
    AUTH_FAILT(0),
    RESOURCE_NOT_FOUND(1),
    RESOURCE_DUPLICATED(2);

    private final Integer value;
}
