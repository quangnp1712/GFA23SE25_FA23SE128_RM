package com.realman.becore.controller.api.schedule;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.realman.becore.controller.api.schedule.models.ScheduleRequest;

import io.swagger.v3.oas.annotations.tags.Tag;

@RequestMapping("/schedule")
@Tag(name = "Schedule", description = "schedule management API")
@PreAuthorize("hasAnyAuthority({'schedule:add', 'schedule:view'})")
public interface SchedulesAPI {
    @PostMapping
    void save(Long accountId,@RequestBody List<ScheduleRequest> scheduleRequestList);
}
