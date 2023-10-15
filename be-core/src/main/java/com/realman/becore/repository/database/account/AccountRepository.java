package com.realman.becore.repository.database.account;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.account.AccountInfo;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {
    Optional<AccountEntity> findByPhone(String phone);

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
                b.branchName AS branchName,
                b.address AS branchAddress,
                s.professional AS professional,
                s.averageRating AS averageRating
            FROM AccountEntity a
            INNER JOIN BranchEntity b ON b.branchId = a.branchId
            INNER JOIN StaffEntity s ON a.accountId = s.accountId
            WHERE a.accountId = :accountId
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
                """)
    Optional<AccountInfo> findManagerAccount(Long accountId);

}
