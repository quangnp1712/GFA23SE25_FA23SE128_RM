package com.realman.becore.repository.database.recept_schedule;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReceptScheduleRepository extends JpaRepository<ReceptScheduleEntity, Long> {

}
