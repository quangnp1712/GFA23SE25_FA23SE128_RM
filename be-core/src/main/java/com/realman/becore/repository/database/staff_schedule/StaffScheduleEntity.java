package com.realman.becore.repository.database.staff_schedule;

import com.realman.becore.enums.EScheduleStatus;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long staffScheduleId;
    private Long staffId;
    private Long scheduleId;

    private EScheduleStatus status;
}
