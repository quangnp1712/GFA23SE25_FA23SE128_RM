package com.realman.becore.controller.api.services.models;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ShopServiceFieldResponse(
                Long serviceId,
                @JsonProperty("name") String serviceName) {
}
