package com.realman.becore.service.place.detail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;

import com.realman.becore.dto.place.detail.PlaceDetailRequest;
import com.realman.becore.dto.place.detail.PlaceDetailResponse;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PlaceDetailRequestService {

        @Value("${goong.api.key}")
        private String apiKey;

        @Value("${goong.place.detail}")
        private String placeDetailRequestUrl;

        @NonNull
        private final RestTemplate restTemplate;

        public PlaceDetailResponse requestPlaceDetail(PlaceDetailRequest request) {
                StringBuilder requestBuilder = new StringBuilder(placeDetailRequestUrl);
                String sessionToken = RequestContextHolder.currentRequestAttributes()
                                .getSessionId();
                String requestUrl = requestBuilder
                                .append("?api_key=").append(apiKey)
                                .append("&place_id=").append(request.placeId())
                                .append("&session_token=").append(sessionToken)
                                .toString();
                PlaceDetailResponse resposne = restTemplate
                                .getForObject(requestUrl, PlaceDetailResponse.class);
                return resposne;
        }

}
