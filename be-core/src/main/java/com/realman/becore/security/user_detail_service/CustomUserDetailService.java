package com.realman.becore.security.user_detail_service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.realman.becore.dto.account.Account;
import com.realman.becore.service.account.AccountUseCaseService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

    @NonNull
    private final AccountUseCaseService accountUseCaseService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account = accountUseCaseService.findAccountByUsername(username);
        if (account != null) {
            return User.builder().username(username).password(account.password())
                    .authorities(account.role().getAuthorities()).build();
        }
        throw new UnsupportedOperationException("Unimplemented method 'loadUserByUsername'");
    }

}
