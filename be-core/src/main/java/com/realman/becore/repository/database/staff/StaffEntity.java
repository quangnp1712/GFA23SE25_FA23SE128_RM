package com.realman.becore.repository.database.staff;

import java.io.Serializable;

import com.realman.becore.enums.EStaffProfession;
import com.realman.becore.repository.database.account.AccountEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "staff")
public class StaffEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private EStaffProfession profession;
    private Double averageRating = 0.0;
    @OneToOne(mappedBy = "staffProperty")
    private AccountEntity account;
}
