package com.realman.becore.custom_constrain.username;

import java.util.Objects;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class LastNameValidator implements ConstraintValidator<LastNameConstraint, String> {

    @Override
    public void initialize(LastNameConstraint constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return Objects.nonNull(value) && !value.isEmpty() && value.matches("[\\D]+");
    }

}
