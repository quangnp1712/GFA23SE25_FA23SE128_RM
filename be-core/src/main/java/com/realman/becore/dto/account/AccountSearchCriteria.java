package com.realman.becore.dto.account;

import java.util.List;

import com.realman.becore.dto.enums.ERole;

import lombok.Builder;

@Builder
public record AccountSearchCriteria(
                List<String> searches,
                Long branchId,
                ERole role) {

}
