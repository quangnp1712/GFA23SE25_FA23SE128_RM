package com.realman.becore.dto.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EBookingStatus {
    ONGOING(0),
    PROCESSING(1),
    FINISHED(2),
    PENDING(3),
    CANCLED(4);

    private Integer value;
}
