package com.realman.becore.repository.database.service;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.service.ShopServiceInfo;

@Repository
public interface ShopServiceRepository extends JpaRepository<ShopServiceEntity, Long> {
    Page<ShopServiceEntity> findAll(Pageable pageable);

    @Query("""
            SELECT 
                s.serviceId AS serviceId,
                s.name AS name,
                s.description AS description,
                s.duration AS duration,
                b.branchId AS branchId,
                b.branchName AS branchName,
                bs.price AS price 
            FROM ShopServiceEntity s 
            INNER JOIN BranchServiceEntity bs ON bs.serviceId = s.serviceId
            INNER JOIN BranchEntity b ON b.branchId = bs.branchId
            WHERE s.serviceId = :serviceId
            """)
    List<ShopServiceInfo> findServiceId(Long serviceId);
}
