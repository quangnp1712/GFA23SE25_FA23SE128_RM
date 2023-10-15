package com.realman.becore.service.itimacy.level;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.enums.EItimacyLevel;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.itimacty_level.ItimacyLevelEntity;
import com.realman.becore.repository.database.itimacty_level.ItimacyLevelRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ItimacyLevelQueryService {
    @NonNull
    private final ItimacyLevelRepository itimacyLevelRepository;

    public ItimacyLevelEntity findByItimacy(EItimacyLevel itimacyLevel) {
        return itimacyLevelRepository.findByItimacyLevel(itimacyLevel)
                .orElseThrow(ResourceNotFoundException::new);
    }
}
