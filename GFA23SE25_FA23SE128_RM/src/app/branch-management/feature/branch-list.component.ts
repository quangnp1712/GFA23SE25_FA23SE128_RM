import { CommonModule } from '@angular/common';
import {
  AfterViewInit,
  ChangeDetectionStrategy,
  Component,
  OnInit,
} from '@angular/core';
import { RouterLink } from '@angular/router';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzTableModule, NzTableQueryParams } from 'ng-zorro-antd/table';
import { BranchPagingApi } from '../data-access/model/branch-api.model';
import { pagingSizeOptionsDefault } from 'src/app/share/data-access/const/paging-size-options-default.const';
import { BranchApiService } from '../data-access/api/branch.service';
import { NzMessageService } from 'ng-zorro-antd/message';
import { NzTableDefaultSettingDirective } from 'src/app/share/ui/directive/nz-table-default-setting.directive';
import { Paging } from 'src/app/share/data-access/model/paging.type';
import { FormsModule } from '@angular/forms';
import { NzSpinModule } from 'ng-zorro-antd/spin';
import { tap } from 'rxjs';

@Component({
  selector: 'app-branch-list',
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
    NzSpinModule,
  ],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý chi nhánh</nz-breadcrumb-item>
      <nz-breadcrumb-item>Danh sách chi nhánh</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
      <div nz-row>
        <div nz-col nzSpan="22" class="">
          <nz-input-group nzSearch [nzAddOnAfter]="suffixIconButton">
            <input
              type="text"
              nz-input
              placeholder="Tìm theo tên"
              [(ngModel)]="pagingRequest.searches"
              (keyup.enter)="[getBranchPaging(), flag=false]"
            />
          </nz-input-group>
          <ng-template #suffixIconButton>
            <button
              nz-button
              nzType="primary"
              nzSearch
              (click)="[getBranchPaging(), flag=false]"
            >
              <span nz-icon nzType="search"></span>
            </button>
          </ng-template>
        </div>
        <div nz-col nzSpan="2" class="tw-text-center">
          <button
            nz-button
            [routerLink]="['/branch-management', 'create-branch']"
          >
            Tạo chi nhánh
          </button>
        </div>
        <nz-select class="tw-w-[150px] tw-mt-5" nzPlaceHolder="Chọn Chi Nhánh">
          <nz-option nzValue="TONG" nzLabel="Tổng"> </nz-option>
          <nz-option nzValue="HCM" nzLabel="Hồ Chí Minh"> </nz-option>
          <nz-option nzValue="HN" nzLabel="Hà Nội"> </nz-option>
        </nz-select>
        <div nz-col nzSpan="24" class="tw-mt-5">
          <ng-container *ngFor="let f of [true, false]">
            <nz-table
              class="tw-mr-4"
              *ngIf="f === flag"
              [nzData]="pagingData.content"
              [nzFrontPagination]="false"
              [nzTotal]="pagingData.total"
              [(nzPageIndex)]="pagingRequest.current"
              [(nzPageSize)]="pagingRequest.pageSize"
              [nzPageSizeOptions]="[10, 25, 50, 100]"
              (nzQueryParams)="onTableQueryParamsChange($event)"
              [nzShowTotal]="totalText"
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
                  <th>Tên chi nhánh</th>
                  <th>Địa chỉ</th>
                  <th>Hotline</th>
                  <th>Trạng thái</th>
                  <th>Số lượng nhân viên</th>
                </tr>
              </thead>
              <tbody>
                <tr *ngFor="let data of pagingData.content; index as i">
                  <td>{{ i + 1 }}</td>
                  <td>{{ data.branchName }}</td>
                  <td>{{ data.address }}</td>
                  <td>{{ data.phone }}</td>
                  <td>{{ data.status }}</td>
                  <td>{{ data.numberStaffs }}</td>
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
export class BranchListComponent implements AfterViewInit {
  constructor(private _bApiSvc: BranchApiService) {}

  isSpin = true;
  flag = false;
  pagingData: Paging<BranchPagingApi.Response> = {
    content: [],
    current: 1,
    pageSize: 10,
    total: 0,
  };
  pagingRequest: BranchPagingApi.Request = {
    current: 1,
    pageSize: pagingSizeOptionsDefault[0],
    searches: '',
    sorter: '',
    orderDescending: false,
  };

  ngAfterViewInit(): void {
    this.getBranchPaging();
  }

  onTableQueryParamsChange(params: NzTableQueryParams) {
    this.flag= true
    const { sort } = params;
    const currentSort = sort.find((item) => item.value !== null);
    this.pagingRequest.sorter = currentSort?.key ?? '';
    this.pagingRequest.orderDescending = currentSort?.value !== 'ascend';
    this.getBranchPaging();
  }

  getBranchPaging() {
    this._bApiSvc.paging(this.pagingRequest).pipe(
      tap(() => {this.flag = false})
    ).subscribe((data) => {
      this.pagingData = data;
      this.flag = true;
    });
  }
}
