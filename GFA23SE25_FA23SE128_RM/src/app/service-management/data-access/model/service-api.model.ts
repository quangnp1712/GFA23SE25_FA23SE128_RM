import { FormControl, FormGroup } from '@angular/forms';

export namespace CategoryAddApi {
  export interface Request {
    description: string;
    title: string;
  }

  export type RequestFormGroup = {
    description: FormControl<string>;
    title: FormControl<string>;
  };

  export function mapModel(frm: FormGroup<RequestFormGroup>): Request {
    const formValue = frm.getRawValue();
    return {
      description: formValue.description,
      title: formValue.title,
    };
  }
}

export namespace CategoryDataGet {
  export interface Response {
    values: {
      categoryId: number;
      title: string;
    }[];
  }
}

export namespace ServiceAddApi {
  export interface Request {
    description: string;
    name: string;
    categoryId: number;
    duration: number;
  }

  export type RequestFormGroup = {
    description: FormControl<string>;
    name: FormControl<string>;
    categoryId: FormControl<number | null>;
    duration: FormControl<number>;
  };

  export function mapModel(frm: FormGroup<RequestFormGroup>): Request {
    const formValue = frm.getRawValue();
    return {
      description: formValue.description,
      categoryId: formValue.categoryId!,
      duration: formValue.duration,
      name: formValue.name,
    };
  }
}

export namespace ServicePagingApi {
  export interface Request {
    search: string;
    current: number;
    sorter: string;
    pageSize: number;
    orderDescending: boolean;
  }

  export interface Response {
        description: string;
        name: string;
        branchServiceList: branchServiceList;
  }

  export type branchServiceList = {
    serviceId: number;
    branchId: number;
    serviceName: string;
    branchName: string;
    thumbnailUrl: string;
    price: number;
  }[];
}
