package com.realman.becore.dto.distance;
import com.realman.becore.dto.enums.EVehicleType;
import lombok.Builder;

@Builder
public record DistanceRequest(
                String origin,
                String destination,
                String vehicle) {

        public static DistanceRequest of(Double originLat, Double originLng,
                        Double desLat, Double desLng, EVehicleType vehicleType) {
                StringBuilder originBuilder = new StringBuilder(originLat.toString());
                StringBuilder destinationBuilder = new StringBuilder(desLat.toString());
                originBuilder.append("|").append(originLng.toString());
                destinationBuilder.append("|").append(desLng.toString());
                String vehicle = vehicleType.name().toLowerCase();
                return DistanceRequest.builder().origin(originBuilder.toString())
                                .destination(destinationBuilder.toString()).vehicle(vehicle).build();
        }

}
