package com.realman.becore.service.customer;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.customer.Customer;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerUserCaseService {
    @NonNull
    private final CustomerCommandService customerCommandService;

    public void save(Customer customer) {
        customerCommandService.save(customer);
    }
}
