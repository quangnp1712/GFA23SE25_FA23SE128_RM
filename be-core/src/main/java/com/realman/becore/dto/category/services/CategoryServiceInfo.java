package com.realman.becore.dto.category.services;

import com.realman.becore.dto.enums.ECategory;
import com.realman.becore.dto.enums.EServiceStatus;

public interface CategoryServiceInfo {
    void setCategoryServiceId(Long categoryServiceId);
    void setCategoryId(Long categoryId);
    void setServiceId(Long serviceId);
    void setTitle(ECategory title);
    void setName(String name);
    void setDuration(Integer duration);
    void setStatus(EServiceStatus status);

    Long getCategoryServiceId();
    Long getCategoryId();
    Long getServiceId();
    ECategory getTitle();
    String getName();
    Integer getDuration();
    EServiceStatus getStatus();
}
