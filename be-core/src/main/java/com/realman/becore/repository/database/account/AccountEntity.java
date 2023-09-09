package com.realman.becore.repository.database.account;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.hibernate.validator.constraints.Length;

import com.realman.becore.custom_constrain.PhoneConstrain;
import com.realman.becore.enums.EGender;
import com.realman.becore.enums.ERole;
import com.realman.becore.repository.database.branch_manager.BranchManagerEntity;
import com.realman.becore.repository.database.customer.CustomerEntity;
import com.realman.becore.repository.database.receptionist.ReceptionistEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerEntity;
import com.realman.becore.repository.database.staff.StaffEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "account")
public class AccountEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull(message = "Nhập username")
    @Column(columnDefinition = "NVARCHAR(500)")
    private String username;
    @NotNull(message = "Nhập password")
    @Length(min = 10, message = "Password ít nhất 10 ký tự")
    private String password;
    @PhoneConstrain
    private String phone;
    @NotNull(message = "Nhập địa chỉ")
    @Column(columnDefinition = "NVARCHAR(500)")
    private String address;
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime dob;
    private EGender gender;
    private ERole role;
    @OneToOne
    @JoinColumn(name = "staff_id", referencedColumnName = "id")
    private StaffEntity staffProperty;
    @OneToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    private CustomerEntity customerProperty;
    @OneToOne
    @JoinColumn(name = "shop_owner_id", referencedColumnName = "id")
    private ShopOwnerEntity shopOwnerProperty;
    @OneToOne
    @JoinColumn(name = "manager_id", referencedColumnName = "id")
    private BranchManagerEntity branchManagerProperty;
    @OneToOne
    @JoinColumn(name = "recept_id", referencedColumnName = "id")
    private ReceptionistEntity receptionistProperty;
}
