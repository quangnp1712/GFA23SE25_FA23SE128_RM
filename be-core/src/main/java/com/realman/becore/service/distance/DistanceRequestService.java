package com.realman.becore.service.distance;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.realman.becore.dto.distance.DistanceRequest;
import com.realman.becore.dto.distance.DistanceResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DistanceRequestService {

    @Value("${goong.api.key}")
    private String apiKey;

    @Value("${goong.distance}")
    private String distanceRequestUrl;

    @NonNull
    private final RestTemplate restTemplate;

    public DistanceResponse requestDistanceList(DistanceRequest distanceRequest) {
        StringBuilder requestBuilder = new StringBuilder(distanceRequestUrl);
        String requestUrl = requestBuilder.append("?api_key=").append(apiKey)
                .append("&origins=").append(distanceRequest.origin())
                .append("&destinations=").append(distanceRequest.destination())
                .append("&vehicle=").append(distanceRequest.vehicle()).toString();
        DistanceResponse response = restTemplate.getForObject(requestUrl, DistanceResponse.class);
        return response;
    }
}
