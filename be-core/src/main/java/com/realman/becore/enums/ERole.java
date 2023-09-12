package com.realman.becore.enums;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ERole {
        STAFF_STYLIST(Set.of(EPermission.STAFF_VIEW.getPermission(), EPermission.BRANCH_VIEW.getPermission(),
                        EPermission.SCHEDULE_VIEW.getPermission(), EPermission.SCHEDULE_UPDATE.getPermission())),
        STAFF_MESSEUR(Set.of(EPermission.STAFF_VIEW.getPermission(), EPermission.BRANCH_VIEW.getPermission(),
                        EPermission.SCHEDULE_VIEW.getPermission(), EPermission.SCHEDULE_UPDATE.getPermission())),
        RECEPTIONIST(Set.of(EPermission.STAFF_VIEW.getPermission(), EPermission.BRANCH_VIEW.getPermission(),
                        EPermission.BOOKING_ADD.getPermission(),
                        EPermission.BOOKING_UPDATE.getPermission(),
                        EPermission.SCHEDULE_VIEW.getPermission(), EPermission.SCHEDULE_UPDATE.getPermission())),
        BRANCHMANAGER(Set.of(EPermission.STAFF_VIEW.getPermission(), EPermission.STAFF_ADD.getPermission(),
                        EPermission.SCHEDULE_UPDATE.getPermission(), EPermission.SCHEDULE_VIEW.getPermission(),
                        EPermission.SCHEDULE_ADD.getPermission(), EPermission.BRANCH_VIEW.getPermission())),
        SHOPOWNER(Set.of(EPermission.STAFF_VIEW.getPermission(), EPermission.STAFF_ADD.getPermission(),
                        EPermission.STAFF_UPDATE.getPermission(), EPermission.BRANCH_VIEW.getPermission(),
                        EPermission.BRANCH_ADD.getPermission(), EPermission.BRANCH_UPDATE.getPermission(),
                        EPermission.SCHEDULE_VIEW.getPermission())),
        CUSTOMER(Set.of(EPermission.BOOKING_ADD.name(), EPermission.BOOKING_UPDATE.name(),
                        EPermission.BOOKING_CANCLE.name(), EPermission.STAFF_VIEW.name(),
                        EPermission.BRANCH_VIEW.name(),
                        EPermission.SCHEDULE_VIEW.name()));

        private Set<String> permissions;

        public List<SimpleGrantedAuthority> getAuthorities() {
                List<SimpleGrantedAuthority> authorities = new ArrayList<>();
                authorities.add(new SimpleGrantedAuthority("ROLE_" + this.name()));
                this.permissions.forEach(permission -> authorities.add(new SimpleGrantedAuthority(permission)));
                return authorities;
        }
}
