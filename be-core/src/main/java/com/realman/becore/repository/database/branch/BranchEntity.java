package com.realman.becore.repository.database.branch;

import java.util.List;

import com.realman.becore.enums.EBranchStatus;
import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;
import com.realman.becore.repository.database.branch_service.BranchServiceEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "branch")
public class BranchEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(columnDefinition = "NVARCHAR(500)")
    @NotNull(message = "Nhập địa chỉ chi nhánh")
    private String address;
    private EBranchStatus status;
    private Integer numberStaffs;
    private Long profit = 0L;
    @ManyToOne
    @JoinColumn(name = "shop_owner_id", referencedColumnName = "id")
    private ShopOwnerEntity shopOwner;
    @OneToOne
    @JoinColumn(name = "manager_id", referencedColumnName = "id")
    private BranchManagerEntity branchManager;
    @OneToMany(mappedBy = "branch")
    private List<BranchServiceEntity> branchServiceEntities;
}
