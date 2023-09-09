package com.realman.becore.repository.database.staff;

import java.io.Serializable;
import java.util.List;

import com.realman.becore.enums.EStaffProfession;
import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.rating.RatingEntity;
import com.realman.becore.repository.database.schedule.StaffScheduleEntity;

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
@Table(name = "staff")
public class StaffEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private EStaffProfession profession;
    private Double averageRating = 0.0;
    @OneToOne(mappedBy = "staffProperty")
    private AccountEntity account;
    @OneToMany(mappedBy = "staff")
    private List<RatingEntity> ratings;
    @OneToMany(mappedBy = "staff")
    private List<StaffScheduleEntity> staffScheduleEntities;
}
