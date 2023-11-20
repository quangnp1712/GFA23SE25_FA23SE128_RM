package com.realman.becore.service.shift;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.shift.Shift;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShiftUseCaseService {
    @NonNull
    private final ShiftCommandService shiftCommandService;
    @NonNull
    private final ShiftQueryService shiftQueryService;

    @Transactional
    public void saveAll() {
        shiftCommandService.saveAll();
    }

    public Shift findById(Long shiftId) {
        return shiftQueryService.findById(shiftId);
    }
}
