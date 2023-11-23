package com.realman.becore.repository.database.service;

import com.realman.becore.dto.enums.EServiceStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "service")
public class ShopServiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long serviceId;
    private Long categoryId;
    @Column(columnDefinition = "NVARCHAR(500)")
    private String name;
    @Column(name = "description" ,columnDefinition = "NVARCHAR(1000)")
    private String serviceDescription;
    private Integer duration;
    private EServiceStatus status;

}
