package com.realman.becore.repository.database.rating;

import java.io.Serializable;

import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.staff.StaffEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "rating")
public class RatingEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Double point = 0.0;
    @ManyToOne
    private StaffEntity staff;
    @ManyToOne
    private CustomerEntity customer;
}
