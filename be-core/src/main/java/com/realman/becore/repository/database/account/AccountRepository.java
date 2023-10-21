package com.realman.becore.repository.database.account;

import java.util.List;
import java.util.Optional;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.account.AccountInfo;
import com.realman.becore.dto.enums.ERole;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {
    Optional<AccountEntity> findByPhone(String phone);

    @Query("""
            SELECT
                a.accountId AS accountId,
                b.branchId AS branchId,
                a.firstName AS firstName,
                a.lastName AS lastName,
                a.thumbnailUrl AS thumbnailUrl,
                a.gender AS gender,
                a.dob AS dob,
                a.phone AS phone,
                a.address AS address,
                a.status AS status,
                a.role AS role,
                b.branchName AS branchName,
                b.address AS branchAddress,
                s.professional AS professional,
                s.averageRating AS averageRating
            FROM AccountEntity a
            INNER JOIN BranchEntity b ON b.branchId = a.branchId
            INNER JOIN StaffEntity s ON a.accountId = s.accountId
            WHERE a.accountId = :accountId
            AND a.role = STAFF OR a.role = RECEPTIONIST
                """)
    Optional<AccountInfo> findStaffAccount(Long accountId);

    @Query("""
            SELECT
                a.firstName AS firstName,
                a.lastName AS lastName,
                a.thumbnailUrl AS thumbnailUrl,
                a.gender AS gender,
                a.dob AS dob,
                a.phone AS phone,
                a.address AS address,
                a.status AS satus,
                a.role AS role,
                il.itimacyLevel AS itimacyLevel
            FROM AccountEntity a
            INNER JOIN CustomerEntity c ON a.accountId = c.accountId
            INNER JOIN ItimacyEntity i ON c.customerId = i.customerId
            INNER JOIN ItimacyLevelEntity il ON i.itimacyLevelId = il.itimacyLevelId
            WHERE a.accountId = :accountId
            AND a.role = CUSTOMER
                """)
    Optional<AccountInfo> findCustomerAccount(Long accountId);

    @Query("""
            SELECT
                a.firstName AS firstName,
                a.lastName AS lastName,
                a.thumbnailUrl AS thumbnailUrl,
                a.gender AS gender,
                a.dob AS dob,
                a.phone AS phone,
                a.address AS address,
                a.status AS satus,
                a.role AS role
            FROM AccountEntity a
            WHERE a.accountId = :accountId
                """)
    Optional<AccountInfo> findByAccountId(Long accountId);

    @Query("""
            SELECT
                a.accountId AS accountId,
                b.branchId AS branchId,
                a.firstName AS firstName,
                a.lastName AS lastName,
                a.thumbnailUrl AS thumbnailUrl,
                a.gender AS gender,
                a.dob AS dob,
                a.phone AS phone,
                a.address AS address,
                a.status AS satus,
                a.role AS role,
                b.branchName AS branchName,
                b.address AS branchAddress
            FROM AccountEntity a
            INNER JOIN BranchEntity b ON b.branchId = a.branchId
            WHERE a.accountId = :accountId
            AND a.role = BRANCH_MANAGER
                """)
    Optional<AccountInfo> findManagerAccount(Long accountId);

    @Query("""
            SELECT
                a.accountId AS accountId,
                a.firstName AS firstName,
                a.lastName AS lastName,
                a.thumbnailUrl AS thumbnailUrl,
                a.phone AS phone,
                a.address AS address,
                a.gender AS gender,
                a.dob AS dob,
                a.status AS status,
                a.role AS role
            FROM AccountEntity a
            WHERE a.role = :role
            AND (:#{#searches.isEmpty()} = TRUE) 
            OR (a.firstName IN (:searches)
            OR a.lastName IN (:searches) OR a.phone IN (:searches) 
            OR a.address IN (:searches))
            """)
    Page<AccountInfo> findAll(List<String> searches, ERole role,
            Pageable pageable);

}
