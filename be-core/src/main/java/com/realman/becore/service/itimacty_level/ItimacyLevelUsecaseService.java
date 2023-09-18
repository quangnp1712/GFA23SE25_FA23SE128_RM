package com.realman.becore.service.itimacty_level;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.itimact_level.ItimacyLevel;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ItimacyLevelUsecaseService {

    @NonNull
    private final ItimacyLevelCommandService itimacyLevelCommandService;

    public Long save(ItimacyLevel itimacyLevel) {
        return itimacyLevelCommandService.save(itimacyLevel);
    }

    public void updateItimacyId(Long itimacyLevelId, Long ItimacyId) {
        itimacyLevelCommandService.updateItimacyId(itimacyLevelId, ItimacyId);
    }
}
