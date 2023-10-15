package com.realman.becore.service.customer;

import org.springframework.stereotype.Service;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerUseCaseService {
    @NonNull
    private final CustomerCommandService customerCommandService;
    @NonNull
    private final CustomerQueryService customerQueryService;

   
}
