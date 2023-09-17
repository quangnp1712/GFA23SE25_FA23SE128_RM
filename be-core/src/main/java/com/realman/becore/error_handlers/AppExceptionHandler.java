package com.realman.becore.error_handlers;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.realman.becore.enums.EErrorDes;
import com.realman.becore.enums.ESysError;
import com.realman.becore.error_handlers.exceptions.InvalidJwtException;
import com.realman.becore.error_handlers.exceptions.ResourceDuplicateException;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.error_handlers.response_message.ResponseMessage;

import jakarta.validation.ConstraintViolationException;

@RestControllerAdvice
public class AppExceptionHandler {

    @ResponseStatus(code = HttpStatus.BAD_REQUEST)
    @ExceptionHandler(ConstraintViolationException.class)
    Map<String, String> validationNotValidException(ConstraintViolationException exc) {
        Map<String, String> errors = new HashMap<>();
        exc.getConstraintViolations().forEach(error -> {
            String fieldError = "Validation fail";
            String errorMsg = error.getMessage();
            errors.put(fieldError, errorMsg);
        });
        return errors;
    }

    @ResponseStatus(code = HttpStatus.NOT_ACCEPTABLE)
    @ExceptionHandler(InvalidJwtException.class)
    ResponseMessage validationJwtToken(InvalidJwtException exc) {
        return new ResponseMessage(ESysError.RM_API.name(), EErrorDes.AUTH_FAILT.name(), exc.getMessage(),
                LocalDateTime.now());
    }

    @ResponseStatus(code = HttpStatus.NOT_FOUND)
    @ExceptionHandler(ResourceNotFoundException.class)
    ResponseMessage resourceNotFound(ResourceNotFoundException exc) {
        return new ResponseMessage(ESysError.RM_API.name(), EErrorDes.RESOURCE_NOT_FOUND.name(), exc.getMessage(),
                LocalDateTime.now());
    }

    @ResponseStatus(code = HttpStatus.IM_USED)
    @ExceptionHandler(ResourceDuplicateException.class)
    ResponseMessage resourceDuplicated(ResourceDuplicateException exc) {
        return new ResponseMessage(ESysError.RM_API.name(), EErrorDes.RESOURCE_DUPLICATED.name(), exc.getMessage(),
                LocalDateTime.now());
    }
}
