package com.realman.becore.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EBranchStatus {
    OPEN(0),
    CLOSE(1),
    FULL(2);

    private Integer value;
}
