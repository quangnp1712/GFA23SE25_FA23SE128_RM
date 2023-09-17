package com.realman.becore.service.itimacy;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.itimact_level.ItimacyLevelMapper;
import com.realman.becore.dto.itimacy.Itimacy;
import com.realman.becore.dto.itimacy.ItimacyMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.enums.EItimacyLevel;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.itimacty_level.ItimacyLevelEntity;
import com.realman.becore.repository.database.itimacy.ItimacyEntity;
import com.realman.becore.repository.database.itimacy.ItimacyRepository;
import com.realman.becore.service.itimacty_level.ItimacyLevelUsecaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ItimacyCommandService {
    @NonNull
    private final ItimacyRepository itimacyRepository;

    @NonNull
    private final ItimacyLevelUsecaseService itimacyLevelUsecaseService;

    @NonNull
    private final ItimacyLevelMapper itimacyLevelMapper;

    @NonNull
    private final ItimacyMapper itimacyMapper;

    @Transactional
    public Long save(Itimacy itimacy) {
        ItimacyEntity entity = itimacyMapper.toEntity(itimacy);
        ItimacyLevelEntity itimacyLevelEntity = new ItimacyLevelEntity();
        itimacyLevelEntity.setItimacyLevel(EItimacyLevel.LEVEL_1);
        Long itimacyLevelId = itimacyLevelUsecaseService.save(itimacyLevelMapper.toDto(itimacyLevelEntity));
        entity.setItimacyLevelId(itimacyLevelId);

        ItimacyEntity savedEntity = itimacyRepository.save(entity);
        itimacyLevelUsecaseService.updateItimacyId(itimacyLevelId, savedEntity.getItimacyId());
        return savedEntity.getItimacyId();
    }

    @Transactional
    public void updateCustomerId(Long itimacyId, Long customerId) {
        ItimacyEntity entity = itimacyRepository.findById(itimacyId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.ITIMACY_NOT_FOUNT.name()));
        entity.setCustomerId(customerId);
        itimacyRepository.save(entity);
    }

}
