package com.realman.becore.error_handlers.exceptions;

public class InvalidJwtException extends RuntimeException {

    public InvalidJwtException(String message) {
        super(message);
    }
}
