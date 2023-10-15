package com.realman.becore.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EAccountStatus {
    ACTIVATED(0),
    SUSPENDED(1);

    private final Integer value;
}
