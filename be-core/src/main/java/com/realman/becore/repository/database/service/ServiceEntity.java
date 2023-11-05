package com.realman.becore.repository.database.service;

import org.hibernate.validator.constraints.Length;

import com.realman.becore.dto.enums.EServiceStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "service")
public class ServiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long serviceId;
    @Column(columnDefinition = "NVARCHAR(500)")
    @Length(min = 5, max = 15, message = "Tên dịch vụ có độ dài từ 5 đến 15 ký tự")
    private String name;
    @Min(value = 15, message = "Thời gian dự kiến ít nhất 15 phút")
    private Integer estimateTime;
    private EServiceStatus status;

}
