package com.realman.becore.service.shop_owner;

import org.springframework.stereotype.Service;

import com.realman.becore.dto.shop_owner.ShopOwner;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopOwnerUserCaseService {
    @NonNull
    private final ShopOwnerCommandService shopOwnerCommandService;

    public Long save(ShopOwner shopOwner) {
        return shopOwnerCommandService.save(shopOwner);
    }

    public void updateAccountId(Long shopOwnerId, Long accountId) {
        shopOwnerCommandService.updateAccountId(shopOwnerId, accountId);
    }
}
