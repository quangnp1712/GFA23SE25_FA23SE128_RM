package com.realman.becore.controller.api.services.models;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ShopServiceRequest(
    String name,
    Long categoryId,
    @JsonProperty(value = "description")
    String serviceDescription,
    Integer duration
) {
    
}
