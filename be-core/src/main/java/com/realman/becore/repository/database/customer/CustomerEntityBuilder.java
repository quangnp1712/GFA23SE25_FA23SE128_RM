package com.realman.becore.repository.database.customer;

import java.util.List;
import java.util.Objects;

import com.realman.becore.repository.database.account.AccountEntity;
import com.realman.becore.repository.database.itimacy.ItimacyEntity;
import com.realman.becore.repository.database.rating.RatingEntity;

public class CustomerEntityBuilder {
    private CustomerEntity customerEntity;

    public CustomerEntityBuilder() {
        this.customerEntity = new CustomerEntity();
    }

    public CustomerEntityBuilder setServiceCount(Long serviceCount) {
        if (Objects.isNull(serviceCount)) {
            this.customerEntity.setServiceCount(0L);
        }
        this.customerEntity.setServiceCount(serviceCount);
        return this;
    }

    public CustomerEntityBuilder setProfitProvided(Long profitProvided) {
        if (Objects.isNull(profitProvided)) {
            this.customerEntity.setProfitProvided(0L);
        }
        this.customerEntity.setProfitProvided(profitProvided);
        return this;
    }

    public CustomerEntityBuilder setAccount(AccountEntity accountEntity) {
        if (Objects.isNull(accountEntity)) {
            this.customerEntity.setAccount(null);
        }
        this.customerEntity.setAccount(accountEntity);
        ;
        return this;
    }

    public CustomerEntityBuilder setRatings(List<RatingEntity> ratings) {
        if (Objects.isNull(ratings)) {
            this.customerEntity.setRatings(null);
        }
        this.customerEntity.setRatings(ratings);
        return this;
    }

    public CustomerEntityBuilder setItimacy(ItimacyEntity itimacyEntity) {
        if (Objects.isNull(itimacyEntity)) {
            this.customerEntity.setItimacy(null);
        }
        this.customerEntity.setRatings(null);
        return this;
    }

    public CustomerEntity build() {
        return this.customerEntity;
    }
}
