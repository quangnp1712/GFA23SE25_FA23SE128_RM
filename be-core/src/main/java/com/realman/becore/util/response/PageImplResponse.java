package com.realman.becore.util.response;

import java.util.List;

public record PageImplResponse<T>(
    List<T> content,
    Long total,
    Integer pageSize,
    Integer current
) {

}
