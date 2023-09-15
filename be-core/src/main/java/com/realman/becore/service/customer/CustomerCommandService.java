package com.realman.becore.service.customer;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.customer.Customer;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.customer.CustomerEntity;
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

    @Transactional
    Long save(Customer customer) {
        CustomerEntity entity = customerRepositoty.save(customerMapper.toEntity(customer));
        return entity.getCustomerId();
    }

    void updateAccountId(Long customerId, Long accountId) {
        CustomerEntity entity = customerRepositoty.findById(customerId).orElseThrow(ResourceNotFoundException::new);
        entity.setAccountId(accountId);
        customerRepositoty.save(entity);
    }
}
