package com.realman.becore.dto.service;

import java.util.List;

import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.enums.EServiceStatus;

public record ShopService(
    String name,
    String description,
    Integer duration,
    EServiceStatus status,
    List<Branch> branchList
) {
    
}
