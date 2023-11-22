package com.realman.becore.repository.database.category.services;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.category.services.CategoryServiceInfo;

@Repository
public interface CategoryServiceRepository extends JpaRepository<CategoryServiceEntity, Long> {
    @Query("""
            SELECT
                cs.categoryServiceId AS categoryServiceId,
                c.categoryId AS categoryId,
                s.serviceId AS serviceId,
                c.title AS title,
                s.name AS name,
                s.duration AS duration,
                s.status AS status
            FROM CategoryServiceEntity cs
            INNER JOIN CategoryEntity c ON c.categoryId = cs.categoryId
            INNER JOIN ShopServiceEntity s ON s.serviceId = cs.serviceId
            """)
    List<CategoryServiceInfo> findAllInfo();

    @Query("""
            SELECT
                cs.categoryServiceId AS categoryServiceId,
                c.categoryId AS categoryId,
                s.serviceId AS serviceId,
                c.title AS title,
                s.name AS name,
                s.duration AS duration,
                s.status AS status
            FROM CategoryServiceEntity cs
            INNER JOIN CategoryEntity c ON c.categoryId = cs.categoryId
            INNER JOIN ShopServiceEntity s ON s.serviceId = cs.serviceId
            WHERE cs.categoryId = :categoryId
            """)
    List<CategoryServiceInfo> findByCategoryId(Long categoryId);
}
