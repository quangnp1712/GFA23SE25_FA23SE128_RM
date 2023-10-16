import { FormControl } from "@angular/forms";

export namespace AccountApi {
  export interface Request {
    firstName: string;
    lastName: string;
    phone: string;
    address: string;
    gender: string;
    dob: string;
    branch: string;
    professional: string;
    thumbnailUrl: string;
  }
  export type RequestFormGroup = {
    firstName: FormControl<string>;
    lastName: FormControl<string>;
    phone: FormControl<string>;
    address: FormControl<string>;
    gender: FormControl<string>;
    dob: FormControl<string>;
    branch: FormControl<string>;
    professional: FormControl<string>;
    thumbnailUrl: FormControl<string>;
  };
}
