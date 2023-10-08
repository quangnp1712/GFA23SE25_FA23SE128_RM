import { FormControl } from "@angular/forms";

export namespace AccountApi {
  export interface Request {

  }
  export type RequestFormGroup = {
    username: FormControl<string>;
    phone: FormControl<string>;
    address: FormControl<string>;
    gender: FormControl<string>;
    dob: FormControl<string>;
    role: FormControl<string>;
    professional: FormControl<string>;
  };
}
