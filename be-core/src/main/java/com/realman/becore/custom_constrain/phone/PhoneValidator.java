package com.realman.becore.custom_constrain.phone;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PhoneValidator implements ConstraintValidator<PhoneConstrain, String> {
    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return !value.isEmpty() && !value.isBlank() && value.matches("[0-9]+")
                && value.length() == 10;
    }

}
