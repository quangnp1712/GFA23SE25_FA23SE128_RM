package com.realman.becore.repository.database.schedule;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.schedule.ScheduleInfo;

@Repository
public interface ScheduleRepository extends JpaRepository<ScheduleEntity, Long>{
    List<ScheduleEntity> findByStaffId(Long staffId);

    @Query("""
            SELECT
                sc.scheduleId AS scheduleId,
                sc.staffId AS staffId,
                sc.shiftId AS shiftId,
                sc.workingDate AS workingDate,
                sc.scheduleStatus AS scheduleStatus,
                s.start AS start,
                s.end AS end
            FROM ScheduleEntity sc 
            INNER JOIN ShiftEntity s ON s.shiftId = sc.shiftId
            WHERE sc.staffId = :staffId
            """)
    List<ScheduleInfo> findInfoByStaffId(Long staffId);
}
