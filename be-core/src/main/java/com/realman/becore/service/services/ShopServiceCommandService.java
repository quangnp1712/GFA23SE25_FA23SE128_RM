package com.realman.becore.service.services;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.enums.EServiceStatus;
import com.realman.becore.dto.service.ShopService;
import com.realman.becore.dto.service.ShopServiceMapper;
import com.realman.becore.repository.database.service.ShopServiceEntity;
import com.realman.becore.repository.database.service.ShopServiceRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopServiceCommandService {
    @NonNull
    private final ShopServiceRepository shopServiceRepository;
    @NonNull
    private final ShopServiceMapper shopServiceMapper;
 
    public void save(ShopService shopService){
        ShopServiceEntity entity = shopServiceMapper.toEntity(shopService, EServiceStatus.ACTIVATING);
        shopServiceRepository.save(entity);
    }
}
