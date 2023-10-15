package com.realman.becore.service.branch;

import org.springframework.stereotype.Service;

import com.realman.becore.repository.database.branch.BranchRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchCommandService {
    @NonNull
    private final BranchRepository branchRepository;

    
}
