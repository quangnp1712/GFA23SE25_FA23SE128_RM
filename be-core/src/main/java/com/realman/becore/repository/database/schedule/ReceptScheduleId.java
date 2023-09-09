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
public class ReceptScheduleId implements Serializable {
    private Long receptId;
    private Long scheduleId;
}
