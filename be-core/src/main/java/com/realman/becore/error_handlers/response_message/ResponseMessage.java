package com.realman.becore.error_handlers.response_message;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResponseMessage {
    private String code;
    private String description;
    private String message;
    private LocalDateTime issuedAt;
}
