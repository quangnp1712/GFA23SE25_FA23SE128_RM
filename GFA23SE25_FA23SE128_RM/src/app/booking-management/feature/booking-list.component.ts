import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzTableModule, NzTableQueryParams } from 'ng-zorro-antd/table';
import { NzTableDefaultSettingDirective } from 'src/app/share/ui/directive/nz-table-default-setting.directive';
import { FormsModule, NonNullableFormBuilder } from '@angular/forms';
import { provideComponentStore } from '@ngrx/component-store';
import { RxLet } from '@rx-angular/template/let';
import { NzMessageService } from 'ng-zorro-antd/message';
import { BookingStore } from '../data-access/store/booking.store';
import { NzModalService } from 'ng-zorro-antd/modal';
import { BookingChosenStylistModalComponent } from '../ui/booking-chosen-stylist-modal.component';
import {
  BookingChosenStylistApi,
  BookingPagingApi,
} from '../data-access/model/booking-api.model';
import { tap } from 'rxjs';

@Component({
  selector: 'app-booking-list',
  standalone: true,
  imports: [
    CommonModule,
    NzBreadCrumbModule,
    NzDividerModule,
    NzGridModule,
    NzInputModule,
    NzIconModule,
    NzButtonModule,
    NzTableModule,
    RouterLink,
    NzSelectModule,
    FormsModule,
    NzTableDefaultSettingDirective,
    RxLet,
  ],

  providers: [provideComponentStore(BookingStore), NzMessageService, NzModalService],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item> Quản lý booking</nz-breadcrumb-item>
      <nz-breadcrumb-item>Danh sách booking</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div nz-row>
      <div nz-col nzSpan="22" class="">
        <nz-input-group nzSearch [nzAddOnAfter]="suffixIconButton">
          <input
            type="text"
            nz-input
            placeholder="Tìm theo tên"
            [(ngModel)]="bStore.pagingRequest.search"
            (keyup.enter)="onSearch()"
          />
        </nz-input-group>
        <ng-template #suffixIconButton>
          <button nz-button nzType="primary" nzSearch (click)="onSearch()">
            <span nz-icon nzType="search"></span>
          </button>
        </ng-template>
      </div>
      <div nz-col nzSpan="2" class="tw-text-center">
        <button
          nz-button
          nzType="primary"
          [routerLink]="['/branch-management', 'create-branch']"
        >
          Tạo chi nhánh
        </button>
      </div>
      <div nz-col nzSpan="24" class="tw-mt-5">
        <ng-container *rxLet="vm$ as vm">
          <nz-table
            appNzTableDefaultSetting
            class="tw-mr-4"
            [nzData]="vm.bookingPaging.content"
            [nzTotal]="vm.bookingPaging.totalElements"
            [(nzPageIndex)]="bStore.pagingRequest.current"
            [(nzPageSize)]="bStore.pagingRequest.pageSize"
            (nzQueryParams)="onTableQueryParamsChange($event)"
            [nzShowTotal]="totalText"
            [nzLoading]="!!vm.loadingCount"
            nzShowSizeChanger
          >
            <thead>
              <ng-template #totalText let-total let-range="range">
                <span
                  >{{ range[0] }} - {{ range[1] }} of {{ total }}
                  {{ 'Branches' }}</span
                >
              </ng-template>
              <tr>
                <th
                  nzColumnKey="stt"
                  [nzSortFn]="true"
                  [nzSortDirections]="['ascend', 'descend']"
                  [nzSortOrder]="'ascend'"
                >
                  STT
                </th>
                <th>Tên khách hàng</th>
                <th>Số điện thoại</th>
                <th>Tên thợ</th>
                <th>Trạng thái đơn</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let data of vm.bookingPaging.content; index as i">
                <td>{{ i + 1 }}</td>
                <td>{{ data.customerName }}</td>
                <td>{{ data.customerPhone }}</td>
                <td>
                  <span
                    class="{{
                      data.bookingServiceType === 'PICKUP_STYLIST'
                        ? 'tw-bg-yellow-400'
                        : ''
                    }}"
                    >{{
                      data.bookingServiceType === 'PICKUP_STYLIST'
                        ? 'Chọn hộ thợ'
                        : data.staffName
                    }}</span
                  >
                </td>
                <td>{{ data.bookingServiceStatus }}</td>
                <td class="tw-text-center">
                  <button
                    nz-button
                    nzType="primary"
                    nzSize="small"
                    (click)="chosenStylist(data)"
                    *ngIf="data.bookingServiceType === 'PICKUP_STYLIST'"
                  >
                    Chọn hộ
                  </button>
                  <button nz-button nzType="primary" nzSize="small">
                    Edit
                  </button>
                </td>
              </tr>
            </tbody>
          </nz-table>
        </ng-container>
      </div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class BookingListComponent {
  constructor(
    private _nzModalSvc: NzModalService,
    public bStore: BookingStore,
    private _fb: NonNullableFormBuilder
  ) {}
  vm$ = this.bStore.state$;

  onTableQueryParamsChange(params: NzTableQueryParams) {
    const { sort } = params;
    const currentSort = sort.find((item) => item.value !== null);
    this.bStore.pagingRequest.sorter = currentSort?.key ?? '';
    this.bStore.pagingRequest.orderDescending = currentSort?.value !== 'ascend';
    this.bStore.getBookingPaging();
  }

  onSearch() {
    this.bStore.pagingRequest.search = this.bStore.pagingRequest.search.replace(
      /[\t\n\r]/,
      ''
    );
    if (this.bStore.pagingRequest.current !== 1) {
      this.bStore.pagingRequest.current = 1;
    } else {
      this.bStore.getBookingPaging();
    }
  }

  chosenStylist(data: BookingPagingApi.Response) {
    const modalRef = this._nzModalSvc.create({
      nzTitle: 'Chọn hộ thợ cắt tóc',
      nzContent: BookingChosenStylistModalComponent,
    });

    const form = this._fb.group<BookingChosenStylistApi.RequestFormGroup>({
      bookingServiceId: this._fb.control(data.bookingServiceId),
      staffId: this._fb.control(''),
    });

    this.bStore.getstaffFree({
      model: {
        appointmentDate: data.appointmentDate,
        branchId: localStorage.getItem('branchId$')!,
        startAppointment: data.startAppointment,
        endAppointment: data.endAppointment,
      },
    });

    modalRef.componentInstance!.form = form;
    modalRef
      .componentInstance!.clickSubmit.pipe(
        tap(() => {
          this.bStore.chosenStylist({
            model: BookingChosenStylistApi.mapModel(form),
            modalRef: modalRef,
          });
        })
      )
      .subscribe();
  }
}
