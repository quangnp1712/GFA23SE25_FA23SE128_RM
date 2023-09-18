package com.realman.becore.service.receptionist;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.receptionist.Receptionist;
import com.realman.becore.dto.receptionist.ReceptionistMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.receptionist.ReceptionistEntity;
import com.realman.becore.repository.database.receptionist.ReceptionistRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReceptionistCommandService {
    @NonNull
    private final ReceptionistRepository receptionistRepository;
    @NonNull
    private final ReceptionistMapper receptionistMapper;

    @Transactional
    public Long save(Receptionist receptionist) {
        ReceptionistEntity entity = receptionistRepository.save(receptionistMapper.toEntity(receptionist));
        return entity.getReceptionistId();
    }

    @Transactional
    public void updateAccountId(Long receptId, Long accountId) {
        ReceptionistEntity entity = receptionistRepository.findById(receptId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.RECEPTIONIST_NOT_FOUND.name()));
        entity.setAccountId(accountId);
        receptionistRepository.save(entity);
    }
}
