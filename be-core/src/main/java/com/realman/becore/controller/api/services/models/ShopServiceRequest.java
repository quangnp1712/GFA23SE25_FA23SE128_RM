package com.realman.becore.controller.api.services.models;

public record ShopServiceRequest(
    String name,
    String description,
    Integer duration
) {
    
}
