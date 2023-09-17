package com.realman.becore.service.itimacy;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.itimacy.Itimacy;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ItimacyUsercaseService {
    @NonNull
    private final ItimacyCommandService itimacyCommandService;

    public Long save(Itimacy itimacy) {
        return itimacyCommandService.save(itimacy);
    }

    public void updateCustomerId(Long itimacyId, Long customerId) {
        itimacyCommandService.updateCustomerId(itimacyId, customerId);
    }
}
