package com.realman.becore.service.receptionist;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.receptionist.Receptionist;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReceptionistUseCaseService {
    @NonNull
    private final ReceptionistCommandService receptionistCommandService;
    @NonNull
    private final ReceptionistQueryService receptionistQueryService;

    @Transactional
    public Long save(Receptionist receptionist) {
        return receptionistCommandService.save(receptionist);
    }

    @Transactional
    public void updateAccountId(Long receptId, Long accountId) {
        receptionistCommandService.updateAccountId(receptId, accountId);
    }

    public Receptionist findByAccountId(Long accountId) {
        return receptionistQueryService.findByAccountId(accountId);
    }

}
