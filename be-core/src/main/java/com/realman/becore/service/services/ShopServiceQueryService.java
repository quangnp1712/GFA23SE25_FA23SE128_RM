package com.realman.becore.service.services;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import com.realman.becore.controller.api.services.models.ServiceId;
import com.realman.becore.dto.branch.service.BranchService;
import com.realman.becore.dto.service.ShopService;
import com.realman.becore.dto.service.ShopServiceMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.service.ShopServiceEntity;
import com.realman.becore.repository.database.service.ShopServiceRepository;
import com.realman.becore.service.branch.service.BranchServiceUseCaseService;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopServiceQueryService {
    @NonNull
    private final BranchServiceUseCaseService branchServiceUseCaseService;
    @NonNull
    private final ShopServiceRepository shopServiceRepository;
    @NonNull
    private final ShopServiceMapper shopServiceMapper;

    public Page<ShopService> findAll(PageRequestCustom pageRequestCustom) {
        Page<ShopServiceEntity> shopServices = shopServiceRepository.findAll(pageRequestCustom.pageRequest());
        return shopServices.map(shopServiceMapper::toDto);
    }

    public ShopService findById(ServiceId serviceId) {
        ShopServiceEntity service = shopServiceRepository.findById(serviceId.value())
                .orElseThrow(ResourceNotFoundException::new);
        List<BranchService> branchServiceList = branchServiceUseCaseService.findAllByServiceId(serviceId.value());
        return shopServiceMapper.toDto(service, branchServiceList);
    }

    public List<ShopService> findByCategoryId(Long categoryId) {
        List<ShopService> categoryList = shopServiceRepository.findByCategoryId(categoryId).stream()
                .map(shopServiceMapper::toDto).toList();
        return categoryList;
    }

    public List<ShopService> findAll() {
        List<ShopService> categoryList = shopServiceRepository.findAll().stream()
                .map(shopServiceMapper::toDto).toList();
        return categoryList;
    }

}
