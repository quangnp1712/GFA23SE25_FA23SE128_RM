package com.realman.becore.service.category.services;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.category.services.CategoryService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceUseCaseService {
    @NonNull
    private final CategoryServiceCommandService categoryServiceCommandService;
    @NonNull
    private final CategoryServiceQueryService categoryServiceQueryService;

    @Transactional
    public void save(Long categoryId, Long serviceId) {
        categoryServiceCommandService.save(categoryId, serviceId);
    }

    public List<CategoryService> findAll() {
        return categoryServiceQueryService.findAll();
    }

    public List<CategoryService> findByCategoryId(Long categoryId) {
        return categoryServiceQueryService.findByCategoryId(categoryId);
    }
}
