package com.realman.becore.custom_constrain.username;

import org.springframework.stereotype.Component;

import com.realman.becore.dto.account.Account;
import com.realman.becore.service.account.AccountUseCaseService;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Component
public class UsernameValidator implements ConstraintValidator<UsernameConstrain, String> {

    private final AccountUseCaseService accountUseCaseService;

    public UsernameValidator(AccountUseCaseService accountUseCaseService) {
        this.accountUseCaseService = accountUseCaseService;
    }

    @Override
    public void initialize(UsernameConstrain constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        Account account = accountUseCaseService.findAccountByUsername(value);
        return account == null;
    }

}
