import { FormControl } from "@angular/forms";

export namespace OtpApi {
  export interface Request {
    otp: string;
  }

  export type RequestFormGroup = {
    otp: FormControl<string>;
  }
}
