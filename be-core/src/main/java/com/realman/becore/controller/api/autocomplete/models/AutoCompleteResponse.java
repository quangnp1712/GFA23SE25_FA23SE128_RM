package com.realman.becore.controller.api.autocomplete.models;

import java.util.List;

import lombok.Builder;

@Builder
public record AutoCompleteResponse(
    List<Prediction> predictions
) {
    
}
