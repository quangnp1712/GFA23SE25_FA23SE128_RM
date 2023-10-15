package com.realman.becore.repository.database.booking;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.realman.becore.dto.enums.EBookingStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "booking")
public class BookingEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingId;
    @Min(value = 1000, message = "Giá dịch vụ phải hơn 0 đồng")
    private Long totalPrice;
    @Min(value = 1, message = "Một booking phải ít nhất có 1 dịch vụ")
    private Integer totalServices;
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime start;
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime estimateEnd;
    private Boolean isEstimateApplied;
    private EBookingStatus status;

}
