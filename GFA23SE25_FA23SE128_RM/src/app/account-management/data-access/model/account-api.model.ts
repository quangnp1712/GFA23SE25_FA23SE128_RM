import { FormControl } from '@angular/forms';
import { RoleType } from 'src/app/share/data-access/api/enum/role.enum';

export namespace AccountAddApi {
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

export namespace AccountPagingApi {
  export interface Request {
    searches: string;
    role: string;
    current: number;
    pageSize: number;
    sorter: string;
    orderDescending: boolean;
  }

  export interface Response {
    accountId: number;
    branchId: number;
    thumbnailUrl: string;
    firstName: string;
    lastName: string;
    phone: string;
    address: string;
    dob: string;
    gender: string;
    status: string;
    branchName: string;
    branchAddress: string;
    itimacyLevel: string;
    professional: string;
    average: number;
    role: RoleType;
  }
}
