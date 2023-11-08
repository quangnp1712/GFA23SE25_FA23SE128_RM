package com.realman.becore.dto.service;

public interface ShopServiceInfo {
    void setName(String name);
    void setEstimateEndTime(Integer estimateEndTime);
    void setBranchId(Long branchId);
    void setBranchName(String branchName);
    void setPrice(Long price);

    String getName();
    Integer getEstimateEndTime();
    Long getBranchId();
    String getBranchName();
    Long getPrice();
}
