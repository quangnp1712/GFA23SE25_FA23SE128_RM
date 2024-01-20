import { FormControl, FormGroup } from "@angular/forms";

export namespace BookingPagingApi {
  export interface Request {
    search: string;
    current: number;
    sorter: string;
    pageSize: number;
    orderDescending: boolean;
    bookingServiceType: string;
    bookingServiceStatus: string;
  }

  export interface Response {
    bookingServiceId: number;
    bookingId: number;
    serviceId: number;
    staffId: number;
    bookingCode: string;
    serviceName: string;
    servicePrice: number;
    staffName: string;
    staffPhone: string;
    customerName: string;
    customerPhone: string;
    durationText: string;
    bookingServiceStatus: string;
    professional: string;
    bookingServiceType: string;
    bookingServiceTypeText: string;
    startAppointment: string;
    endAppointment: string;
    appointmentDate: string;
  }
}

export namespace BookingStaffGetApi {
  export interface Request {
    branchId: string;
    appointmentDate: string;
    startAppointment: string;
    endAppointment: string;
  }

  export interface Response {
    content: {
      accountId: number;
      firstName: string;
      lastName: string;
      phone: string;
      staff: {
        staffId: number;
      };
    }[];
  }
}

export namespace BookingChosenStylistApi {
  export interface Request {
    staffId: string;
    bookingServiceId: number;
  }

  export type RequestFormGroup = {
    staffId: FormControl<string>,
    bookingServiceId : FormControl<number>
  }

  export function mapModel(frm: FormGroup<RequestFormGroup>): Request {
    const formValue = frm.getRawValue();
    return {
      staffId: frm.controls.staffId.value,
      bookingServiceId: frm.controls.bookingServiceId.value
    };
  }
}
