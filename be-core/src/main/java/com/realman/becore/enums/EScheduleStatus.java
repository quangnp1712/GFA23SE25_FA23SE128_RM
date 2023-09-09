package com.realman.becore.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EScheduleStatus {
    PRESENT(0),
    ABSENT(1),
    LATE(2),
    EXCHANGE(3);

    private Integer value;
}
