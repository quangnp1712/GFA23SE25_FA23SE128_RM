import { Injectable } from '@angular/core';
import { ComponentStore, OnStoreInit } from '@ngrx/component-store';
import { Paging } from 'src/app/share/data-access/model/paging.type';
import { pagingSizeOptionsDefault } from 'src/app/share/data-access/const/paging-size-options-default.const';
import { pipe, tap, switchMap, catchError, EMPTY } from 'rxjs';
import { AutocompleteApi } from 'src/app/share/data-access/model/autocomplete-api.model';
import { CommonApiService } from 'src/app/share/data-access/api/common.service';
import { NonNullableFormBuilder, Validators } from '@angular/forms';
import { NzMessageService } from 'ng-zorro-antd/message';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';
import {
  CategoryDataGet,
  ServiceAddApi,
  ServiceGetApi,
  ServicePagingApi,
  ServiceUpdateApi,
} from '../model/service-api.model';
import { ServiceApiService } from '../api/service-api.service';
import { ActivatedRoute } from '@angular/router';

export interface BranchState {
  servicePaging: Paging<ServicePagingApi.Response>;
  loadingCount: number;
  categoryData: CategoryDataGet.Response;
  ServiceData: ServiceGetApi.Response;
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
  ServiceData: { value: { description: '', name: '', serviceId: 0 } },
};

@Injectable()
export class ServiceStore
  extends ComponentStore<BranchState>
  implements OnStoreInit
{
  constructor(
    private _sApiSvc: ServiceApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService,
    private _activatedRoute: ActivatedRoute
  ) {
    super(initialState);
  }
  ngrxOnStoreInit() {
    this.#getCategoryData();
  }

  id = Number(this._activatedRoute.snapshot.paramMap.get('serviceId'));
  addressData!: AutocompleteApi.Response;
  options: string[] = [];

  pagingRequest: ServicePagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    search: '',
    sorter: '',
    orderDescending: false,
  };

  form = this._fb.group<
    ServiceAddApi.RequestFormGroup | ServiceUpdateApi.RequestFormGroup
  >({
    name: this._fb.control('', trimRequired),
    categoryId: this._fb.control(null, Validators.required),
    description: this._fb.control(''),
    duration: this._fb.control(0),
    serviceDisplayList: this._fb.control([]),
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

  // readonly addCategory = this.effect<{
  //   model: CategoryAddApi.Request;
  //   modalRef: NzModalRef;
  // }>(($params) =>
  //   $params.pipe(
  //     tap(() => this.updateLoading(true)),
  //     switchMap(({ model, modalRef }) =>
  //       this._sApiSvc.addCategory(model).pipe(
  //         tap({
  //           next: (resp) => {
  //             modalRef.destroy();
  //             this._nzMessageService.success('Thêm loại dịch vụ thành công');
  //           },
  //           error: () =>
  //             this._nzMessageService.error('Thêm loại dịch vụ thất bại.'),
  //           finalize: () => this.updateLoading(false),
  //         }),
  //         catchError(() => EMPTY)
  //       )
  //     )
  //   )
  // );

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

  readonly getServiceData = this.effect<never>(
    pipe(
      tap(() => [this.updateLoading(true)]),
      switchMap(() =>
        this._sApiSvc.getService(this.id).pipe(
          tap({
            next: (resp) => {
              this.form.patchValue(resp.value)

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
