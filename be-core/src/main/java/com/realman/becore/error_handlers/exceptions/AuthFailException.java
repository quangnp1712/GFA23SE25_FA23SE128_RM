package com.realman.becore.error_handlers.exceptions;

public class AuthFailException extends RuntimeException {
    public AuthFailException(String message) {
        super(message);
    }
}
