import { Injectable } from '@angular/core';
import {
  HttpClient,
  HttpErrorResponse,
  HttpHeaders,
  HttpParams,
} from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { BranchApi, BranchPagingApi } from '../model/branch-api.model';
import { Paging } from 'src/app/share/data-access/model/paging.type';

@Injectable({
  providedIn: 'root',
})
export class BranchApiService {
  constructor(private _http: HttpClient) {}
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + localStorage.getItem('token$'),
    }),
  };

  private REST_API_SERVER = 'http://localhost:8080';

  public addBranch(model: BranchApi.Request) {
    const url = `${this.REST_API_SERVER}/v1/branches`;
    return this._http
      .post<any>(url, model, this.httpOptions)
      .pipe(catchError(this.handleError));
  }

  public paging(model: BranchPagingApi.Request) {
    const url = `${this.REST_API_SERVER}/v1/branches?searches=${model.searches}&current=${model.current}&sorter=${model.sorter}&pageSize=${model.pageSize}`;
    return this._http
      .get<Paging<BranchPagingApi.Response>>(url, this.httpOptions)
      .pipe(catchError(this.handleError));
  }

  private handleError(error: HttpErrorResponse) {
    return throwError(error.error['message']);
  }
}
