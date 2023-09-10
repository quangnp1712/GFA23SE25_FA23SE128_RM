package com.realman.becore.repository.database.branch_manager;

import java.io.Serializable;

import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.branch.BranchEntity;

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
@Table(name = "branch_manager")
public class BranchManagerEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne(mappedBy = "branchManagerProperty")
    private AccountEntity account;
    @OneToOne(mappedBy = "branchManager")
    private BranchEntity branch;
}
