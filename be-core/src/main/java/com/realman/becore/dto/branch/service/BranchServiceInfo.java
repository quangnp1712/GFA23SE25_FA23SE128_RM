package com.realman.becore.dto.branch.service;

public interface BranchServiceInfo {
    void setBranchServiceId(Long branchServiceId);

    void setServiceId(Long serviceId);

    void setBranchId(Long branchId);

    void setServiceName(String serviceName);

    void setBranchName(String branchName);

    void setBranchThumbnailUrl(String branchThumbnailUrl);

    void setPrice(Long price);

    Long getBranchServiceId();

    Long getServiceId();

    Long getBranchId();

    String getServiceName();

    String getBranchName();

    String getBranchThumbnailUrl();

    Long getPrice();
}
