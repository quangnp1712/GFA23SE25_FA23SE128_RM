package com.realman.becore.repository.database.booking;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.realman.becore.dto.booking.BookingInfo;

import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<BookingEntity, Long> {
    @Query("""
            SELECT
                b.bookingId AS bookingId,
                a.accountId AS accountId,
                be.branchId AS branchId,
                b.bookingCode AS bookingCode,
                CONCAT(a.firstName, ' ', a.lastName) AS bookingOwnerName,
                a.phone AS bookingOwnerPhone,
                be.branchName AS branchName,
                be.branchAddress AS branchAddress,
                b.appointmentDate AS appointmentDate,
                b.bookingStatus AS bookingStatus
            FROM BookingEntity b
            INNER JOIN AccountEntity a ON a.accountId = b.accountId
            INNER JOIN BranchEntity be ON be.branchId = b.branchId
            WHERE b.bookingId = :bookingId
            """)
    Optional<BookingInfo> findInfoById(Long bookingId);

    @Query("""
            SELECT
                b.bookingId AS bookingId,
                a.accountId AS accountId,
                be.branchId AS branchId,
                b.bookingCode AS bookingCode,
                CONCAT(a.firstName, ' ', a.lastName) AS bookingOwnerName,
                a.phone AS bookingOwnerPhone,
                be.branchName AS branchName,
                be.branchAddress AS branchAddress,
                b.appointmentDate AS appointmentDate,
                b.bookingStatus AS bookingStatus
            FROM BookingEntity b
            INNER JOIN AccountEntity a ON a.accountId = b.accountId
            INNER JOIN BranchEntity be ON be.branchId = b.branchId
            """)
    Page<BookingInfo> findAllInfo(Pageable pageable);
}
