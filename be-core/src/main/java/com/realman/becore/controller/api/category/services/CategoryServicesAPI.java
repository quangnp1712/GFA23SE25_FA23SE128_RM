package com.realman.becore.controller.api.category.services;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.realman.becore.controller.api.category.services.models.CategorySeriviceId;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Category Service", description = "Category service management API")
@RequestMapping("/v1/category-service")
@PreAuthorize("hasAnyAuthority({'category:update', 'category:view'})")
public interface CategoryServicesAPI {
    @PostMapping
    void save(@RequestBody CategorySeriviceId categorySeriviceId);
}
