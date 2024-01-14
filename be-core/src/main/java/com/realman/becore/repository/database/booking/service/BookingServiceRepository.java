package com.realman.becore.repository.database.booking.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.realman.becore.dto.booking.service.BookingServiceInfo;

@Repository
public interface BookingServiceRepository extends JpaRepository<BookingServiceEntity, Long> {
        @Query("""
                        SELECT
                            bs.bookingServiceId AS bookingServiceId,
                            bs.bookingId AS bookingId,
                            ss.serviceId AS serviceId,
                            s.staffId AS staffId,
                            s.professional AS professional,
                            c.categoryId AS categoryId,
                            c.categoryName AS categoryName,
                            c.priority AS priority,
                            COALESCE(brs.branchServicePrice, ss.servicePrice) AS servicePrice,
                            ss.serviceName AS serviceName,
                            CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                            a.phone AS staffPhone,
                            bs.startAppointment AS startAppointment,
                            bs.endAppointment AS endAppointment,
                            bs.actualStartAppointment AS actualStartAppointment,
                            bs.actualEndAppointment AS actualEndAppointment,
                            (bs.actualEndAppointment - bs.actualStartAppointment) AS duration,
                            bs.bookingServiceStatus AS bookingServiceStatus,
                            bs.bookingServiceType AS bookingServiceType
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
                            s.professional AS professional,
                            c.categoryId AS categoryId,
                            c.categoryName AS categoryName,
                            c.priority AS priority,
                            COALESCE(brs.branchServicePrice, ss.servicePrice) AS servicePrice,
                            ss.serviceName AS serviceName,
                            CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                            a.phone AS staffPhone,
                            bs.startAppointment AS startAppointment,
                            bs.endAppointment AS endAppointment,
                            bs.actualStartAppointment AS actualStartAppointment,
                            bs.actualEndAppointment AS actualEndAppointment,
                            (bs.actualEndAppointment - bs.actualStartAppointment) AS duration,
                            (a.accountId = :accountId) AS allowUpdate,
                            bs.bookingServiceStatus AS bookingServiceStatus,
                            bs.bookingServiceType AS bookingServiceType
                        FROM BookingServiceEntity bs
                        LEFT JOIN StaffEntity s ON s.staffId = bs.staffId
                        LEFT JOIN AccountEntity a ON a.accountId = s.accountId
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
                            s.professional AS professional,
                            c.categoryId AS categoryId,
                            c.categoryName AS categoryName,
                            c.priority AS priority,
                            COALESCE(brs.branchServicePrice, ss.servicePrice) AS branchServicePrice,
                            ss.serviceName AS serviceName,
                            CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                            a.phone AS staffPhone,
                            bs.startAppointment AS startAppointment,
                            bs.endAppointment AS endAppointment,
                            bs.actualStartAppointment AS actualStartAppointment,
                            bs.actualEndAppointment AS actualEndAppointment,
                            (bs.actualEndAppointment - bs.actualStartAppointment) AS duration,
                            (a.accountId = :accountId) AS allowUpdate,
                            bs.bookingServiceStatus AS bookingServiceStatus,
                            bs.bookingServiceType AS bookingServiceType
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
                        SELECT bs
                        FROM BookingServiceEntity bs WHERE bs.bookingServiceId != :bookingServiceId AND bs.bookingId = :bookingId
                        """)
        List<BookingServiceEntity> findAllNotEqualId(Long bookingId, Long bookingServiceId);

        @Query("""
                        SELECT bs
                        FROM BookingServiceEntity bs
                        WHERE bs.bookingId = :bookingId AND bs.bookingServiceId != :currentBookingServiceId
                        """)
        List<BookingServiceEntity> findOtherByBookingId(Long bookingId, Long currentBookingServiceId);

        @Query("""
                        SELECT
                            bs.bookingServiceId AS bookingServiceId,
                            bs.bookingId AS bookingId,
                            ss.serviceId AS serviceId,
                            s.staffId AS staffId,
                            s.professional AS professional,
                            c.categoryId AS categoryId,
                            c.categoryName AS categoryName,
                            c.priority AS priority,
                            COALESCE(brs.branchServicePrice, ss.servicePrice) AS servicePrice,
                            ss.serviceName AS serviceName,
                            CONCAT(a.firstName, ' ', a.lastName) AS staffName,
                            a.phone AS staffPhone,
                            bs.startAppointment AS startAppointment,
                            bs.endAppointment AS endAppointment,
                            bs.actualStartAppointment AS actualStartAppointment,
                            bs.actualEndAppointment AS actualEndAppointment,
                            (bs.actualEndAppointment - bs.actualStartAppointment) AS duration,
                            (s.staffId = :staffId) AS allowUpdate
                        FROM BookingServiceEntity bs
                        INNER JOIN StaffEntity s ON s.staffId = bs.staffId
                        INNER JOIN AccountEntity a ON a.accountId = s.accountId
                        INNER JOIN ShopServiceEntity ss ON ss.serviceId = bs.serviceId
                        INNER JOIN CategoryEntity c ON c.categoryId = ss.categoryId
                        INNER JOIN BranchServiceEntity brs ON ss.serviceId = brs.serviceId
                        WHERE bs.staffId = :staffId
                        """)
        Page<BookingServiceInfo> findByStaffId(Long staffId, Pageable pageable);
}
