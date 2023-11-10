import { Injectable, OnInit } from '@angular/core';
import { ComponentStore, OnStoreInit } from '@ngrx/component-store';
import { BranchApi, BranchPagingApi, BranchUpdateApi } from '../model/branch-api.model';
import { Paging } from 'src/app/share/data-access/model/paging.type';
import { BranchApiService } from '../api/branch.service';
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
import { ActivatedRoute } from '@angular/router';

export interface BranchUpdateState {
  loadingCount: number;
  addressData: string[];
}

const initialState: BranchUpdateState = {
  loadingCount: 0,
  addressData: [],
};

@Injectable()
export class BranchUpdateStore extends ComponentStore<BranchUpdateState> implements OnStoreInit {
  constructor(
    private _bApiSvc: BranchApiService,
    private _cApiSvc: CommonApiService,
    private _fb: NonNullableFormBuilder,
    private _nzMessageService: NzMessageService,
    private _activatedRoute: ActivatedRoute
  ) {
    super(initialState);
  }
  ngrxOnStoreInit() {
    console.log(this.id);
    this.getBranchData()
  };


  id = Number(this._activatedRoute.snapshot.paramMap.get('id'));
  addressData!: AutocompleteApi.Response;
  options: string[] = [];

  form = this._fb.group<BranchUpdateApi.RequestFormGroup>({
    shopOwnerId: this._fb.control(localStorage.getItem('accountId$')!),
    branchName: this._fb.control('', trimRequired),
    phone: this._fb.control('', [
      Validators.minLength(10),
      Validators.maxLength(11),
      trimRequired,
    ]),
    address: this._fb.control('', trimRequired),
    status: this._fb.control('OPEN'),
    numberStaffs: this._fb.control(0, [Validators.min(1), Validators.max(100)]),
    open: this._fb.control(null, Validators.required),
    close: this._fb.control(null, Validators.required),
    displayUrlList: this._fb.control(['string']),
    serviceIdList: this._fb.control([]),
  });

  readonly getBranchData = this.effect<never>(
    pipe(
      tap(() => [this.updateLoading(true)]),
      switchMap(() =>
        this._bApiSvc.getBranch(this.id).pipe(
          tap({
            next: (resp) => {
              this.form.controls.address.setValue(resp.value.address)
              this.form.controls.branchName.setValue(resp.value.branchName)
              this.form.controls.shopOwnerId.setValue(resp.value.address)
              this.form.controls.numberStaffs.setValue(resp.value.numberStaffs)
              this.form.controls.displayUrlList.setValue(resp.value.displayUrlList)
              this.form.controls.serviceIdList.setValue(resp.value.serviceIdList)
              this.form.controls.phone.setValue(resp.value.phone)
              this.form.controls.status.setValue(resp.value.status)
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
                this.patchState({ addressData: this.options });
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
