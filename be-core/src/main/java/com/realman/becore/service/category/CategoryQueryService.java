package com.realman.becore.service.category;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.category.Category;
import com.realman.becore.dto.category.CategoryMapper;
import com.realman.becore.dto.category.services.CategoryService;
import com.realman.becore.dto.service.ShopService;
import com.realman.becore.dto.service.ShopServiceMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.category.CategoryEntity;
import com.realman.becore.repository.database.category.CategoryRepository;
import com.realman.becore.service.category.services.CategoryServiceUseCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryQueryService {
    @NonNull
    private final CategoryRepository categoryRepository;
    @NonNull
    private final CategoryMapper categoryMapper;
    @NonNull
    private final CategoryServiceUseCaseService categoryServiceUseCaseService;
    @NonNull
    private final ShopServiceMapper shopServiceMapper;

    public List<Category> findAll() {
        List<CategoryEntity> categoryEntityList = categoryRepository.findAll();
        Map<Long, List<CategoryService>> infoMapByCategoryId = categoryServiceUseCaseService
                .findAll()
                .stream().collect(Collectors.groupingBy(CategoryService::categoryId));
        List<Category> categoryList = categoryEntityList.stream()
                .map(category -> {
                    List<ShopService> serviceList = infoMapByCategoryId.get(category.getCategoryId())
                            .stream().map(shopServiceMapper::toDto).toList();
                    return categoryMapper.toDto(category, serviceList);
                }).toList();
        return categoryList;
    }

    public Category findById(Long categoryId) {
        CategoryEntity categoryServiceEntity = categoryRepository.findById(categoryId)
                .orElseThrow(ResourceNotFoundException::new);
        List<CategoryService> categoryServices = categoryServiceUseCaseService.findByCategoryId(categoryId);
        Map<Long, List<CategoryService>> infoMapByCategoryId = categoryServices.stream()
                .collect(Collectors.groupingBy(CategoryService::categoryId));
        List<ShopService> serviceList = infoMapByCategoryId.get(categoryId).stream().map(shopServiceMapper::toDto)
                .toList();
        return categoryMapper.toDto(categoryServiceEntity, serviceList);
    }
}
