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
}
