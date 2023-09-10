package com.realman.becore.repository.database.staff_schedule;

import com.realman.becore.enums.EScheduleStatus;
import com.realman.becore.repository.database.schedule.ScheduleEntity;
import com.realman.becore.repository.database.staff.StaffEntity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "staff_schedule")
public class StaffScheduleEntity {
    @EmbeddedId
    private StaffScheduleId staffScheduleId = new StaffScheduleId();

    @MapsId("staffId")
    @ManyToOne
    private StaffEntity staff;

    @MapsId("scheduleId")
    @ManyToOne
    private ScheduleEntity schedule;

    private EScheduleStatus status;
}
