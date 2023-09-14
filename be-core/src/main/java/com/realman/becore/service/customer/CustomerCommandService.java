package com.realman.becore.service.customer;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.customer.Customer;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.repository.database.customer.CustomerRepositoty;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerCommandService {
    @NonNull
    private final CustomerRepositoty customerRepositoty;
    @NonNull
    private final CustomerMapper customerMapper;

    void save(Customer customer) {
        customerRepositoty.save(customerMapper.toEntity(customer));
    }
}
