import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import {
  FormGroup,
  FormsModule,
  NonNullableFormBuilder,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzTableModule } from 'ng-zorro-antd/table';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzDatePickerModule } from 'ng-zorro-antd/date-picker';
import { NzMessageService } from 'ng-zorro-antd/message';
import { NzUploadModule } from 'ng-zorro-antd/upload';
import { ServiceStore } from '../data-access/store/service.store';
import { provideComponentStore } from '@ngrx/component-store';
import { RxLet } from '@rx-angular/template/let';
import { ServiceAddApi } from '../data-access/model/service-api.model';

@Component({
  selector: 'app-service',
  standalone: true,
  imports: [
    CommonModule,
    NzBreadCrumbModule,
    NzDividerModule,
    NzGridModule,
    NzInputModule,
    NzIconModule,
    NzButtonModule,
    NzFormModule,
    FormsModule,
    ReactiveFormsModule,
    NzSelectModule,
    NzUploadModule,
    RxLet
  ],
  providers: [NzMessageService, provideComponentStore(ServiceStore)],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý dịch vụ</nz-breadcrumb-item>
      <nz-breadcrumb-item>Tạo dịch vụ</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div *rxLet="vm$ as vm">
      <form nz-form [formGroup]="form">
        <div nz-row class="tw-ml-[12%]">
          <!-- Tên chi nhánh -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Tên dịch vụ</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập tên dịch vụ">
              <input
                class="tw-rounded-md tw-w-[70%]"
                nz-input
                [formControl]="form.controls.name"
                placeholder="Nhập tên dịch vụ"
              />
            </nz-form-control>
          </nz-form-item>

          <!-- loaij dichj vuj -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Loại dịch vụ</nz-form-label>
            <nz-form-control nzErrorTip="Vui lòng chọn loại dịch vụ">
              <nz-select class="tw-rounded-md tw-w-[70%]" [formControl]="form.controls.categoryId">
            <nz-option *ngFor="let option of vm.categoryData.values" [nzLabel]="option.title" [nzValue]="option.categoryId"></nz-option>
            </nz-select>
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12">
            <nz-form-label class="tw-ml-3">Mô tả dịch vụ</nz-form-label>
            <nz-form-control>
            <textarea  class="tw-w-[70%]" rows="5" nz-input [formControl]="form.controls.description"></textarea>
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Ảnh dịch vụ</nz-form-label>
            <nz-form-control nzErrorTip="Vui lòng nhập tên" class="tw-w-[70%]">
              <nz-upload
                nzType="drag"
                [nzMultiple]="true"
                nzAction="https://www.mocky.io/v2/5cc8019d300000980a055e76"

              >
                <p class="ant-upload-drag-icon">
                  <span nz-icon nzType="inbox"></span>
                </p>
                <p class="ant-upload-text">
                  Click or drag file to this area to upload
                </p>
              </nz-upload>
            </nz-form-control>
          </nz-form-item>

          <!-- dia chi -->
        </div>
        <nz-divider></nz-divider>
      </form>
      <div class="tw-text-center">
        <button nz-button nzDanger nzType="primary" (click)="form.reset()">Làm mới</button>
        <button nz-button nzType="primary" class="tw-ml-4" (click)="addService()" [disabled]="form.invalid">
          Tạo dịch vụ
        </button>
      </div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ServiceComponent {
  constructor(public sStore: ServiceStore){}

  vm$ = this.sStore.state$
  form = this.sStore.form

  addService(){
    this.sStore.addService({model: ServiceAddApi.mapModel(this.form)})
  }
}
