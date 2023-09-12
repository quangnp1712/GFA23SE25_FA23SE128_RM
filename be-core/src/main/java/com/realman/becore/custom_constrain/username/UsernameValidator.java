package com.realman.becore.custom_constrain.username;

import com.realman.becore.dto.account.Account;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.service.account.AccountUseCaseService;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class UsernameValidator implements ConstraintValidator<UsernameConstrain, AccountEntity> {

    @NonNull
    private final AccountUseCaseService accountUseCaseService;

    @Override
    public void initialize(UsernameConstrain constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(AccountEntity value, ConstraintValidatorContext context) {
        Account account = accountUseCaseService.findAccountByUsername(value.getUsername());
        return account == null;
    }

}
