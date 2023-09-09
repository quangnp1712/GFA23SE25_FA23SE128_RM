package com.realman.becore.custom_constrain;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PhoneValidator implements ConstraintValidator<PhoneConstrain, String> {

    @Override
    public void initialize(PhoneConstrain constraintAnnotation) {

        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return !value.isEmpty() && !value.isBlank() && value.matches("[0-9]+")
                && value.length() == 10;
    }

}
