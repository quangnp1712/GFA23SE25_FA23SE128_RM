package com.realman.becore.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum EProfessional {
    STYLIST(0),
    MASSEUR(1);

    public final Integer value;
}
