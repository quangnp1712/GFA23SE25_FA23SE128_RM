package com.realman.becore.service.receptionist;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.receptionist.Receptionist;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReceptionistUseCaseService {
    @NonNull
    private final ReceptionistCommandService receptionistCommandService;

    public Long save(Receptionist receptionist) {
        return receptionistCommandService.save(receptionist);
    }

    public void updateAccountId(Long receptId, Long accountId) {
        receptionistCommandService.updateAccountId(receptId, accountId);
    }

}
