import { Injectable } from '@angular/core';
import { ComponentStore, OnStoreInit } from '@ngrx/component-store';
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
import {
  CategoryAddApi,
  CategoryDataGet,
  ServiceAddApi,
  ServicePagingApi,
} from '../model/service-api.model';
import { NzModalRef } from 'ng-zorro-antd/modal';
import { ServiceApiService } from '../api/service-api.service';

export interface BranchState {
  servicePaging: Paging<ServicePagingApi.Response>;
  loadingCount: number;
  categoryData: CategoryDataGet.Response;
}

const initialState: BranchState = {
  servicePaging: {
    content: [],
    current: 1,
    pageSize: 10,
    totalElements: 0,
    totalPages: 0,
  },
  loadingCount: 0,
  categoryData: { values: [] },
};

@Injectable()
export class ServiceStore
  extends ComponentStore<BranchState>
  implements OnStoreInit
{
  constructor(
    private _sApiSvc: ServiceApiService,
    private _cApiSvc: CommonApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService
  ) {
    super(initialState);
  }
  ngrxOnStoreInit() {
    this.#getCategoryData();
  }

  addressData!: AutocompleteApi.Response;
  options: string[] = [];

  pagingRequest: ServicePagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    search: '',
    sorter: '',
    orderDescending: false,
  };

  form = this._fb.group<ServiceAddApi.RequestFormGroup>({
    name: this._fb.control('', trimRequired),
    categoryId: this._fb.control(null, Validators.required),
    description: this._fb.control(''),
    duration: this._fb.control(0),
  });

  readonly getServicePaging = this.effect<never>(
    pipe(
      tap(() => this.updateLoading(true)),
      switchMap(() =>
        this._sApiSvc.paging(this.pagingRequest).pipe(
          tap({
            next: (resp) => {
              if (resp.content) this.patchState({ servicePaging: resp });
            },
            finalize: () => this.updateLoading(false),
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );

  readonly addCategory = this.effect<{
    model: CategoryAddApi.Request;
    modalRef: NzModalRef;
  }>(($params) =>
    $params.pipe(
      tap(() => this.updateLoading(true)),
      switchMap(({ model, modalRef }) =>
        this._sApiSvc.addCategory(model).pipe(
          tap({
            next: (resp) => {
              modalRef.destroy();
              this._nzMessageService.success('Thêm loại dịch vụ thành công');
            },
            error: () =>
              this._nzMessageService.error('Thêm loại dịch vụ thất bại.'),
            finalize: () => this.updateLoading(false),
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );

  readonly #getCategoryData = this.effect<never>(
    pipe(
      tap(() => this.updateLoading(true)),
      switchMap(() =>
        this._sApiSvc.CategoryDataGet().pipe(
          tap({
            next: (resp) => {
              this.patchState({ categoryData: resp });
            },
            finalize: () => this.updateLoading(false),
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );

  readonly addService = this.effect<{ model: ServiceAddApi.Request }>(
    ($params) =>
      $params.pipe(
        tap(() => this.updateLoading(true)),
        switchMap(({ model }) =>
          this._sApiSvc.addService(model).pipe(
            tap({
              next: (resp) => {
                this.form.reset();
                this._nzMessageService.success('Tạo dịch vụ thành công');
              },
              error: () => this._nzMessageService.error('Tạo dịch vụ thất bại'),
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
