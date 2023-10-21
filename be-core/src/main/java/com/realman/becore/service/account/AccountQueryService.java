package com.realman.becore.service.account;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.AccountId;
import com.realman.becore.controller.api.account.models.AccountSearchCriteria;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountInfo;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.service.customer.CustomerUseCaseService;
import com.realman.becore.service.staff.StaffUsecaseService;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountQueryService {
        @NonNull
        private final AccountRepository accountRepository;

        @NonNull
        private final AccountMapper accountMapper;

        @NonNull
        private final CustomerUseCaseService customerUserCaseService;

        @NonNull
        private final StaffUsecaseService staffUsercaseService;

        public Account findByPhone(String phone) {
                AccountEntity entity = accountRepository
                                .findByPhone(phone)
                                .orElseThrow(ResourceNotFoundException::new);

                return accountMapper.toDto(entity);
        }

        public Boolean isAccountExist(String phone) {
                Optional<AccountEntity> entity = accountRepository.findByPhone(phone);
                return entity.isPresent();
        }

        public Account findStaffAccount(AccountId accountId) {
                AccountInfo info = accountRepository.findStaffAccount(accountId.value())
                                .orElseThrow(ResourceNotFoundException::new);
                return accountMapper.fromInfo(info);
        }

        public Account findCustomerAccount(AccountId accountId) {
                AccountInfo info = accountRepository.findCustomerAccount(accountId.value())
                                .orElseThrow(ResourceNotFoundException::new);
                return accountMapper.fromInfo(info);
        }

        public Account findManagerAccount(AccountId accountId) {
                AccountInfo info = accountRepository.findManagerAccount(accountId.value())
                                .orElseThrow(ResourceNotFoundException::new);
                return accountMapper.fromInfo(info);
        }

        public Account findById(AccountId accountId) {
                AccountInfo info = accountRepository.findByAccountId(accountId.value())
                                .orElseThrow(ResourceNotFoundException::new);
                return accountMapper.fromInfo(info);
        }

        public Page<Account> findAll(AccountSearchCriteria criteria,
                        PageRequestCustom pageRequestCustom) {
                Page<AccountInfo> infoList = accountRepository.findAll(criteria.searches(), criteria.role(),
                                pageRequestCustom.pageRequest());
                return infoList.map(accountMapper::fromInfo);
        }
}
