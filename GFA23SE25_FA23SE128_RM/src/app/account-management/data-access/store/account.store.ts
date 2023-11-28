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
import { FormGroup, NonNullableFormBuilder, Validators } from '@angular/forms';
import { NzMessageService } from 'ng-zorro-antd/message';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';
import { AccountApiService } from '../api/account.service';
import { AccountAddApi, AccountPagingApi } from '../model/account-api.model';
import { BranchNameApi } from 'src/app/share/data-access/model/branch-name.model';
import { BranchAddressApi } from 'src/app/share/data-access/model/branch-address-api.model';

export interface AccountState {
  acountPaging: Paging<AccountPagingApi.Response>;
  loadingCount: number;
  branchNameData: BranchNameApi.Response;
  addressData: string[];
}

const initialState: AccountState = {
  acountPaging: {
    content: [],
    current: 1,
    pageSize: 10,
    totalElements: 0,
    totalPages: 0,
  },
  loadingCount: 0,
  branchNameData: { values: [] },
  addressData: [],
};

@Injectable()
export class AccountStore extends ComponentStore<AccountState> {
  constructor(
    private _aApiSvc: AccountApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService,
    private _cApiSvc: CommonApiService
  ) {
    super(initialState);
  }

  addressData!: AutocompleteApi.Response;
  options: string[] = [];
  branchData: BranchAddressApi.Response = {
    value: { address: '', branchId: -1, branchName: '', numberStaffs: 0 },
  }

  pagingRequest: AccountPagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    searches: '',
    sorter: '',
    orderDescending: false,
    role: 'SHOP_OWNER',
  };

  form = new FormGroup<AccountAddApi.RequestFormGroup>({
    firstName: this._fb.control('', trimRequired),
    lastName: this._fb.control('', [trimRequired]),
    address: this._fb.control('', trimRequired),
    dob: this._fb.control('', Validators.required),
    gender: this._fb.control('', Validators.required),
    phone: this._fb.control('', [
      trimRequired,
      Validators.minLength(10),
      Validators.maxLength(12),
    ]),
    professional: this._fb.control(''),
    branch: this._fb.control(-1),
    thumbnailUrl: this._fb.control('123'),
    branchAddress: this._fb.control({value:'', disabled: true}),
    numberStaffs: this._fb.control({value:null, disabled: true})
  });

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

  readonly getBranchName = this.effect<string>(($params) =>
    $params.pipe(
      debounceTime(500),
      distinctUntilChanged(),
      switchMap((keyword: string) => {
        return this._cApiSvc.getBranchName(keyword).pipe(
          tap({
            next: (resp) => {
              this.patchState({ branchNameData: resp });
            },
            finalize: () => {},
          })
        );
      })
    )
  );

  readonly getBranchData = this.effect<number>(
    pipe(
      tap(() => this.updateLoading(true)),
      switchMap((branchId) =>
        this._cApiSvc.getBranchAddress(branchId).pipe(
          tap({
            next: (resp) => {
              this.form.controls.branchAddress.setValue(resp.value.address)
              this.form.controls.numberStaffs.setValue(resp.value.numberStaffs)
            },
            finalize: () => this.updateLoading(false),
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );

  readonly getAddress = this.effect<string>(($params) =>
    $params.pipe(
      debounceTime(500),
      distinctUntilChanged(),
      switchMap((keyword: string) => {
        return this._cApiSvc.autocomplete(keyword).pipe(
          tap({
            next: (resp) => {
              this.options = [];
              if (resp.value.predictions !== null) {
                resp.value.predictions.forEach((address) => {
                  this.options.push(address.description);
                });
                this.patchState({addressData: this.options})
              }
            },
            finalize: () => {},
          })
        );
      })
    )
  );

  readonly updateLoading = this.updater((s, isAdd: boolean) => ({
    ...s,
    loadingCount: s.loadingCount + (isAdd ? 1 : -1),
  }));
}
