package com.realman.becore.custom_constrain.username;

import java.util.Objects;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class UsernameValidator implements ConstraintValidator<UsernameConstrain, String> {

    @Override
    public void initialize(UsernameConstrain constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return Objects.nonNull(value) && value.length() >= 5 && value.matches("([A-Z])\\w+");
    }

}
