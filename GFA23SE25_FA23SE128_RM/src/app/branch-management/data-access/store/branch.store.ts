import { Injectable } from "@angular/core";
import { ComponentStore } from "@ngrx/component-store";
import { BranchPagingApi } from "../model/branch-api.model";
import { Paging } from "src/app/share/data-access/model/paging.type";
import { BranchApiService } from "../api/branch.service";
import { pagingSizeOptionsDefault } from "src/app/share/data-access/const/paging-size-options-default.const";
import { pipe, tap, switchMap, catchError, EMPTY } from "rxjs";

export interface BranchState {
  branchPaging: Paging<BranchPagingApi.Response>;
  loadingCount: number,
}

const initialState: BranchState = {
  branchPaging: {content: [], current: 1, pageSize: 10, total: 0},
  loadingCount: 0,
}

@Injectable()
export class BranchStore extends ComponentStore<BranchState> {
  constructor(private _bApiSvc: BranchApiService) {
    super(initialState);
  }

  pagingRequest: BranchPagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    search: '',
    sorter: '',
    orderDescending: false,
  };

  readonly getBranchPaging = this.effect<never>(
    pipe(
      tap(() => this.updateLoading(true)),
      switchMap(() =>
        this._bApiSvc.paging(this.pagingRequest).pipe(
          tap({
            next: resp => {
              if (resp.content) this.patchState({ branchPaging: resp });
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
