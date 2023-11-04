import { FormControl } from '@angular/forms';

export namespace BranchApi {
  export interface Request {
    shopOwnerId: string;
    branchName: string;
    phone: string;
    address: string;
    placeId: string;
    status: string;
    numberStaffs: number;
    open: Date | null;
    close: Date | null;
    displayUrlList: string[];
    serviceIdList: string[];
  }

  export type displayUrlList = [];
  export type serviceIdList = [];
  export type RequestFormGroup = {
    shopOwnerId: FormControl<string>;
    branchName: FormControl<string>;
    phone: FormControl<string>;
    address: FormControl<string>;
    placeId: FormControl<string>;
    status: FormControl<string>;
    numberStaffs: FormControl<number>;
    open: FormControl<Date | null>;
    close: FormControl<Date | null>;
    displayUrlList: FormControl<string[]>;
    serviceIdList: FormControl<string[]>;
  };
}

export namespace BranchPagingApi {
  export interface Request {
    search: string;
    current: number;
    sorter: string;
    pageSize: number;
    orderDescending: boolean;
  }

  export interface Response {
    branchId: number;
    shopOwnerId: number;
    branchName: string;
    phone: string;
    address: string;
    status: string;
    numberStaffs: 0;
    open: {
      hour: number;
      minute: number;
      second: number;
      nano: number;
    };
    close: {
      hour: number;
      minute: number;
      second: number;
      nano: number;
    };
    displayUrlList: string[];
    serviceIdList: string[];
  }
}
