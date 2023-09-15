package com.realman.becore.repository.database.recept_schedule;

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
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "recept_schedule")
public class ReceptScheduleEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long receptScheduleId;
    private Long receptionistId;

    private Long staffId;

    private EScheduleStatus status;
}
