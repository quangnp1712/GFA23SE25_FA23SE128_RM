package com.realman.becore.service.itimacty_level;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.itimact_level.ItimacyLevel;
import com.realman.becore.dto.itimact_level.ItimacyLevelMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.itimacty_level.ItimacyLevelEntity;
import com.realman.becore.repository.database.itimacty_level.ItimacyLevelRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ItimacyLevelCommandService {
    @NonNull
    private final ItimacyLevelRepository itimacyLevelRepository;

    @NonNull
    private final ItimacyLevelMapper itimacyLevelMapper;

    @Transactional
    Long save(ItimacyLevel itimacty) {
        ItimacyLevelEntity entity = itimacyLevelRepository.save(itimacyLevelMapper.toEntity(itimacty));
        return entity.getItimactyLevelId();
    }

    @Transactional
    void updateItimacyId(Long itimacyLevelId, Long itimacyId) {
        ItimacyLevelEntity entity = itimacyLevelRepository.findById(itimacyLevelId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ITIMACY_LEVEL_NOT_FOUNT.name()));
        entity.setItimacyId(itimacyId);
        itimacyLevelRepository.save(entity);
    }
}
