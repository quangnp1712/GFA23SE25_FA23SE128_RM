package com.realman.becore.util;

import org.springframework.beans.factory.annotation.Value;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class TwilioUtil {
    @Value("${AccountSID}")
    private static String AccountSid;
    @Value("${AuthToken}")
    private static String AuthToken;
    @Value("${TwilioPhoneNumber}")
    private static String twilioPhoneNumber;

    public static void sendOTP(String phone, String otp) {
        Twilio.init(AccountSid, AuthToken);
        StringBuilder messageBuilder = new StringBuilder();
        messageBuilder.append("Mật khẩu đăng nhập của quí khách là: ").append(otp);
        Message.creator(new PhoneNumber(phone), new PhoneNumber(twilioPhoneNumber), otp).create();
    }
}
