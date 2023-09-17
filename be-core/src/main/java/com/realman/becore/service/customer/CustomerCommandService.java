package com.realman.becore.service.customer;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.customer.Customer;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.dto.itimacy.ItimacyMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.customer.CustomerRepositoty;
import com.realman.becore.repository.database.itimacy.ItimacyEntity;
import com.realman.becore.service.itimacy.ItimacyUsercaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerCommandService {
    @NonNull
    private final CustomerRepositoty customerRepositoty;
    @NonNull
    private final CustomerMapper customerMapper;
    @NonNull
    private final ItimacyUsercaseService itimacyUsercaseService;
    @NonNull
    private final ItimacyMapper itimacyMapper;

    @Transactional
    Long save(Customer customer) {
        CustomerEntity entity = customerMapper.toEntity(customer);
        Long itimacyId = itimacyUsercaseService.save(itimacyMapper.toDto(new ItimacyEntity()));
        entity.setItimacyId(itimacyId);
        CustomerEntity savedEntity = customerRepositoty.save(entity);
        itimacyUsercaseService.updateCustomerId(itimacyId, savedEntity.getCustomerId());

        return entity.getCustomerId();
    }

    @Transactional
    void updateAccountId(Long customerId, Long accountId) {
        CustomerEntity entity = customerRepositoty.findById(customerId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.CUSOMTER_NOT_FOUND.name()));
        entity.setAccountId(accountId);
        customerRepositoty.save(entity);
    }
}
