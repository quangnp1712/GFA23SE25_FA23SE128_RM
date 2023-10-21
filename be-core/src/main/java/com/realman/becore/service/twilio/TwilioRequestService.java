package com.realman.becore.service.twilio;

import org.springframework.stereotype.Service;

import com.realman.becore.util.TwilioProperties;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@Service
public class TwilioRequestService {
    public void sendOTP(String phone, String otp) {
        phone = "+84" + phone.substring(1);
        Twilio.init(TwilioProperties.ACCOUNT_SID, TwilioProperties.AUTH_TOKEN);
        StringBuilder messageBuilder = new StringBuilder();
        messageBuilder.append("Mật khẩu đăng nhập của quí khách là: ").append(otp);
        Message.creator(new PhoneNumber(phone), new PhoneNumber(TwilioProperties.TWILIO_PHONE_NUMBER),
                messageBuilder.toString()).create();
    }
}
