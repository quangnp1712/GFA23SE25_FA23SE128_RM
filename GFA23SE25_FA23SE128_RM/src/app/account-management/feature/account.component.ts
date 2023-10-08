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
import { AccountApi } from '../data-access/model/account-api.model';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzDatePickerModule } from 'ng-zorro-antd/date-picker';
import { usernameRegex } from 'src/app/share/form-validator/username.const';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';

@Component({
  selector: 'app-account',
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
    NzDatePickerModule,
  ],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý tài khoản</nz-breadcrumb-item>
      <nz-breadcrumb-item>Tạo tài khoản</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div>
      <form nz-form [formGroup]="form">
        <div nz-row class="tw-ml-[12%]">
          <!-- username -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Tên tài khoản</nz-form-label
            >
            <nz-form-control [nzErrorTip]="usernameErrorTpl">
              <input
                class="tw-rounded-md tw-w-[70%]"
                [formControl]="form.controls.username"
                nz-input
                placeholder="Nhập tên tài khoản"
              />
            </nz-form-control>
            <ng-template #usernameErrorTpl let-control>
          <ng-container *ngIf="control.hasError('trimRequired')">
            Vui lòng nhập tên tài khoản
          </ng-container>
          <ng-container
            *ngIf="
              control.hasError('pattern') && !control.hasError('trimRequired')
            "
          >
            Tên tài khoản phải chứa ít nhất 6 kí tự, 1 chữ cái viết hoa và 1 số
          </ng-container>
        </ng-template>
          </nz-form-item>

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Địa chỉ</nz-form-label>
            <nz-form-control nzErrorTip="Vui lòng nhập địa chỉ">
              <input
                class="tw-rounded-md tw-w-[70%]"
                [formControl]="form.controls.address"
                nz-input
                placeholder="Nhập địa chỉ"
              />
            </nz-form-control>
          </nz-form-item>

          <!-- so dien thoai -->

          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Số điện thoại</nz-form-label
            >
            <nz-form-control [nzErrorTip]="phoneErrorTpl">
              <input
                class="tw-rounded-md tw-w-[70%]"
                [formControl]="form.controls.phone"
                nz-input
                placeholder="Nhập số điện thoại"
              />
            </nz-form-control>
            <ng-template #phoneErrorTpl let-control>
              <ng-container *ngIf="control.hasError('trimRequired')">
                Vui Lòng Nhập Sđt
              </ng-container>
              <ng-container
                *ngIf="
                  control.hasError('minlength') &&
                  !control.hasError('trimRequired')
                "
              >
                Sđt gồm 10 số
              </ng-container>
              <ng-container
                *ngIf="
                  control.hasError('maxlength') &&
                  !control.hasError('trimRequired')
                "
              >
                Sđt gồm 10 số
              </ng-container>
            </ng-template>
          </nz-form-item>
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Giới tính</nz-form-label>
            <nz-form-control nzErrorTip="Chọn giới tính">
              <nz-select
                class="tw-w-[70%]"
                nzPlaceHolder="Chọn giới tính"
                [formControl]="form.controls.gender"
              >
                <nz-option nzValue="Nam" nzLabel="Nam"></nz-option>
                <nz-option nzValue="Nữ" nzLabel="Nữ"></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Ngày sinh</nz-form-label>
            <nz-form-control nzErrorTip="Chọn ngày sinh">
              <nz-date-picker
                class="tw-w-[70%]"
                [formControl]="form.controls.dob"
              ></nz-date-picker>
            </nz-form-control>
          </nz-form-item>
        </div>
        <nz-divider></nz-divider>
        <div nz-row class="tw-ml-[12%]">
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Chi nhánh</nz-form-label>
            <nz-form-control>
              <nz-select class="tw-w-[70%]">
                <nz-option nzValue="Nam" nzLabel="1"></nz-option>
                <nz-option nzValue="Nữ" nzLabel="2"></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3">Địa chỉ chi nhánh</nz-form-label>
            <nz-form-control>
              <input class="tw-rounded-md tw-w-[70%]" nz-input placeholder="" />
            </nz-form-control>
          </nz-form-item>
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Chức vụ</nz-form-label>
            <nz-form-control>
              <nz-select class="tw-w-[70%]" [formControl]="form.controls.role">
                <nz-option nzValue="STAFF" nzLabel="Staff"></nz-option>
                <nz-option
                  nzValue="RECEPTIONIST"
                  nzLabel="Receptionist"
                ></nz-option>
                <nz-option
                  nzValue="BRANCH_MANAGER"
                  nzLabel="Branch manager"
                ></nz-option>
                <nz-option
                  nzValue="SHOP_OWNER"
                  nzLabel="Shop owner"
                ></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Ca làm việc</nz-form-label
            >
            <nz-form-control>
              <nz-select class="tw-w-[70%]">
                <nz-option nzValue="Nam" nzLabel="Sáng (7h - 15h)"></nz-option>
                <nz-option
                  nzValue="Nữ"
                  nzLabel="Chiều tối (15h - 23h)"
                ></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
        </div>
      </form>
      <div class="tw-text-center">
        <button nz-button nzDanger nzType="primary">Làm mới</button>
        <button nz-button nzType="primary" class="tw-ml-4">
          Tạo tài khoản
        </button>
      </div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AccountComponent implements OnInit {
  constructor(private _fb: NonNullableFormBuilder) {}

  form!: FormGroup<AccountApi.RequestFormGroup>;

  ngOnInit(): void {
    this.form = this._fb.group<AccountApi.RequestFormGroup>({
      username: this._fb.control('', [
        Validators.pattern(usernameRegex),
        trimRequired,
      ]),
      address: this._fb.control('', trimRequired),
      dob: this._fb.control('', Validators.required),
      gender: this._fb.control('', Validators.required),
      phone: this._fb.control('', [
        trimRequired,
        Validators.max(12),
        Validators.min(10),
      ]),
      professional: this._fb.control(''),
      role: this._fb.control(''),
    });
  }
}
