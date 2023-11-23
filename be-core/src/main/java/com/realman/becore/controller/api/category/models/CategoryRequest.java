package com.realman.becore.controller.api.category.models;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CategoryRequest(
    String title,
    @JsonProperty(value = "description")
    String categoryDescription
) {
}
