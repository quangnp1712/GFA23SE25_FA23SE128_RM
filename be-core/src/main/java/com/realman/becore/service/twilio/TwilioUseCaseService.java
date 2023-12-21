package com.realman.becore.service.twilio;

import org.springframework.stereotype.Service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TwilioUseCaseService {
    @NonNull
    private final TwilioRequestService twilioRequestService;

    public void sendOTP(String phone, String otp) {
        twilioRequestService.sendOTP(phone, otp);
    }

    public void acceptBooking(String phone, String bookingCode) {
        twilioRequestService.acceptBooking(phone, bookingCode);
    }

    public void denyBooking(String phone, String bookingCode) {
        twilioRequestService.denyBooking(phone, bookingCode);
    }
}
