package com.realman.becore.dto.schedule;

import java.time.LocalDate;
import java.time.LocalTime;
import com.realman.becore.dto.enums.EScheduleStatus;
import com.realman.becore.dto.enums.EShift;

public interface ScheduleInfo {
    void setScheduleId(Long scheduleId);
    void setStaffId(Long staffId);
    void setShiftId(Long shiftId);
    void setShift(EShift shift);
    void setWorkingDate(LocalDate workingDate);
    void setScheduleStatus(EScheduleStatus scheduleStatus);
    void setStart(LocalTime start);
    void setEnd(LocalTime end);

    Long getScheduleId();
    Long getStaffId();
    Long getShiftId();
    EShift getShift();
    LocalDate getWorkingDate();
    EScheduleStatus getScheduleStatus();
    LocalTime getStart();
    LocalTime getEnd();
}
