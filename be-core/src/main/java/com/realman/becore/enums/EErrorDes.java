package com.realman.becore.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum EErrorDes {
    AUTH_FAILT(0),
    RESOURCE_NOT_FOUND(1);

    private final Integer value;
}
