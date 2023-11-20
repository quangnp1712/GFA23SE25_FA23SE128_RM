package com.realman.becore.service.category;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.category.Category;
import com.realman.becore.dto.category.CategoryMapper;
import com.realman.becore.dto.category.services.CategoryServiceInfo;
import com.realman.becore.dto.category.services.CategoryServiceMapper;
import com.realman.becore.dto.enums.ECategory;
import com.realman.becore.dto.service.ShopService;
import com.realman.becore.dto.service.ShopServiceMapper;
import com.realman.becore.repository.database.category.CategoryRepository;
import com.realman.becore.repository.database.category.services.CategoryServiceRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryQueryService {
    @NonNull
    private final CategoryRepository categoryRepository;
    @NonNull
    private final CategoryServiceRepository categoryServiceRepository;
    @NonNull
    private final CategoryMapper categoryMapper;
    @NonNull
    private final ShopServiceMapper shopServiceMapper;
    @NonNull
    private final CategoryServiceMapper categoryServiceMapper;

    public List<Category> findAll() {
        Map<ECategory, List<CategoryServiceInfo>> infoMapByCategoryTitle = categoryServiceRepository
                .findAllInfo()
                .stream().collect(Collectors.groupingBy(CategoryServiceInfo::getTitle));
        List<Category> categoryList = new ArrayList<>();
        infoMapByCategoryTitle.keySet().forEach(title -> {
            Long categoryId = infoMapByCategoryTitle.get(title).stream()
                    .map(CategoryServiceInfo::getCategoryId).findAny().orElse(null);
            List<ShopService> serviceList = infoMapByCategoryTitle.get(title).stream().map(shopServiceMapper::toDto)
                    .toList();
            Category category = Category.builder().categoryId(categoryId).title(title)
                    .serviceList(serviceList).build();
            categoryList.add(category);
        });
        return categoryList;
    }
}
