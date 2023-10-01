package com.realman.becore.service.account;

import java.util.Objects;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.realman.becore.controller.api.account.models.AccountId;
import com.realman.becore.controller.api.account.models.AccountRole;
import com.realman.becore.controller.api.otp.models.OTPId;
import com.realman.becore.dto.account.Account;
import com.realman.becore.dto.account.AccountMapper;
import com.realman.becore.dto.branch_manager.BranchManagerMapper;
import com.realman.becore.dto.customer.CustomerMapper;
import com.realman.becore.dto.receptionist.ReceptionistMapper;
import com.realman.becore.dto.shop_owner.ShopOwnerMapper;
import com.realman.becore.dto.staff.StaffMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.enums.ERole;
import com.realman.becore.error_handlers.exceptions.AuthFailException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.account.AccountRepository;
import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;
import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.receptionist.ReceptionistEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerEntity;
import com.realman.becore.repository.database.staff.StaffEntity;
import com.realman.becore.security.jwt.JwtConfiguration;
import com.realman.becore.service.branch_manager.BranchManagerUseCaseService;
import com.realman.becore.service.customer.CustomerUserCaseService;
import com.realman.becore.service.otp.OTPQueryService;
import com.realman.becore.service.receptionist.ReceptionistUseCaseService;
import com.realman.becore.service.shop_owner.ShopOwnerUseCaseService;
import com.realman.becore.service.staff.StaffUsecaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountCommandService {
        @NonNull
        private final AccountRepository accountRepository;
        @NonNull
        private final CustomerUserCaseService customerUserCaseService;
        @NonNull
        private final StaffUsecaseService staffUsecaseService;
        @NonNull
        private final BranchManagerUseCaseService branchManagerUseCaseService;
        @NonNull
        private final ShopOwnerUseCaseService shopOwnerUseCaseService;
        @NonNull
        private final ReceptionistUseCaseService receptionistUseCaseService;
        @NonNull
        private final AccountQueryService accountQueryService;
        @NonNull
        private final OTPQueryService otpQueryService;
        @NonNull
        private final JwtConfiguration jwtConfiguration;
        @NonNull
        private final PasswordEncoder passwordEncoder;
        @NonNull
        private final AccountMapper accountMapper;
        @NonNull
        private final CustomerMapper customerMapper;
        @NonNull
        private final StaffMapper staffMapper;
        @NonNull
        private final BranchManagerMapper branchManagerMapper;
        @NonNull
        private final ShopOwnerMapper shopOwnerMapper;
        @NonNull
        private final ReceptionistMapper receptionistMapper;

        public void save(Account account, OTPId otpId, AccountRole accountRole) {
                accountQueryService.verifyAccount(account);

                switch (accountRole.role()) {
                        case CUSTOMER:
                                if (Objects.isNull(otpId)) {
                                        throw new AuthFailException(EErrorMessage.ACCOUNT_NOT_VALID.name());
                                }
                                otpQueryService.findById(otpId.value());
                                Long customerId = customerUserCaseService
                                                .save(customerMapper.toDto(new CustomerEntity()));
                                AccountEntity customerAccountEntity = accountMapper.toCustomerEntity(account,
                                                ERole.CUSTOMER,
                                                customerId, otpId.value());
                                customerAccountEntity.setCustomerId(customerId);
                                AccountEntity customerAccountSavedEntity = accountRepository
                                                .save(customerAccountEntity);
                                customerUserCaseService.updateAccountId(customerId,
                                                customerAccountSavedEntity.getAccountId());
                                break;

                        case STAFF:
                                Long staffStylId = staffUsecaseService.save(staffMapper.toDto(new StaffEntity()),
                                                accountRole.professional());
                                AccountEntity staffStylAccountEntity = accountMapper.toStaffEntity(account, ERole.STAFF,
                                                staffStylId,
                                                otpId.value());
                                AccountEntity staffStylAccountSavedEntity = accountRepository
                                                .save(staffStylAccountEntity);
                                staffUsecaseService.updateAccountId(staffStylId,
                                                staffStylAccountSavedEntity.getAccountId());
                                break;
                        case BRANCH_MANAGER:
                                Long managerId = branchManagerUseCaseService
                                                .save(branchManagerMapper.toDto(new BranchManagerEntity()));
                                AccountEntity managerAccountEntity = accountMapper.toManagerEntity(account,
                                                ERole.BRANCH_MANAGER,
                                                managerId, otpId.value());
                                AccountEntity managerAccountSavedEntity = accountRepository.save(managerAccountEntity);
                                branchManagerUseCaseService.updateAccountId(managerId,
                                                managerAccountSavedEntity.getAccountId());
                                break;
                        case SHOP_OWNER:
                                Long shopOwnerId = shopOwnerUseCaseService
                                                .save(shopOwnerMapper.toDto(new ShopOwnerEntity()));
                                AccountEntity shopOwnerAccountEntity = accountMapper.toShopOwnerEntity(account,
                                                ERole.SHOP_OWNER,
                                                shopOwnerId, otpId.value());
                                AccountEntity shopOwnerAccountSavedEntity = accountRepository
                                                .save(shopOwnerAccountEntity);
                                shopOwnerUseCaseService.updateAccountId(shopOwnerId,
                                                shopOwnerAccountSavedEntity.getAccountId());
                                break;
                        case RECEPTIONIST:
                                Long receptId = receptionistUseCaseService
                                                .save(receptionistMapper.toDto(new ReceptionistEntity()));
                                AccountEntity receptAccountEntity = accountMapper.toReceptEntity(account,
                                                ERole.RECEPTIONIST, receptId,
                                                otpId.value());
                                AccountEntity receptAccountSavedEntity = accountRepository.save(receptAccountEntity);
                                receptionistUseCaseService.updateAccountId(receptId,
                                                receptAccountSavedEntity.getAccountId());
                                break;
                }
        }

        public void updateOTPId(Long accountId, Long otpId) {
                AccountEntity entity = accountRepository.findById(otpId)
                                .orElseThrow(() -> new ResourceNotFoundException(
                                                EErrorMessage.ACCOUNT_NOT_FOUND.name()));
                entity.setOtpId(otpId);
                accountRepository.save(entity);
        }

        public void update(AccountId accountId, Account account) {
                AccountEntity accountEntity = accountRepository.findById(accountId.value())
                                .orElseThrow(() -> new ResourceNotFoundException(
                                                EErrorMessage.ACCOUNT_NOT_FOUND.name()));
                accountRepository.delete(accountEntity);
                switch (accountEntity.getRole()) {
                        case CUSTOMER:
                                AccountEntity savedCustomerEntity = accountRepository.save(accountMapper
                                                .updateCustomerEntity(account, accountEntity.getRole(),
                                                                accountEntity.getCustomerId()));
                                customerUserCaseService.updateAccountId(accountEntity.getCustomerId(),
                                                savedCustomerEntity.getAccountId());
                                break;
                        case STAFF:
                                AccountEntity savedStaffEntity = accountRepository.save(
                                                accountMapper.updateStaffEntity(account, accountEntity.getRole(),
                                                                accountEntity.getStaffId()));
                                staffUsecaseService.updateAccountId(accountEntity.getStaffId(),
                                                savedStaffEntity.getAccountId());
                                break;
                        case RECEPTIONIST:
                                AccountEntity savedReceptionistEntity = accountRepository.save(accountMapper
                                                .updateReceptEntity(account, accountEntity.getRole(),
                                                                accountEntity.getReceptionistId()));
                                receptionistUseCaseService.updateAccountId(accountEntity.getReceptionistId(),
                                                savedReceptionistEntity.getAccountId());
                                break;
                        case BRANCH_MANAGER:
                                AccountEntity savedManagerEntity = accountRepository.save(accountMapper
                                                .updateCustomerEntity(account, accountEntity.getRole(),
                                                                accountEntity.getBranchManagerId()));
                                branchManagerUseCaseService.updateAccountId(accountEntity.getBranchManagerId(),
                                                savedManagerEntity.getAccountId());
                                break;
                        case SHOP_OWNER:
                                AccountEntity savedShopOwnerEntity = accountRepository.save(accountMapper
                                                .updateShopOwnerEntity(account, accountEntity.getRole(),
                                                                accountEntity.getShopOwnerId()));
                                shopOwnerUseCaseService.updateAccountId(accountEntity.getShopOwnerId(),
                                                savedShopOwnerEntity.getAccountId());
                                break;
                        default:
                                break;
                }
        }

}
