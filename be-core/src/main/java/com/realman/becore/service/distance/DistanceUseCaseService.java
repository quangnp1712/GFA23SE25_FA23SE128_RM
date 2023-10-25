package com.realman.becore.service.distance;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.distance.DistanceRequest;
import com.realman.becore.dto.distance.DistanceResponse;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DistanceUseCaseService {
    @NonNull
    private final DistanceRequestService distanceRequestService;

    public DistanceResponse requestDistance(DistanceRequest distanceRequest) {
        return distanceRequestService.requestDistanceList(distanceRequest);
    }
}
