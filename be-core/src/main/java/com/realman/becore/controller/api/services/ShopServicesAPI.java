package com.realman.becore.controller.api.services;

import org.springframework.web.bind.annotation.RequestMapping;

import com.realman.becore.dto.service.ShopService;
import com.realman.becore.util.response.PageImplResponse;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Shop Service", description = "service management API")
@RequestMapping("/service")
public interface ShopServicesAPI {
    
}
