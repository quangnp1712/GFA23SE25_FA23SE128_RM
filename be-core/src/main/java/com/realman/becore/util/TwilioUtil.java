package com.realman.becore.util;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class TwilioUtil {

    public static void sendOTP(String phone, String otp) {
        phone = phone.replace(String.valueOf(phone.charAt(0)), "+84");
        Twilio.init(TwilioProperties.ACCOUNT_SID, TwilioProperties.AUTH_TOKEN);
        StringBuilder messageBuilder = new StringBuilder();
        messageBuilder.append("Mật khẩu đăng nhập của quí khách là: ").append(otp);
        Message.creator(new PhoneNumber(phone), new PhoneNumber(TwilioProperties.TWILIO_PHONE_NUMBER),
                messageBuilder.toString()).create();
    }
}
