package com.realman.becore.controller.api.account.models;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum ERoleRequest {
    CUSTOMER(0),
    STAFF_MESSEUR(1),
    STAFF_STYLIST(2),
    RECEPTIONIST(3),
    BRANCH_MANAGER(4),
    SHOP_OWNER(5);

    public final Integer value;
}
