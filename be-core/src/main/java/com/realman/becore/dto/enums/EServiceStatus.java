package com.realman.becore.dto.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EServiceStatus {
    OPEN(0),
    CLOSE(1);

    private Integer value;
}
