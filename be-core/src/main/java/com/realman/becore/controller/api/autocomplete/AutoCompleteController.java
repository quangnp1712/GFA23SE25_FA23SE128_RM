package com.realman.becore.controller.api.autocomplete;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.autocomplete.models.AutoCompleteRequest;
import com.realman.becore.controller.api.autocomplete.models.AutoCompleteResponse;
import com.realman.becore.service.autocomplete.AutoCompleteUseCaseService;
import com.realman.becore.util.response.ValueResponse;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AutoCompleteController implements AutoCompleteAPI {

    @NonNull
    private AutoCompleteUseCaseService autoCompleteUseCaseService;

    @Override
    public ValueResponse<AutoCompleteResponse> requestPlaces(String address,
            Integer limit, Integer radius, Boolean moreCompound) {
        AutoCompleteRequest request = AutoCompleteRequest.builder()
                .input(address)
                .limit(limit)
                .radius(radius)
                .moreCompound(moreCompound)
                .build();
        AutoCompleteResponse response = autoCompleteUseCaseService.requestPlaces(request);
        return new ValueResponse<AutoCompleteResponse>(response);
    }

}
