package com.realman.becore.service.category;

import org.springframework.stereotype.Service;
import com.realman.becore.dto.category.Category;
import com.realman.becore.dto.category.CategoryMapper;
import com.realman.becore.repository.database.category.CategoryEntity;
import com.realman.becore.repository.database.category.CategoryRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryCommandService {
    @NonNull
    private final CategoryRepository categoryRepository;
    @NonNull
    private final CategoryMapper categoryMapper;

    public void save(Category category) {
        CategoryEntity categoryEntity = categoryMapper.toEntity(category);
        categoryRepository.save(categoryEntity);
    }
}
