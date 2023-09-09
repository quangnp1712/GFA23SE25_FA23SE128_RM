package com.realman.becore.repository.database.receptionist;

import java.io.Serializable;
import java.util.List;

import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.schedule.ReceptScheduleEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "receptionist")
public class ReceptionistEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;
    @OneToOne(mappedBy = "receptionistProperty")
    private AccountEntity account;
    @OneToMany(mappedBy = "receptionist")
    private List<ReceptScheduleEntity> receptScheduleEntities;
}
