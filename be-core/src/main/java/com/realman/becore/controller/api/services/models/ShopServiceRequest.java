package com.realman.becore.controller.api.services.models;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ShopServiceRequest(
        @JsonProperty("name") String serviceName,
        Long categoryId,
        @JsonProperty(value = "description") String serviceDescription,
        List<ServiceDisplayRequest> serviceDisplayList,
        Integer duration) {

}
