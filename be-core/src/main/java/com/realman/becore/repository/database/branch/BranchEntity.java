package com.realman.becore.repository.database.branch;

import com.realman.becore.enums.EBranchStatus;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
    private Long branchId;
    private Long shopOwnerId;
    private Long branchManagerId;
    @Column(columnDefinition = "NVARCHAR(500)")
    @NotNull(message = "Nhập địa chỉ chi nhánh")
    private String address;
    private EBranchStatus status;
    private Integer numberStaffs;
    private Long profit = 0L;
}
