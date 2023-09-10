package com.realman.becore.repository.database.customer;

import java.io.Serializable;
import java.util.List;

import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.itimacy.ItimacyEntity;
import com.realman.becore.repository.database.rating.RatingEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
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
@Table(name = "customer")
public class CustomerEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Integer serviceCount = 0;
    private Long profitProvided = 0L;
    @OneToOne(mappedBy = "customerProperty")
    private AccountEntity account;
    @OneToMany(mappedBy = "customer")
    private List<RatingEntity> ratings;
    @OneToOne
    @JoinColumn(name = "itimacy_id", referencedColumnName = "id")
    private ItimacyEntity itimacy;
}
