import { Injectable } from '@angular/core';
import { ComponentStore } from '@ngrx/component-store';
import { BranchApi, BranchPagingApi } from '../model/branch-api.model';
import { Paging } from 'src/app/share/data-access/model/paging.type';
import { BranchApiService } from '../api/branch.service';
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

export interface BranchState {
  branchPaging: Paging<BranchPagingApi.Response>;
  loadingCount: number;
  addressData: string[];
}

const initialState: BranchState = {
  branchPaging: { content: [], current: 1, pageSize: 10, total: 0 },
  loadingCount: 0,
  addressData: [],
};

@Injectable()
export class BranchStore extends ComponentStore<BranchState> {
  constructor(
    private _bApiSvc: BranchApiService,
    private _cApiSvc: CommonApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService,
  ) {
    super(initialState);
  }

  addressData!: AutocompleteApi.Response;
  options: string[] = [];

  pagingRequest: BranchPagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    search: '',
    sorter: '',
    orderDescending: false,
  };

  form = this._fb.group<BranchApi.RequestFormGroup>({
    shopOwnerId: this._fb.control(localStorage.getItem('accountId$')!),
    branchName: this._fb.control('', trimRequired),
    phone: this._fb.control('', [Validators.minLength(10), Validators.maxLength(11), trimRequired]),
    address: this._fb.control('', trimRequired),
    status: this._fb.control('OPEN'),
    numberStaffs: this._fb.control(0, [Validators.min(1), Validators.max(100)]),
    open: this._fb.control(null, Validators.required),
    close: this._fb.control(null, Validators.required),
    displayUrlList: this._fb.control(['string']),
    serviceIdList: this._fb.control([]),
  });

  readonly getBranchPaging = this.effect<never>(
    pipe(
      tap(() => this.updateLoading(true)),
      switchMap(() =>
        this._bApiSvc.paging(this.pagingRequest).pipe(
          tap({
            next: (resp) => {
              if (resp.content) this.patchState({ branchPaging: resp });
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

  readonly addBranch = this.effect<{ model: BranchApi.Request }>($params =>
    $params.pipe(
      tap(() => this.updateLoading(true)),
      switchMap(({ model }) =>
        this._bApiSvc.addBranch(model).pipe(
          tap({
            next: resp => {
                this._nzMessageService.success('Đăng ký chi nhánh thành công');
            },
            error: () => this._nzMessageService.error('Đăng ký chi nhánh thất bại.'),
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
