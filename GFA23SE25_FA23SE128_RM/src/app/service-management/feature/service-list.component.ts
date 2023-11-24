import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { FormControl, NonNullableFormBuilder } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzModalService } from 'ng-zorro-antd/modal';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzTableModule } from 'ng-zorro-antd/table';
import { CategoryAddComponent } from '../ui/category-add-modal.component';
import { CategoryAddApi } from '../data-access/model/service-api.model';
import { ServiceStore } from '../data-access/store/service.store';
import { tap } from 'rxjs';
import { provideComponentStore } from '@ngrx/component-store';
import { NzMessageService } from 'ng-zorro-antd/message';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';

@Component({
  selector: 'app-service-list',
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
  ],
  providers: [NzModalService, provideComponentStore(ServiceStore), NzMessageService],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý dịch vụ</nz-breadcrumb-item>
      <nz-breadcrumb-item>Danh sách dịch vụ</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div nz-row>
      <div nz-col nzSpan="17" class="">
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
        <button
          nz-button
          [routerLink]="['/service-management', 'create-service']"
          nzType="primary"
        >
          Tạo dịch vụ
        </button>
      </div>
      <div nz-col nzSpan="2" class="">
        <button
          nz-button
          nzType="primary"
          (click)="onAddCategory()"
        >
          Tạo loại dịch vụ
        </button>
      </div>
      <div nz-col nzSpan="2" class="tw-ml-2">
        <button
          nz-button
          nzType="primary"
        >
          Xem loại dịch vụ
        </button>
      </div>
    </div>
    <div nz-row>
      <div nz-col nzSpan="24" class="tw-mt-5">
        <nz-table #basicTable class="tw-mr-4">
          <thead>
            <tr>
              <th>STT</th>
              <th>Ảnh</th>
              <th>Tên dịch vụ</th>
              <th>Mô tả</th>
              <th>giá</th>
              <th>Trạng thái</th>
              <th>Ngày tạo</th>
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
export class ServiceListComponent {
  constructor(private _nzModalSvc: NzModalService, private _fb: NonNullableFormBuilder, public sStrore: ServiceStore){}

  onAddCategory() {
    const modalRef = this._nzModalSvc.create({
      nzTitle: 'Tạo loại dịch vụ',
      nzContent: CategoryAddComponent,
    });
    const form = this._fb.group<CategoryAddApi.RequestFormGroup>({
      description: this._fb.control('', trimRequired),
      title: this._fb.control('', trimRequired),
    });
    modalRef.componentInstance!.form = form;
    modalRef
      .componentInstance!.clickSubmit.pipe(
        tap(() => {
          this.sStrore.addCategory({
            model: CategoryAddApi.mapModel(form),
            modalRef: modalRef,
          });
        })
      )
      .subscribe();
  }
}
