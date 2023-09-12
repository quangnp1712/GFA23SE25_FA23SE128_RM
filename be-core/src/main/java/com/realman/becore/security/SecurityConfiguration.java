package com.realman.becore.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.realman.becore.security.filter.JwtAuthenticationFilter;
import com.realman.becore.security.password_encoder.AppPasswordEncoder;
import com.realman.becore.security.user_detail_service.CustomUserDetailService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
@Configuration
@RequiredArgsConstructor
public class SecurityConfiguration {

    @NonNull
    private AppPasswordEncoder appPasswordEncoder;

    @NonNull
    private CustomUserDetailService customUserDetailService;

    @NonNull
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setUserDetailsService(customUserDetailService);
        daoAuthenticationProvider.setPasswordEncoder(appPasswordEncoder.passwordEncoder());
        return http.getSharedObject(AuthenticationManagerBuilder.class)
                .authenticationProvider(daoAuthenticationProvider).build();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http.cors(null).csrf(t -> t.disable())
                .sessionManagement(t -> t.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .userDetailsService(customUserDetailService)

                .authorizeHttpRequests(t -> t.requestMatchers("/api/auth/**").authenticated())
                .authorizeHttpRequests(t -> t.requestMatchers("/swagger-ui.html/**", "/webjars/springfox-swagger-ui/**",
                        "/v2/api-docs", "/swagger-resources", "/swagger-resources/**", "/swagger-ui.html",
                        "/swagger-ui.html/**", "/api/**").permitAll())
                .getObject();
    }
}
