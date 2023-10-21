package com.realman.becore.controller.api.autocomplete.models;

import lombok.Builder;

@Builder
public record Prediction(
    String description,
    String place_id
) {

}
