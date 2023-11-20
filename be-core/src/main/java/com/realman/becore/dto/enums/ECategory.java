package com.realman.becore.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ECategory {
    HAIR_CUT(0),
    REALMAN_COMBO(1),
    MASSAGE(2);

    public final Integer value;
}
