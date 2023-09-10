package com.realman.becore.repository.database.shop_owner;

import java.io.Serializable;
import java.util.List;

import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.branch.BranchEntity;

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
@Table(name = "shop_ower")
public class ShopOwnerEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne(mappedBy = "shopOwnerProperty")
    private AccountEntity account;
    @OneToMany(mappedBy = "shopOwner")
    private List<BranchEntity> branchEntities;
}
