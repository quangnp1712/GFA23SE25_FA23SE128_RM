import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders, HttpParams } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { SignInApi } from '../model/sign-in-api.model';
import { OtpApi } from '../model/otp-api.model';

@Injectable({
  providedIn: 'root',
})
export class OtpApiService {
  constructor(private _http: HttpClient) {}
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      //'Authorization': 'my-auth-token'

    })
  };

  private REST_API_SERVER = 'http://localhost:8080';

  public getOtp(model: OtpApi.Request) {
    const url =`${this.REST_API_SERVER}/v1/otp/login`;
    return this._http
    .post<any>(url,model ,this.httpOptions)
    .pipe(catchError(this.handleError));
  }

  private handleError(error: HttpErrorResponse) {
    return throwError(
      error.error["message"]);
  };
}
