package com.realman.becore.repository.database.booking_staff;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookingStaffRepository extends JpaRepository<BookingStaffEntity, Long> {

}
