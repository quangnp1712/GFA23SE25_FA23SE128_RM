import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders, HttpParams } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { AutocompleteApi } from '../model/autocomplete-api.model';

@Injectable({
  providedIn: 'root',
})
export class CommonApiService {
  constructor(private _http: HttpClient) {}
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      //'Authorization': 'my-auth-token'

    })
  };

  private REST_API_SERVER = 'http://localhost:8080';

  public autocomplete(address: string) {
    const url =`${this.REST_API_SERVER}/v1/autocomplete?address=${address}&limit=10&radius=1000&moreCompound=true`;
    return this._http
    .get<AutocompleteApi.Response>(url ,this.httpOptions)
    .pipe(catchError(this.handleError))
  }

  private handleError(error: HttpErrorResponse) {
    return throwError(
      error.error["message"]);
  };
}
