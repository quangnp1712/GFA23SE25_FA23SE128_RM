package com.realman.becore.repository.database.itimacy;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItimacyRepository extends JpaRepository<ItimacyEntity, Long> {

}
