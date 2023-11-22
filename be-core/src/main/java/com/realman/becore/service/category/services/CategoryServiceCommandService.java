package com.realman.becore.service.category.services;

import org.springframework.stereotype.Service;
import com.realman.becore.repository.database.category.services.CategoryServiceEntity;
import com.realman.becore.repository.database.category.services.CategoryServiceRepository;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceCommandService {
    @NonNull
    private final CategoryServiceRepository categoryServiceRepository;

    public void save(Long catgoryId, Long serviceId) {
        CategoryServiceEntity categoryServiceEntity = CategoryServiceEntity.builder()
            .categoryId(catgoryId).serviceId(serviceId).build();
        categoryServiceRepository.save(categoryServiceEntity);
    }
}
