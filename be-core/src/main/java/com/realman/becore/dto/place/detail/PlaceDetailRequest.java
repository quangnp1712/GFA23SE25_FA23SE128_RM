package com.realman.becore.dto.place.detail;

import lombok.Builder;

@Builder
public record PlaceDetailRequest(
    String placeId
) {
    
}
