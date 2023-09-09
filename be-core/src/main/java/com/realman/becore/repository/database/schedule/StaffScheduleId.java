package com.realman.becore.repository.database.schedule;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@AllArgsConstructor
@NoArgsConstructor
public class StaffScheduleId implements Serializable {
    private Long staffId;
    private Long scheduleId;
}
