package com.realman.becore.util.response;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

public record PageRequestCustome() {
    public static PageRequest pageRequest(Integer pageSize, Integer current) {
        return PageRequest.of(pageSize, current, Sort.unsorted());

    }

    public static PageRequest pageRequest(Integer pageSize, Integer current, Sort sort) {
        return PageRequest.of(pageSize, current, sort);

    }
}
