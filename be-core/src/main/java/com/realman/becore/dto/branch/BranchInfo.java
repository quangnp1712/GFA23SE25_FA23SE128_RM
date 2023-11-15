package com.realman.becore.dto.branch;

public interface BranchInfo {
    void setBranchId(Long brnachId);
    void setBranchName(String brnachName);
    void setAddress(String address);
    void setNumberStaffs(Integer numberStaffs);

    Long getBranchId();
    String getBranchName();
    String getAddress();
    Integer getNumberStaffs();
}
