package com.realman.becore.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EBookingServiceStatus {
    ONGOING(1),
    PROCESSING(2),
    FINISHED(3);

    private final Integer value;
}
