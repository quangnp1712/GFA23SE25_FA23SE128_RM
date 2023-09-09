package com.realman.becore.custom_constrain;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = PhoneValidator.class)
@Target(ElementType.FIELD)
public @interface PhoneConstrain {
    String messag() default "Số điện thoại không hợp lệ";

    Class<?>[] group() default {};

    Class<? extends Payload>[] payload() default {};
}
