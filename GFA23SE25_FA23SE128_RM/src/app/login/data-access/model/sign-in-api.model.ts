import { FormControl } from "@angular/forms";

export namespace SignInApi {
  export interface Request {
    phone: string;
  }

  export type RequestFormGroup = {
    phone: FormControl<string>;
  }
}
