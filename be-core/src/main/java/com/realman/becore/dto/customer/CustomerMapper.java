package com.realman.becore.dto.customer;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import com.realman.becore.repository.database.customer.CustomerEntity;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface CustomerMapper {
    CustomerEntity toEntity(Customer customer);

    Customer toDto(CustomerEntity customerEntity);
}