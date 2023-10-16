package com.realman.becore.repository.database.branch;

import java.time.LocalDateTime;
import java.util.List;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface BranchRepository extends JpaRepository<BranchEntity, Long> {

    @Query("""
            SELECT b FROM BranchEntity b
            WHERE ((:from IS NULL OR :to IS NULL)
            OR (b.open BETWEEN :from AND :to OR b.close BETWEEN :from AND :to) 
            OR (:from BETWEEN b.open AND b.close OR :to BETWEEN b.open AND b.close))
            AND (:#{#searches.isEmpty()} = FALSE) OR b.branchName LIKE %:searches% OR b.address LIKE %:searches%
                """)
    Page<BranchEntity> findAll(LocalDateTime from,
            LocalDateTime to,
            List<String> searches,
            Pageable pageable);
}
