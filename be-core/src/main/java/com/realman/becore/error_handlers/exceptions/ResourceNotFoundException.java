package com.realman.becore.error_handlers.exceptions;

public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException() {
        super("Not found");
    }
}
