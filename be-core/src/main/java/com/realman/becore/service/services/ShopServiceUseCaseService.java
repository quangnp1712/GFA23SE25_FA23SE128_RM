package com.realman.becore.service.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.controller.api.services.models.ServiceId;
import com.realman.becore.dto.service.ShopService;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopServiceUseCaseService {
    @NonNull
    private final ShopServiceCommandService shopServiceCommandService;
    @NonNull
    private final ShopServiceQueryService shopServiceQueryService;

    @Transactional
    public void save(ShopService service) {
        shopServiceCommandService.save(service);
    }

    @Transactional
    public void update(Long serviceId, ShopService shopService) {
        shopServiceCommandService.update(serviceId, shopService);
    }

    public Page<ShopService> findAll(PageRequestCustom pageRequestCustom) {
        return shopServiceQueryService.findAll(pageRequestCustom);
    }

    public List<ShopService> findAllServiceField() {
        return shopServiceQueryService.findAllServiceField();
    }

    public ShopService findByServiceId(ServiceId serviceId) {
        return shopServiceQueryService.findById(serviceId);
    }
}
