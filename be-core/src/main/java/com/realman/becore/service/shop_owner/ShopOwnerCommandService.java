package com.realman.becore.service.shop_owner;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.realman.becore.dto.shop_owner.ShopOwner;
import com.realman.becore.dto.shop_owner.ShopOwnerMapper;
import com.realman.becore.enums.EErrorMessage;
import com.realman.becore.error_handlers.exceptions.ResourceNotFoundException;
import com.realman.becore.repository.database.shop_owner.ShopOwnerEntity;
import com.realman.becore.repository.database.shop_owner.ShopOwnerRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopOwnerCommandService {
    @NonNull
    private final ShopOwnerRepository shopOwnerRepository;
    @NonNull
    private final ShopOwnerMapper shopOwnerMapper;

    @Transactional
    public Long save(ShopOwner shopOwner) {
        ShopOwnerEntity entity = shopOwnerRepository.save(shopOwnerMapper.toEntity(shopOwner));
        return entity.getShopOwnerId();
    }

    @Transactional
    public void updateAccountId(Long shopOwnerId, Long accountId) {
        ShopOwnerEntity entity = shopOwnerRepository.findById(shopOwnerId)
                .orElseThrow(() -> new ResourceNotFoundException(EErrorMessage.SHOPOWNER_NOT_FOUND.name()));
        entity.setAccountId(accountId);
        shopOwnerRepository.save(entity);
    }
}
