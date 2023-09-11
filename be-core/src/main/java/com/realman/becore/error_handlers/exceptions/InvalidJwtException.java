package com.realman.becore.error_handlers.exceptions;

public class InvalidJwtException extends RuntimeException {
    public InvalidJwtException() {
        super("Invalid Authorization header");
    }

    public InvalidJwtException(String message) {
        super(message);
    }
}
