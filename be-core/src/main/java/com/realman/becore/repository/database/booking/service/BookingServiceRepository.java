package com.realman.becore.repository.database.booking.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.realman.becore.dto.booking.service.BookingServiceInfo;
import java.time.LocalDate;

@Repository
public interface BookingServiceRepository extends JpaRepository<BookingServiceEntity, Long> {
    @Query("""
            SELECT
                bs.bookingServiceId AS bookingServiceId,
                bs.bookingId AS bookingId,
                ss.serviceId AS serviceId,
                s.staffId AS staffId,
                c.categoryId AS categoryId,
                c.categoryName AS categoryName,
                c.priority AS priority,
                brs.branchServicePrice AS branchServicePrice,
                ss.serviceName AS serviceName,
                CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                a.phone AS staffPhone,
                bs.startTime AS startTime,
                bs.endTime AS endTime,
                bs.actualStartTime AS actualStartTime,
                bs.actualEndTime AS actualEndTime,
                (bs.actualEndTime - bs.actualStartTime) AS duration,
                bs.bookingServiceStatus AS bookingServiceStatus
            FROM BookingServiceEntity bs
            INNER JOIN StaffEntity s ON bs.staffId = bs.staffId
            INNER JOIN AccountEntity a ON a.accountId = s.accountId
            INNER JOIN ShopServiceEntity ss ON ss.serviceId = bs.serviceId
            INNER JOIN CategoryEntity c ON c.categoryId = ss.categoryId
            INNER JOIN BranchServiceEntity brs ON ss.serviceId = brs.serviceId
            WHERE bs.bookingId = :bookingId
            ORDER BY priority ASC
            """)
    List<BookingServiceInfo> findInfoByBookingId(Long bookingId);

    @Query("""
            SELECT
                bs.bookingServiceId AS bookingServiceId,
                bs.bookingId AS bookingId,
                ss.serviceId AS serviceId,
                s.staffId AS staffId,
                c.categoryId AS categoryId,
                c.categoryName AS categoryName,
                c.priority AS priority,
                brs.branchServicePrice AS branchServicePrice,
                ss.serviceName AS serviceName,
                CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                a.phone AS staffPhone,
                bs.startTime AS startTime,
                bs.endTime AS endTime,
                bs.actualStartTime AS actualStartTime,
                bs.actualEndTime AS actualEndTime,
                (bs.actualEndTime - bs.actualStartTime) AS duration,
                (a.accountId = :accountId) AS allowUpdate,
                bs.bookingServiceStatus AS bookingServiceStatus
            FROM BookingServiceEntity bs
            INNER JOIN StaffEntity s ON s.staffId = bs.staffId
            INNER JOIN AccountEntity a ON a.accountId = s.accountId
            INNER JOIN ShopServiceEntity ss ON ss.serviceId = bs.serviceId
            INNER JOIN CategoryEntity c ON c.categoryId = ss.categoryId
            INNER JOIN BranchServiceEntity brs ON ss.serviceId = brs.serviceId
            ORDER BY priority ASC
            """)
    List<BookingServiceInfo> findAllInfo(Long accountId);

    @Query("""
            SELECT
                bs.bookingServiceId AS bookingServiceId,
                bs.bookingId AS bookingId,
                ss.serviceId AS serviceId,
                s.staffId AS staffId,
                c.categoryId AS categoryId,
                c.categoryName AS categoryName,
                c.priority AS priority,
                brs.branchServicePrice AS branchServicePrice,
                ss.serviceName AS serviceName,
                CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                a.phone AS staffPhone,
                bs.startTime AS startTime,
                bs.endTime AS endTime,
                bs.actualStartTime AS actualStartTime,
                bs.actualEndTime AS actualEndTime,
                (bs.actualEndTime - bs.actualStartTime) AS duration,
                (a.accountId = :accountId) AS allowUpdate,
                bs.bookingServiceStatus AS bookingServiceStatus
            FROM BookingServiceEntity bs
            INNER JOIN StaffEntity s ON s.staffId = bs.staffId
            INNER JOIN AccountEntity a ON a.accountId = s.accountId
            INNER JOIN ShopServiceEntity ss ON ss.serviceId = bs.serviceId
            INNER JOIN CategoryEntity c ON c.categoryId = ss.categoryId
            INNER JOIN BranchServiceEntity brs ON ss.serviceId = brs.serviceId
            WHERE bs.bookingServiceId = :bookingServiceId
            """)
    Optional<BookingServiceInfo> findInfoById(Long bookingServiceId, Long accountId);

    @Query("""
            SELECT
                a.phone AS cusPhone
            FROM BookingServiceEntity bs
            INNER JOIN BookingEntity b ON b.bookingId = bs.bookingId
            INNER JOIN AccountEntity a ON a.accountId = b.accountId
            WHERE bs.staffId = :staffId
            AND b.appointmentDate = :appointmentDate
            AND bs.bookingServiceStatus = com.realman.becore.dto.enums.EBookingServiceStatus.PENDING
            ORDER BY bs.startTime
            """)
    List<BookingServiceInfo> findNearBookingService(Long staffId, LocalDate appointmentDate);
}
