import { FormControl } from '@angular/forms';

export namespace OtpApi {
  export interface Request {
    phone: string;
    passCode: string;
  }

  export type RequestFormGroup = {
    phone: FormControl<string>;
    passCode: FormControl<string>;
  };

  export interface Reponse {
    value: {
      expTime: string;
      isPhoneRegistered: boolean;
      jwtToken: string;
      phone: string;
      role: string;}
  }
}
