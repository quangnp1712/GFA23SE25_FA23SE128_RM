package com.realman.becore.service.category;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.category.Category;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryUseCaseService {
    @NonNull
    private final CategoryCommandService categoryCommandService;
    @NonNull
    private final CategoryQueryService categoryQueryService;

    @Transactional
    public void save(Category category) {
        categoryCommandService.save(category);
    }
}
