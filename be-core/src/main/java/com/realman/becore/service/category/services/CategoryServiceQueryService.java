package com.realman.becore.service.category.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.category.services.CategoryService;
import com.realman.becore.dto.category.services.CategoryServiceMapper;
import com.realman.becore.repository.database.category.services.CategoryServiceRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceQueryService {
    @NonNull
    private final CategoryServiceRepository categoryServiceRepository;
    @NonNull
    private final CategoryServiceMapper categoryServiceMapper;

    public List<CategoryService> findAll() {
        List<CategoryService> categoryServiceList = categoryServiceRepository.findAllInfo().stream()
                .map(categoryServiceMapper::toDto).toList();
        return categoryServiceList;
    }

    public List<CategoryService> findByCategoryId(Long categoryId) {
        List<CategoryService> categoryServiceList = categoryServiceRepository.findByCategoryId(categoryId)
                .stream().map(categoryServiceMapper::toDto).toList();
        return categoryServiceList;
    }
}
