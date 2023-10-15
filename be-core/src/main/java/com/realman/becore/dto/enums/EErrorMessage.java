package com.realman.becore.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum EErrorMessage {
    JWT_NOT_VALID(0),
    AUTHENTICATION_FAIL(1),
    RESOURCE_NOT_FOUND(2),
    RESOURCE_DUPLICATED(3);

    private final Integer value;
}
