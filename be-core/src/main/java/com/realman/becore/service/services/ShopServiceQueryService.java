package com.realman.becore.service.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.service.ShopService;
import com.realman.becore.repository.database.service.ShopServiceRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopServiceQueryService {
    @NonNull
    private final ShopServiceRepository shopServiceRepository;

    // public List<ShopService> findAll() {
        
    // }
}
