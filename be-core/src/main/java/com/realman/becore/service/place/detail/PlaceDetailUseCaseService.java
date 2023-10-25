package com.realman.becore.service.place.detail;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.place.detail.PlaceDetailRequest;
import com.realman.becore.dto.place.detail.PlaceDetailResponse;

@Service
@RequiredArgsConstructor
public class PlaceDetailUseCaseService {
    
    @NonNull
    private final PlaceDetailRequestService placeDetailRequestService;

    public PlaceDetailResponse requestPlaceDetail(PlaceDetailRequest request) {
        return placeDetailRequestService.requestPlaceDetail(request);
    }

}
