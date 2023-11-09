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
import { NzMessageService } from 'ng-zorro-antd/message';
import { NzUploadChangeParam, NzUploadModule } from 'ng-zorro-antd/upload';
import { BranchApi } from '../data-access/model/branch-api.model';
import { debounceTime, distinctUntilChanged, pipe } from 'rxjs';
import { CommonApiService } from 'src/app/share/data-access/api/common.service';
import { NzTimePickerModule } from 'ng-zorro-antd/time-picker';
import { NzInputNumberModule } from 'ng-zorro-antd/input-number';
import { BranchApiService } from '../data-access/api/branch.service';
import { NzAutocompleteModule } from 'ng-zorro-antd/auto-complete';
import { BranchStore } from '../data-access/store/branch.store';
import { provideComponentStore } from '@ngrx/component-store';
import { RxLet } from '@rx-angular/template/let';
import { OnlyNumberInputDirective } from 'src/app/share/ui/directive/only-number-input.directive';

@Component({
  selector: 'app-branch',
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
    NzFormModule,
    FormsModule,
    ReactiveFormsModule,
    NzSelectModule,
    NzUploadModule,
    NzTimePickerModule,
    NzInputNumberModule,
    NzAutocompleteModule,
    RxLet,
    OnlyNumberInputDirective,
  ],
  providers: [provideComponentStore(BranchStore), NzMessageService],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý chi nhánh</nz-breadcrumb-item>
      <nz-breadcrumb-item>Tạo chi nhánh</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div *rxLet="vm$ as vm">
      <form nz-form [formGroup]="bStore.form">
        <div nz-row class="tw-ml-[12%]">
          <!-- Tên chi nhánh -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Tên chi nhánh</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập họ và tên đệm">
              <input
                class="tw-rounded-md tw-w-[70%]"
                nz-input
                placeholder="Nhập tên tài khoản"
                [formControl]="bStore.form.controls.branchName"
              />
            </nz-form-control>
          </nz-form-item>

          <!-- địa chỉ -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Địa chỉ</nz-form-label>
            <nz-form-control nzErrorTip="Vui lòng nhập địa chỉ">
              <input
                class="tw-rounded-md tw-w-[70%]"
                placeholder="Nhập địa chỉ"
                [formControl]="bStore.form.controls.address"
                nz-input
                (input)="getAddress($event)"
                [nzAutocomplete]="auto"
              />
              <nz-autocomplete
                [nzDataSource]="vm.addressData"
                nzBackfill
                #auto
              ></nz-autocomplete>
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Thời gian mở cửa</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập tên" class="tw-w-[70%]">
              <nz-time-picker
                nzFormat="HH:mm"
                class="tw-rounded-md tw-w-[100%]"
                [formControl]="bStore.form.controls.open"
              ></nz-time-picker>
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Thời gian đóng cửa</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập tên" class="tw-w-[70%]">
              <nz-time-picker
                nzFormat="HH:mm"
                class="tw-rounded-md tw-w-[100%]"
                [formControl]="bStore.form.controls.close"
              ></nz-time-picker>
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Hotline</nz-form-label>
            <nz-form-control nzErrorTip="Vui lòng nhập số điện thoại">
              <input
                class="tw-rounded-md tw-w-[70%]"
                nz-input
                appOnlyNumber
                placeholder="Nhập số điện thoại"
                [formControl]="bStore.form.controls.phone"
              />
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Số lượng nhân viên</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập họ và tên đệm">
              <input
                nz-input
                appOnlyNumber
                class="tw-rounded-md tw-w-[70%]"
                [formControl]="bStore.form.controls.numberStaffs"
              />
            </nz-form-control>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="24" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Ảnh chi nhánh</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập tên" class="tw-w-[85%]">
              <nz-upload nzType="drag" [nzMultiple]="true">
                <p class="ant-upload-drag-icon">
                  <span nz-icon nzType="inbox"></span>
                </p>
                <p class="ant-upload-text">
                  Click or drag file to this area to upload
                </p>
                <p class="ant-upload-hint">
                  Support for a single or bulk upload. Strictly prohibit from
                  uploading company data or other band files
                </p>
              </nz-upload>
            </nz-form-control>
          </nz-form-item>

          <!-- dia chi -->
        </div>
        <nz-divider></nz-divider>
      </form>
      <div class="tw-text-center">
        <button nz-button nzDanger nzType="primary">Làm mới</button>
        <button
          nz-button
          nzType="primary"
          class="tw-ml-4"
          (click)="addBranch()"
        >
          Tạo Chi nhánh
        </button>
      </div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class BranchComponent {
  constructor(public bStore: BranchStore) {}

  vm$ = this.bStore.state$;
  addModel!: BranchApi.Request;

  addBranch() {
    this.addModel = this.bStore.form.getRawValue();
    this.bStore.addBranch({ model: this.addModel });
  }

  getAddress(event: Event) {
    const value = (event.target as HTMLInputElement).value;
    this.bStore.getAddress(value);
  }
}
