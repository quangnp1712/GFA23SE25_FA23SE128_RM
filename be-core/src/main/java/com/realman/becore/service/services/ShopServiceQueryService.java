package com.realman.becore.service.services;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import com.realman.becore.controller.api.services.models.ServiceId;
import com.realman.becore.dto.branch.service.BranchService;
import com.realman.becore.dto.service.ShopService;
import com.realman.becore.dto.service.ShopServiceMapper;
import com.realman.becore.dto.service.display.ServiceDisplay;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.service.ShopServiceEntity;
import com.realman.becore.repository.database.service.ShopServiceRepository;
import com.realman.becore.service.branch.service.BranchServiceUseCaseService;
import com.realman.becore.service.services.display.ServiceDisplayUseCaseService;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopServiceQueryService {
    @NonNull
    private final ShopServiceRepository shopServiceRepository;
    @NonNull
    private final BranchServiceUseCaseService branchServiceUseCaseService;
    @NonNull
    private final ServiceDisplayUseCaseService serviceDisplayUseCaseService;
    @NonNull
    private final ShopServiceMapper shopServiceMapper;

    public Page<ShopService> findAll(PageRequestCustom pageRequestCustom) {
        Page<ShopServiceEntity> shopServices = shopServiceRepository.findAll(pageRequestCustom.pageRequest());
        Map<Long, List<ServiceDisplay>> serviceDisplayMap = serviceDisplayUseCaseService.findAll()
                .stream().collect(Collectors.groupingBy(ServiceDisplay::serviceId));
        return shopServices.map(shopService -> shopServiceMapper.toDtoServiceDisplayList(shopService,
                serviceDisplayMap.get(shopService.getServiceId())));
    }

    public ShopService findById(ServiceId serviceId) {
        ShopServiceEntity service = shopServiceRepository.findById(serviceId.value())
                .orElseThrow(ResourceNotFoundException::new);
        Map<Long, List<ServiceDisplay>> serviceDisplayMap = serviceDisplayUseCaseService
                .findByServiceId(serviceId.value())
                .stream().collect(Collectors.groupingBy(ServiceDisplay::serviceId));
        List<BranchService> branchServiceList = branchServiceUseCaseService.findAllByServiceId(serviceId.value());
        return shopServiceMapper.toDto(service, branchServiceList, serviceDisplayMap.get(serviceId.value()));
    }

    public List<ShopService> findByCategoryId(Long categoryId) {
        Map<Long, List<ServiceDisplay>> serviceDisplayMap = serviceDisplayUseCaseService.findAll()
                .stream().collect(Collectors.groupingBy(ServiceDisplay::serviceId));
        List<ShopService> categoryList = shopServiceRepository.findByCategoryId(categoryId).stream()
                .map(shopService -> shopServiceMapper
                        .toDtoServiceDisplayList(shopService, serviceDisplayMap.get(shopService.getServiceId())))
                .toList();
        return categoryList;
    }

    public List<ShopService> findAll() {
        Map<Long, List<ServiceDisplay>> serviceDisplayMap = serviceDisplayUseCaseService.findAll()
                .stream().collect(Collectors.groupingBy(ServiceDisplay::serviceId));
        List<ShopService> categoryList = shopServiceRepository.findAll().stream()
                .map(shopService -> shopServiceMapper
                        .toDtoServiceDisplayList(shopService, serviceDisplayMap.get(shopService.getServiceId())))
                .toList();
        return categoryList;
    }

}
