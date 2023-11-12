package com.realman.becore.dto.branch.service;

public interface BranchServiceInfo {
    void setServiceId(Long serviceId);
    void setBranchId(Long branchId);
    void setBranchName(String branchName);
    void setThumbnailUrl(String thumbnailUrl);
    void setPrice(Long price);

    Long getServiceId();
    Long getBranchId();
    String getBranchName();
    String getThumbnailUrl();
    Long getPrice();
}
