package com.realman.becore.repository.database.service;

import org.springdoc.core.converters.models.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.service.ShopServiceInfo;

@Repository
public interface ShopServiceRepository extends JpaRepository<ShopServiceEntity, Long> {
    
}
