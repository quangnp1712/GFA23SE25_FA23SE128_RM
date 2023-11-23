package com.realman.becore.controller.api.category;

import java.util.List;

import org.springframework.web.bind.annotation.RestController;

import com.realman.becore.controller.api.category.models.CategoryFieldResponse;
import com.realman.becore.controller.api.category.models.CategoryModelMapper;
import com.realman.becore.controller.api.category.models.CategoryRequest;
import com.realman.becore.controller.api.category.models.CategoryResponse;
import com.realman.becore.dto.category.Category;
import com.realman.becore.service.category.CategoryUseCaseService;
import com.realman.becore.util.response.ListResponse;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class CategoriesController implements CategoriesAPI {
    @NonNull
    private final CategoryUseCaseService categoryUseCaseService;
    @NonNull
    private final CategoryModelMapper categoryModelMapper;

    @Override
    public void save(CategoryRequest categoryRequest) {
        Category category = categoryModelMapper.toDto(categoryRequest);
        categoryUseCaseService.save(category);
    }

    @Override
    public ListResponse<CategoryResponse> findAll() {
        List<CategoryResponse> responseList = categoryUseCaseService.findAll()
                .stream().map(categoryModelMapper::toModel).toList();
        return new ListResponse<>(responseList);
    }

    @Override
    public ListResponse<CategoryFieldResponse> findCategoryFields() {
        List<CategoryFieldResponse> responseList = categoryUseCaseService.findCategoryFields()
                .stream().map(categoryModelMapper::toFieldModel).toList();
        return new ListResponse<>(responseList);
    }

}
