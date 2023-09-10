package com.realman.becore.repository.database.recept_schedule;

import com.realman.becore.enums.EScheduleStatus;
import com.realman.becore.repository.database.receptionist.ReceptionistEntity;
import com.realman.becore.repository.database.schedule.ScheduleEntity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "recept_schedule")
public class ReceptScheduleEntity {
    @EmbeddedId
    private ReceptScheduleId receptScheduleId = new ReceptScheduleId();

    @MapsId("receptId")
    @ManyToOne
    private ReceptionistEntity receptionist;

    @MapsId("scheduleId")
    @ManyToOne
    private ScheduleEntity schedule;

    private EScheduleStatus status;
}
