package com.realman.becore.repository.database.itimacty_level;

import com.realman.becore.enums.EItimacyLevel;
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
@Table(name = "itimacy_level")
public class ItimacyLevelEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long itimactyLevelId;
    private Long itimacyId;
    private Long requirePoint;
    private EItimacyLevel itimacyLevel;
    private Integer percentDiscount;

}
