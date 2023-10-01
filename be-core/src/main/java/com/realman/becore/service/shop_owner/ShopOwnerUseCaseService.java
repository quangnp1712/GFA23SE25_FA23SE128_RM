package com.realman.becore.service.shop_owner;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.shop_owner.ShopOwner;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopOwnerUseCaseService {
    @NonNull
    private final ShopOwnerCommandService shopOwnerCommandService;
    @NonNull
    private final ShopOwnerQueryService shopOwnerQueryService;

    @Transactional
    public Long save(ShopOwner shopOwner) {
        return shopOwnerCommandService.save(shopOwner);
    }

    @Transactional
    public void updateAccountId(Long shopOwnerId, Long accountId) {
        shopOwnerCommandService.updateAccountId(shopOwnerId, accountId);
    }

    public ShopOwner findByAccountId(Long accountID) {
        return shopOwnerQueryService.findByAccountId(accountID);
    }
}
