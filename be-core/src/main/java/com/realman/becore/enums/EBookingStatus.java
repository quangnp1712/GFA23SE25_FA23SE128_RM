package com.realman.becore.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EBookingStatus {
    PENDING(0),
    ACCEPTED(1),
    REJECTED(2),
    ABORTED(3);

    private Integer value;
}
