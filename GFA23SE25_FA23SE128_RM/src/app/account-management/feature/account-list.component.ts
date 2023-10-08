import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzTableModule } from 'ng-zorro-antd/table';

@Component({
  selector: 'app-account-list',
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
    RouterLink
  ],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý tài khoản</nz-breadcrumb-item>
      <nz-breadcrumb-item>Danh sách tài khoản</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div nz-row>
      <div nz-col nzSpan="22" class="">
        <nz-input-group nzSearch [nzAddOnAfter]="suffixIconButton">
          <input type="text" nz-input placeholder="Tìm theo tên" />
        </nz-input-group>
        <ng-template #suffixIconButton>
          <button nz-button nzType="primary" nzSearch>
            <span nz-icon nzType="search"></span>
          </button>
        </ng-template>
      </div>
      <div nz-col nzSpan="2" class="tw-text-center">
        <button nz-button [routerLink]="['/account-management', 'create-account']">Tạo tài khoản</button>
      </div>
      <div nz-col nzSpan="24" class="tw-mt-5">
        <nz-table #basicTable class="tw-mr-4">
          <thead>
            <tr>
              <th>Ảnh</th>
              <th>Họ và tên</th>
              <th>Số điện thoại</th>
              <th>Chức vụ</th>
              <th>Chi nhánh</th>
              <th>Địa Chỉ</th>
              <th>Trạng thái</th>
              <th>Giới tính</th>
              <th>Ngày sinh</th>
            </tr>
          </thead>
          <tbody></tbody>
        </nz-table>
      </div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AccountListComponent {}
