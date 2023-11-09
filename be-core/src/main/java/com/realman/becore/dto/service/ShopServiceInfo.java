package com.realman.becore.dto.service;

public interface ShopServiceInfo {
    void setServiceId(Long serviceId);
    void setName(String name);
    void setDescription(String description);
    void setDuration(Integer duration);
    void setBranchId(Long branchId);
    void setBranchName(String branchName);
    void setPrice(Long price);

    Long getServiceId();
    String getName();
    String getDescription();
    Integer getDuration();
    Long getBranchId();
    String getBranchName();
    Long getPrice();
}
