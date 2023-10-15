package com.realman.becore.dto.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EPermission {
    BOOKING_VIEW("booking:view"),
    BOOKING_ADD("booking:add"),
    BOOKING_UPDATE("booking:update"),
    BOOKING_CANCLE("booking:cancle"),
    SCHEDULE_VIEW("schedule:view"),
    SCHEDULE_ADD("schedule:add"),
    SCHEDULE_UPDATE("schedule:update"),
    STAFF_VIEW("staff:view"),
    STAFF_ADD("staff:add"),
    STAFF_UPDATE("staff:update"),
    BRANCH_VIEW("branch:view"),
    BRANCH_ADD("branch:add"),
    BRANCH_UPDATE("branch:update");

    private String permission;
}
