package com.realman.becore.repository.database.staff_schedule;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StaffScheduleRepository extends JpaRepository<StaffScheduleEntity, Long> {

}
