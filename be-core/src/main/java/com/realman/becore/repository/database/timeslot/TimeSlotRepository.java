package com.realman.becore.repository.database.timeslot;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.timeslot.TimeSlotInfo;

@Repository
public interface TimeSlotRepository extends JpaRepository<TimeSlotEntity, Long> {
    @Query("""
            SELECT
                ts.timeSlotId AS timeSlotId,
                sh.shiftId AS shiftId,
                ts.time AS time,
                CASE
                    WHEN sc.workingDate = :chosenDate THEN
                        CASE
                            WHEN b.appointmentDate = :chosenDate THEN
                                CASE
                                    WHEN ts.time BETWEEN bs.startAppointment AND bs.endAppointment THEN FALSE
                                    ELSE TRUE
                                END
                            ELSE TRUE
                        END
                    ELSE FALSE
                END AS isAvailable
            FROM TimeSlotEntity ts
            INNER JOIN ShiftEntity sh ON ts.shiftId = sh.shiftId
            LEFT JOIN ScheduleEntity sc ON sh.shiftId = sc.shiftId
            LEFT JOIN StaffEntity st ON sc.staffId = st.staffId
            LEFT JOIN BookingServiceEntity bs ON bs.staffId = st.staffId
            LEFT JOIN BookingEntity b ON bs.bookingId = b.bookingId
            WHERE st.staffId = :staffId
            """)
    List<TimeSlotInfo> findAllInfoById(LocalDate chosenDate, Long staffId);
}
