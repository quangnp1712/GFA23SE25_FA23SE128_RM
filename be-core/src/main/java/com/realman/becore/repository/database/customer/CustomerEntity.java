package com.realman.becore.repository.database.customer;

import java.io.Serializable;

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
@Table(name = "customer")
public class CustomerEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Integer serviceCount = 0;
    private Long profitProvided = 0L;
    @OneToOne(mappedBy = "customerProperty")
    private AccountEntity account;
}
