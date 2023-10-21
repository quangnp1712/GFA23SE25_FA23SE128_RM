package com.realman.becore.controller.api.account.models;

import java.util.List;

import com.realman.becore.dto.enums.ERole;

import lombok.Builder;

@Builder
public record AccountSearchCriteria(
    List<String> searches,
    ERole role
) {
    
}
