import { FormControl, FormGroup } from "@angular/forms";

export namespace CategoryAddApi {
  export interface Request {
    description: string;
    title: string;
  }

  export type RequestFormGroup = {
    description: FormControl<string>,
    title: FormControl<string>
  }

  export function mapModel(frm: FormGroup<RequestFormGroup>): Request {
    const formValue = frm.getRawValue();
    return {
      description: formValue.description,
      title: formValue.title
    };
  }
}
