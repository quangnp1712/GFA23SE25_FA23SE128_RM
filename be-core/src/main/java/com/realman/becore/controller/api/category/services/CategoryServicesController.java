package com.realman.becore.controller.api.category.services;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.category.services.models.CategorySeriviceId;
import com.realman.becore.service.category.services.CategoryServiceUseCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class CategoryServicesController implements CategoryServicesAPI {
    @NonNull
    private final CategoryServiceUseCaseService categoryServiceUseCaseService;

    @Override
    public void save(CategorySeriviceId categorySeriviceId) {
        categoryServiceUseCaseService.save(categorySeriviceId.categoryId(), categorySeriviceId.serviceId());
    }
    
}
