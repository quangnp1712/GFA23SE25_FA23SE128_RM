import { FormControl } from "@angular/forms";

export namespace BranchApi {
  export interface Request {
    shopOwnerId: number;
    branchName: string;
    phone: string;
    address: string;
    placeId: string;
    status: string;
    numberStaffs: number;
    open: Date | null;
    close: Date | null;
    displayUrlList : string[];
    serviceIdList: string[];
  }

  export type displayUrlList = [];
  export type serviceIdList = [];
  export type RequestFormGroup = {
    shopOwnerId: FormControl<number>;
    branchName: FormControl<string>;
    phone: FormControl<string>;
    address: FormControl<string>;
    placeId: FormControl<string>;
    status: FormControl<string>;
    numberStaffs: FormControl<number>;
    open: FormControl<Date | null>;
    close: FormControl<Date | null>;
    displayUrlList : FormControl<string[]>;
    serviceIdList: FormControl<string[]>;
  }
}
