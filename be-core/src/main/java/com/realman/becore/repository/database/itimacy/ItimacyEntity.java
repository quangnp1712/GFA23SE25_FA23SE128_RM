package com.realman.becore.repository.database.itimacy;

import java.io.Serializable;

import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.itimacty_level.ItimacyLevelEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "itimacy")
public class ItimacyEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long currentPoint;
    @OneToOne(mappedBy = "itimacy")
    private CustomerEntity customer;
    @OneToOne
    @JoinColumn(name = "level_id", referencedColumnName = "id")
    private ItimacyLevelEntity itimacyLevel;
}
