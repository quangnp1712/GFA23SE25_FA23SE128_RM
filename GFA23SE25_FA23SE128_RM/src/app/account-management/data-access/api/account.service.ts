import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders, HttpParams } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { AccountApi } from '../model/account-api.model';

@Injectable({
  providedIn: 'root',
})
export class AccountApiService {
  constructor(private _http: HttpClient) {}
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+ localStorage.getItem('token$')

    })
  };

  private REST_API_SERVER = 'http://localhost:8080';

  public createAccount(model: AccountApi.Request) {
    const url =`${this.REST_API_SERVER}/v1/auth/account/staff?professional=${model.professional}&branchId=${model.branch}`;
    return this._http
    .post<any>(url,model ,this.httpOptions)
    .pipe(catchError(this.handleError));
  }

  private handleError(error: HttpErrorResponse) {
    return throwError(
      error.error["message"]);
  };
}
