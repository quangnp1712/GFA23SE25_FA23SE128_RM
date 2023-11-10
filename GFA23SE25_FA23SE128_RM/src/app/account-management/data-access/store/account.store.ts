import { Injectable } from '@angular/core';
import { ComponentStore } from '@ngrx/component-store';
import { Paging } from 'src/app/share/data-access/model/paging.type';
import { pagingSizeOptionsDefault } from 'src/app/share/data-access/const/paging-size-options-default.const';
import {
  pipe,
  tap,
  switchMap,
  catchError,
  EMPTY,
  debounceTime,
  distinctUntilChanged,
} from 'rxjs';
import { AutocompleteApi } from 'src/app/share/data-access/model/autocomplete-api.model';
import { CommonApiService } from 'src/app/share/data-access/api/common.service';
import { NonNullableFormBuilder, Validators } from '@angular/forms';
import { NzMessageService } from 'ng-zorro-antd/message';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';
import { AccountApiService } from '../api/account.service';
import { AccountPagingApi } from '../model/account-api.model';

export interface AccountState {
  acountPaging: Paging<AccountPagingApi.Response>;
  loadingCount: number;
}

const initialState: AccountState = {
  acountPaging: { content: [], current: 1, pageSize: 10, totalElements: 0, totalPages: 0 },
  loadingCount: 0,
};

@Injectable()
export class AccountStore extends ComponentStore<AccountState> {
  constructor(
    private _aApiSvc: AccountApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService,
  ) {
    super(initialState);
  }

  addressData!: AutocompleteApi.Response;
  options: string[] = [];

  pagingRequest: AccountPagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    searches: '',
    sorter: '',
    orderDescending: false,
    role: 'SHOP_OWNER'
  };



  readonly getAccountPaging = this.effect<never>(
    pipe(
      tap(() => this.updateLoading(true)),
      switchMap(() =>
        this._aApiSvc.paging(this.pagingRequest).pipe(
          tap({
            next: (resp) => {
              if (resp.content) this.patchState({ acountPaging: resp });
            },
            finalize: () => this.updateLoading(false),
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );

  readonly updateLoading = this.updater((s, isAdd: boolean) => ({
    ...s,
    loadingCount: s.loadingCount + (isAdd ? 1 : -1),
  }));
}
