package com.realman.becore.service.branch;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Service;
import com.realman.becore.dto.branch.Branch;
import com.realman.becore.dto.branch.BranchGroupByCity;
import com.realman.becore.dto.branch.BranchGroupByCityInfo;
import com.realman.becore.dto.branch.BranchGroupByCitySearchCriteria;
import com.realman.becore.dto.branch.BranchId;
import com.realman.becore.dto.branch.BranchMapper;
import com.realman.becore.dto.branch.BranchSearchCriteria;
import com.realman.becore.dto.branch.display.BranchDisplay;
import com.realman.becore.dto.branch.service.BranchService;
import com.realman.becore.dto.goong.distance.Distance;
import com.realman.becore.dto.goong.distance.DistanceRequest;
import com.realman.becore.dto.goong.distance.DistanceResponse;
import com.realman.becore.dto.goong.distance.ElementList;
import com.realman.becore.dto.goong.distance.Elements;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.branch.BranchEntity;
import com.realman.becore.repository.database.branch.BranchRepository;
import com.realman.becore.service.branch.display.BranchDisplayQueryService;
import com.realman.becore.service.branch.service.BranchServiceUseCaseService;
import com.realman.becore.service.goong.distance.DistanceUseCaseService;
import com.realman.becore.util.CustomPagination;
import com.realman.becore.util.response.PageRequestCustom;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BranchQueryService {
        @NonNull
        private final BranchRepository branchRepository;
        @NonNull
        private final BranchDisplayQueryService branchDisplayQueryService;
        @NonNull
        private final DistanceUseCaseService distanceUseCaseService;
        @NonNull
        private final BranchServiceUseCaseService branchServiceUseCaseService;
        @NonNull
        private final BranchMapper branchMapper;

        public Branch findById(BranchId branchId) {
                BranchEntity entity = branchRepository.findById(branchId.value())
                                .orElseThrow(ResourceNotFoundException::new);
                List<BranchDisplay> branchDisplayList = branchDisplayQueryService.findAll(branchId.value());
                List<BranchService> branchServiceList = branchServiceUseCaseService.findAllByBranchId(branchId.value());
                List<String> displayUrlList = branchDisplayList.stream().map(BranchDisplay::url).toList();
                return branchMapper.toDto(entity, displayUrlList, branchServiceList);
        }

        public Page<Branch> findAll(BranchSearchCriteria searchCriteria, PageRequestCustom pageRequestCustom) {
                List<BranchEntity> entities = branchRepository.findAll(
                                searchCriteria.from(),
                                searchCriteria.to(),
                                searchCriteria.search());

                List<Branch> dtoList = entities.stream().map(entity -> {
                        Map<Long, List<BranchDisplay>> branchDisplayMap = branchDisplayQueryService
                                        .findAll(entity.getBranchId())
                                        .stream().collect(Collectors.groupingBy(BranchDisplay::branchId));
                        Map<Long, List<BranchService>> branchServiceMap = branchServiceUseCaseService
                                        .findAllByBranchId(entity.getBranchId()).stream()
                                        .collect(Collectors.groupingBy(BranchService::branchId));
                        List<BranchDisplay> branchDisplayList = branchDisplayMap.get(entity.getBranchId());
                        List<String> branchUrlList = Objects.nonNull(branchDisplayList)
                                        ? branchDisplayList.stream().map(BranchDisplay::url).toList()
                                        : new ArrayList<>();
                        Double distance = calculateDistance(searchCriteria.originLat(),
                                        searchCriteria.originLng(), entity.getLat(), entity.getLng());
                        return branchMapper.toDto(entity, distance, branchUrlList,
                                        branchServiceMap.get(entity.getBranchId()));
                }).toList();
                dtoList = dtoList.stream().sorted(Comparator.comparing(Branch::distance)).toList();
                CustomPagination<Branch> customPagination = new CustomPagination<>(dtoList);
                List<Branch> responses = customPagination.of((pageRequestCustom.current() - 1),
                                pageRequestCustom.pageRequest().getPageSize());
                if (searchCriteria.isShowDistance()) {
                        responses = responses.stream().map(response -> {
                                DistanceRequest request = DistanceRequest.of(searchCriteria.originLat(),
                                                searchCriteria.originLng(), response.lat(), response.lng());
                                DistanceResponse distance = distanceUseCaseService.requestDistance(request);
                                List<Elements> distanceElements = distance.rows().stream()
                                                .map(ElementList::elements).findAny().orElse(new ArrayList<>());
                                String distanceKilometer = distanceElements.stream().map(Elements::distance)
                                                .map(Distance::text).findAny().orElse("");
                                return branchMapper.updateDto(response, distanceKilometer);
                        }).toList();
                }

                return new PageImpl<>(responses, pageRequestCustom.pageRequest(), dtoList.size());
        }

        public List<BranchGroupByCity> groupByCity() {
                List<BranchGroupByCityInfo> infoList = branchRepository.groupByCity();
                return infoList.stream().map(branchMapper::toDto).toList();
        }

        public List<BranchGroupByCity> findBranchByCity(BranchGroupByCitySearchCriteria searchCriteria,
                        PageRequestCustom pageRequestCustom) {
                Page<BranchEntity> branchGroupByCities = branchRepository.findAll(searchCriteria.city(),
                                pageRequestCustom.pageRequest());
                Map<String, List<BranchEntity>> entityCityMap = branchGroupByCities.stream()
                                .collect(Collectors.groupingBy(BranchEntity::getCity));

                List<BranchGroupByCity> branchGroupByCityList = new ArrayList<>();
                entityCityMap.keySet().forEach(city -> {
                        List<Branch> dtoList = entityCityMap.get(city).stream()
                                        .map(branch -> {
                                                Map<Long, List<BranchDisplay>> branchDisplayMap = branchDisplayQueryService
                                                                .findAll().stream()
                                                                .collect(Collectors.groupingBy(
                                                                                BranchDisplay::branchId));
                                                Map<Long, List<BranchService>> branchServiceMap = branchServiceUseCaseService
                                                                .findAllByBranchId(branch.getBranchId())
                                                                .stream().collect(Collectors.groupingBy(
                                                                                BranchService::branchId));
                                                List<String> urlDisplayList = branchDisplayMap
                                                                .get(branch.getBranchId()).stream()
                                                                .map(BranchDisplay::url).toList();
                                                return branchMapper.toDto(branch, urlDisplayList,
                                                                branchServiceMap.get(branch.getBranchId()));
                                        }).toList();
                        if (searchCriteria.isShowDistance()) {
                                dtoList = dtoList.stream().map(branch -> {
                                        DistanceRequest request = DistanceRequest
                                                        .of(searchCriteria.lat(),
                                                                        searchCriteria.lng(),
                                                                        branch.lat(), branch.lng());
                                        DistanceResponse distance = distanceUseCaseService
                                                        .requestDistance(request);
                                        List<Elements> distanceElements = distance.rows().stream()
                                                        .map(ElementList::elements).findAny()
                                                        .orElse(new ArrayList<>());
                                        String distanceKilometer = distanceElements.stream()
                                                        .map(Elements::distance)
                                                        .map(Distance::text).findAny().orElse("");
                                        return branchMapper.updateDto(branch, distanceKilometer);
                                })
                                                .toList();
                        }
                        BranchGroupByCity branchGroupByCity = BranchGroupByCity.builder()
                                        .city(city).branchList(dtoList).build();
                        branchGroupByCityList.add(branchGroupByCity);
                });
                return branchGroupByCityList;
        }

        public List<Branch> findByServiceId(Long serviceId) {
                List<BranchEntity> branchList = branchRepository.findByServiceId(serviceId);
                return branchList.stream().map(branch -> {
                        Map<Long, List<BranchDisplay>> branchDisplayMap = branchDisplayQueryService
                                        .findAll(branch.getBranchId())
                                        .stream().collect(Collectors.groupingBy(BranchDisplay::branchId));
                        Map<Long, List<BranchService>> branchServiceMap = branchServiceUseCaseService
                                        .findAllByBranchId(branch.getBranchId()).stream()
                                        .collect(Collectors.groupingBy(BranchService::branchId));
                        List<String> urlDisplayList = branchDisplayMap.get(branch.getBranchId())
                                        .stream().map(BranchDisplay::url).toList();
                        return branchMapper.toDto(branch, urlDisplayList, branchServiceMap.get(branch.getBranchId()));
                }).toList();
        }

        private Double calculateDistance(Double originLat, Double originLng,
                        Double desLat, Double desLng) {
                Double distance = Math.sqrt(Math.pow((desLat - originLat), 2.0)
                                + Math.pow((desLng - originLng), 2.0));
                return distance;
        }
}
