package com.realman.becore.controller.api.account.models;

import java.time.LocalDateTime;
import java.util.StringTokenizer;

import com.realman.becore.enums.EGender;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record AccountRequest(
                @NotNull String firstName,
                @NotNull String lastName,
                @NotNull String phone,
                String address,
                @Enumerated(EnumType.STRING) EGender gender,
                LocalDateTime dob) {

        public AccountRequest format() {
                AccountRequestBuilder accountRequestBuilder = AccountRequest.builder();
                StringBuilder firstNameBuilder = new StringBuilder();
                StringTokenizer firstNameTokenizer = new StringTokenizer(firstName, " ");
                while (firstNameTokenizer.hasMoreTokens()) {
                        firstNameBuilder.append(formatName(firstNameTokenizer.nextToken())).append(" ");
                }
                accountRequestBuilder.firstName(firstNameBuilder.toString().strip());
                accountRequestBuilder.lastName(formatName(lastName));
                accountRequestBuilder.phone(phone);
                accountRequestBuilder.address(address);
                accountRequestBuilder.gender(gender);
                accountRequestBuilder.dob(dob);

                return accountRequestBuilder.build();
        }

        private String formatName(String name) {
                return String.valueOf(name.charAt(0)).toUpperCase().concat(name.substring(1));
        }
}
