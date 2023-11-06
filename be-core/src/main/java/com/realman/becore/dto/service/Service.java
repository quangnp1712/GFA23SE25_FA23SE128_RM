package com.realman.becore.dto.service;

import com.realman.becore.custom_constrain.text.NormalText;

import jakarta.validation.constraints.Min;

public record Service(
    @NormalText String name,
    @Min(1) Integer estimateTime
) {
    
}
