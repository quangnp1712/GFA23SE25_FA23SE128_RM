package com.realman.becore.dto.booking;

import java.time.LocalDate;
import java.time.LocalTime;

import com.realman.becore.dto.enums.EBookingStatus;

public interface BookingInfo {
    void setBookingId(Long bookingId);

    void setAccountId(Long accountId);

    void setBranchId(Long branchId);

    void setBookingCode(String bookingCode);

    void setBookingOwnerName(String bookingOwnerName);

    void setBookingOwnerPhone(String bookingOwnerPhone);

    void setBranchAddress(String branchAddress);

    void setBranchName(String branchName);

    void setAppointmentDate(LocalTime appointmentDate);

    void setBookingStatus(EBookingStatus bookingStatus);

    Long getBookingId();

    Long getAccountId();

    Long getBranchId();

    String getBookingCode();

    String getBookingOwnerName();

    String getBookingOwnerPhone();

    String getBranchAddress();

    String getBranchName();

    LocalDate getAppointmentDate();

    EBookingStatus getBookingStatus();
}
