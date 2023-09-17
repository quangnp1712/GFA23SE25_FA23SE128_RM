package com.realman.becore.dto.customer;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.mapstruct.ReportingPolicy;

import com.realman.becore.repository.database.customer.CustomerEntity;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CustomerMapper {
    CustomerEntity toEntity(Customer customer);

    Customer toDto(CustomerEntity customerEntity);
}