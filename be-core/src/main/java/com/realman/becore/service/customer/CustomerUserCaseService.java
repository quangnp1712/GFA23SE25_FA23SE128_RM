package com.realman.becore.service.customer;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.customer.Customer;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerUserCaseService {
    @NonNull
    private final CustomerCommandService customerCommandService;
    @NonNull
    private final CustomerQueryService customerQueryService;

    @Transactional
    public Long save(Customer customer) {
        return customerCommandService.save(customer);
    }

    @Transactional
    public void updateAccountId(Long customerId, Long accountId) {
        customerCommandService.updateAccountId(customerId, accountId);
    }

    public Customer findByAccountId(Long accountId) {
        return customerQueryService.findByAccountId(accountId);
    }
}
