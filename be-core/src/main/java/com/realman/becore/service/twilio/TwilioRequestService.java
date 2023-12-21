package com.realman.becore.service.twilio;

import org.springframework.stereotype.Service;
import com.realman.becore.util.TwilioUtil;

@Service
public class TwilioRequestService {

    public void sendOTP(String phone, String otp) {
        TwilioUtil.initTwilio();
        String sendOTPMessage = sendOTPMessage(otp);
        TwilioUtil.sendMessage(phone, sendOTPMessage);
    }

    public void acceptBooking(String phone, String bookingCode) {
        TwilioUtil.initTwilio();
        String acceptBookingMessage = acceptBookingMessage(bookingCode);
        TwilioUtil.sendMessage(phone, acceptBookingMessage);
    }

    public void denyBooking(String phone, String bookingCode) {
        TwilioUtil.initTwilio();
        String denyBooking = denyBookingMessage(bookingCode);
        TwilioUtil.sendMessage(phone, denyBooking);
    }

    private String sendOTPMessage(String otp) {
        return messageBuilder().append("Mật khẩu đăng nhập của quí khách là: ")
                .append(otp).toString();
    }

    private String acceptBookingMessage(String bookingCode) {
        return messageBuilder()
                .append("Lịch hẹn làm tóc của bạn có mã")
                .append(" ")
                .append(bookingCode)
                .append(" ")
                .append("đã được xác nhận.")
                .append("Vui lòng kiểm tra thông tin trên app")
                .toString();
    }

    private String denyBookingMessage(String bookingCode) {
        return messageBuilder()
                .append("Lịch hẹn làm tóc của bạn có mã")
                .append(" ")
                .append(bookingCode)
                .append(" ")
                .append("đã bị từ chối.")
                .append("Vui lòng kiểm tra thông tin trên app")
                .toString();
    }

    private StringBuilder messageBuilder() {
        return new StringBuilder();
    }
}
