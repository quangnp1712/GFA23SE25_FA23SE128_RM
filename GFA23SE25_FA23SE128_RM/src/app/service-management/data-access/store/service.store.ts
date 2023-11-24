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
import { CategoryAddApi } from '../model/service-api.model';
import { NzModalRef } from 'ng-zorro-antd/modal';
import { ServiceApiService } from '../api/service-api.service';

export interface BranchState {
  // branchPaging: Paging<BranchPagingApi.Response>;
  loadingCount: number;
  addressData: string[];
}

const initialState: BranchState = {
  // branchPaging: { content: [], current: 1, pageSize: 10, totalElements: 0, totalPages: 0 },
  loadingCount: 0,
  addressData: [],
};

@Injectable()
export class ServiceStore extends ComponentStore<BranchState> {
  constructor(
    private _sApiSvc: ServiceApiService,
    private _cApiSvc: CommonApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService,
  ) {
    super(initialState);
  }

  addressData!: AutocompleteApi.Response;
  options: string[] = [];

  // pagingRequest: BranchPagingApi.Request = {
  //   current: 1,
  //   pageSize: pagingSizeOptionsDefault[0],
  //   search: '',
  //   sorter: '',
  //   orderDescending: false,
  // };

  // form = this._fb.group<BranchApi.RequestFormGroup>({
  //   shopOwnerId: this._fb.control(localStorage.getItem('accountId$')!),
  //   branchName: this._fb.control('', trimRequired),
  //   phone: this._fb.control('', [Validators.minLength(10), Validators.maxLength(11), trimRequired]),
  //   address: this._fb.control('', trimRequired),
  //   status: this._fb.control('OPEN'),
  //   numberStaffs: this._fb.control(0, [Validators.min(1), Validators.max(100)]),
  //   open: this._fb.control(null, Validators.required),
  //   close: this._fb.control(null, Validators.required),
  //   branchDisplayList: this._fb.control([]),
  //   branchServiceList: this._fb.control([]),
  //   thumbnailUrl: this._fb.control('123', trimRequired),
  // });

  // readonly getBranchPaging = this.effect<never>(
  //   pipe(
  //     tap(() => this.updateLoading(true)),
  //     switchMap(() =>
  //       this._bApiSvc.paging(this.pagingRequest).pipe(
  //         tap({
  //           next: (resp) => {
  //             if (resp.content) this.patchState({ branchPaging: resp });
  //           },
  //           finalize: () => this.updateLoading(false),
  //         }),
  //         catchError(() => EMPTY)
  //       )
  //     )
  //   )
  // );

  readonly addCategory = this.effect<{ model: CategoryAddApi.Request; modalRef: NzModalRef }>($params =>
    $params.pipe(
      tap(() => this.updateLoading(true)),
      switchMap(({ model, modalRef }) =>
        this._sApiSvc.addBranch(model).pipe(
          tap({
            next: resp => {
              modalRef.destroy();
              this._nzMessageService.success('Thêm loại dịch vụ thành công');
            },
            error: () => this._nzMessageService.error('Thêm loại dịch vụ thất bại.'),
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
