import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzTableModule, NzTableQueryParams } from 'ng-zorro-antd/table';
import { AccountStore } from '../data-access/store/account.store';
import { provideComponentStore } from '@ngrx/component-store';
import { NzMessageService } from 'ng-zorro-antd/message';
import { NzTableDefaultSettingDirective } from 'src/app/share/ui/directive/nz-table-default-setting.directive';
import { RxLet } from '@rx-angular/template/let';
import { MapRoleTypeNamePipe } from '../until/role.pipe';
import { FormsModule } from '@angular/forms';

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
    RouterLink,
    NzTableDefaultSettingDirective,
    RxLet,
    MapRoleTypeNamePipe,
    FormsModule
  ],
  providers: [provideComponentStore(AccountStore), NzMessageService],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý tài khoản</nz-breadcrumb-item>
      <nz-breadcrumb-item>Danh sách tài khoản</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div nz-row>
      <div nz-col nzSpan="22" class="">
        <nz-input-group nzSearch [nzAddOnAfter]="suffixIconButton">
          <input type="text" nz-input placeholder="Tìm theo tên" [(ngModel)]="aStore.pagingRequest.searches" (keyup.enter)="onSearch()"/>
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
          [routerLink]="['/account-management', 'create-account']"
        >
          Tạo tài khoản
        </button>
      </div>
      <div nz-col nzSpan="24" class="tw-mt-5">
        <ng-container *rxLet="vm$ as vm">
          <nz-table
            appNzTableDefaultSetting
            class="tw-mr-4"
            [nzData]="vm.acountPaging.content"
            [nzTotal]="vm.acountPaging.totalElements"
            [(nzPageIndex)]="aStore.pagingRequest.current"
            [(nzPageSize)]="aStore.pagingRequest.pageSize"
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
                <th>STT</th>
                <th>Họ và tên</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Giới tính</th>
                <th>Trạng thái</th>
                <th>Chức vụ</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let data of vm.acountPaging.content; index as i">
                <td>{{ i + 1 }}</td>
                <td>{{ data.firstName + ' ' + data.lastName }}</td>
                <td>{{ data.address }}</td>
                <td>{{ data.phone }}</td>
                <td>{{ data.gender }}</td>
                <td>{{ data.status }}</td>
                <td>{{ data.role | mapRoleTypeName }}</td>
                <td class="tw-text-center">
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
export class AccountListComponent {
  constructor(public aStore: AccountStore) {}

  vm$ = this.aStore.state$;
  onTableQueryParamsChange(params: NzTableQueryParams) {
    const { sort } = params;
    const currentSort = sort.find((item) => item.value !== null);
    this.aStore.pagingRequest.sorter = currentSort?.key ?? '';
    this.aStore.pagingRequest.orderDescending = currentSort?.value !== 'ascend';
    this.aStore.getAccountPaging();
  }

  onSearch() {
    this.aStore.pagingRequest.searches =
      this.aStore.pagingRequest.searches.replace(/[\t\n\r]/, '');
    if (this.aStore.pagingRequest.current !== 1) {
      this.aStore.pagingRequest.current = 1;
    } else {
      this.aStore.getAccountPaging();
    }
  }
}
