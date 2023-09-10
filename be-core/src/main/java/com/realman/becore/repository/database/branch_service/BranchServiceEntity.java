package com.realman.becore.repository.database.branch_service;

import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.service.ServiceEntity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "branch_service")
public class BranchServiceEntity {
    @EmbeddedId
    private BranchServiceId branchServiceId = new BranchServiceId();
    @MapsId("branchId")
    @ManyToOne
    private BranchEntity branch;
    @MapsId("serviceId")
    @ManyToOne
    private ServiceEntity service;
}
