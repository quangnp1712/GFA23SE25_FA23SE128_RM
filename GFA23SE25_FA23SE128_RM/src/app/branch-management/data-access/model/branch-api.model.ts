import { FormControl } from '@angular/forms';

export namespace BranchApi {
  export interface Request {
    thumbnailUrl: string;
    shopOwnerId: string;
    branchName: string;
    phone: string;
    address: string;
    status: string;
    numberStaffs: number;
    open: Date | null;
    close: Date | null;
    branchDisplayList: branchDisplayList
    ,
    branchServiceList: branchServiceList
  }

  export type branchDisplayList = {
    url: string
  }[]

  export type branchServiceList = {
    serviceId: number,
    price: number
  }[]

  export type displayUrlList = [];
  export type serviceIdList = [];
  export type RequestFormGroup = {
    thumbnailUrl: FormControl<string>,
    shopOwnerId: FormControl<string>;
    branchName: FormControl<string>;
    phone: FormControl<string>;
    address: FormControl<string>;
    status: FormControl<string>;
    numberStaffs: FormControl<number>;
    open: FormControl<Date | null>;
    close: FormControl<Date | null>;
    branchDisplayList: FormControl<branchDisplayList>;
    branchServiceList: FormControl<branchServiceList>;
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

export namespace BranchUpdateApi {

  export type RequestFormGroup = {
    shopOwnerId: FormControl<string>;
    branchName: FormControl<string>;
    phone: FormControl<string>;
    address: FormControl<string>;
    status: FormControl<string>;
    numberStaffs: FormControl<number>;
    open: FormControl<Date | null>;
    close: FormControl<string | null>;
    displayUrlList: FormControl<string[]>;
    serviceIdList: FormControl<string[]>;
  };
  export interface BranchDataResponse {
    value: {
      branchId: number;
      shopOwnerId: string;
      branchName: string;
      phone: string;
      address: string;
      status: string;
      numberStaffs: 0;
      open: {

      };
      close: {

      };
      displayUrlList: string[];
      serviceIdList: string[];
    };
  }
}
