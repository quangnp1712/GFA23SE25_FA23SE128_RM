package com.realman.becore.error_handlers;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.realman.becore.enums.EErrorDes;
import com.realman.becore.enums.ESysError;
import com.realman.becore.error_handlers.exceptions.InvalidJwtException;
import com.realman.becore.error_handlers.response_message.ResponseMessage;

@RestControllerAdvice
public class AppExceptionHandler {

    @ResponseStatus(code = HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    Map<String, String> validationNotValidException(MethodArgumentNotValidException exc) {
        Map<String, String> errors = new HashMap<>();
        exc.getBindingResult().getAllErrors().forEach(error -> {
            String fieldError = ((FieldError) error).getField();
            String errorMsg = error.getDefaultMessage();
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
}
