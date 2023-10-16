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
import { AccountApiService } from '../data-access/api/account.service';
import { NzMessageService } from 'ng-zorro-antd/message';

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
  providers: [NzMessageService],
  template: `
    <nz-breadcrumb>
      <nz-breadcrumb-item>Quản lý tài khoản</nz-breadcrumb-item>
      <nz-breadcrumb-item>Tạo tài khoản</nz-breadcrumb-item>
    </nz-breadcrumb>
    <nz-divider></nz-divider>
    <div>
      <form nz-form [formGroup]="form">
        <div nz-row class="tw-ml-[12%]">
          <!-- first name -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Họ và tên đệm</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập họ và tên đệm">
              <input
                class="tw-rounded-md tw-w-[70%]"
                [formControl]="form.controls.firstName"
                nz-input
                placeholder="Nhập tên tài khoản"
              />
            </nz-form-control>
          </nz-form-item>

          <!-- last name -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired
              >Tên</nz-form-label
            >
            <nz-form-control nzErrorTip="Vui lòng nhập tên">
              <input
                class="tw-rounded-md tw-w-[70%]"
                [formControl]="form.controls.lastName"
                nz-input
                placeholder="Nhập tên tài khoản"
              />
            </nz-form-control>
          </nz-form-item>

          <!-- dia chi -->

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
                Vui lòng nhập sđt
              </ng-container>
              <ng-container
                *ngIf="
                  control.hasError('minlength') &&
                  !control.hasError('trimRequired')
                "
              >
                Sđt gồm 10 số hoặc hơn
              </ng-container>
              <ng-container
                *ngIf="
                  control.hasError('maxlength') &&
                  !control.hasError('minlength')
                "
              >
                Sđt ít hơn 12 số
              </ng-container>
            </ng-template>
          </nz-form-item>
          <!-- gioi tinh -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Giới tính</nz-form-label>
            <nz-form-control nzErrorTip="Chọn giới tính">
              <nz-select
                class="tw-w-[70%]"
                nzPlaceHolder="Chọn giới tính"
                [formControl]="form.controls.gender"
              >
                <nz-option nzValue="NAM" nzLabel="Nam"></nz-option>
                <nz-option nzValue="NU" nzLabel="Nữ"></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
          <!-- ngay sinh -->
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
              <nz-select class="tw-w-[70%]" [formControl]='form.controls.branch'>
                <nz-option nzValue="1" nzLabel="1"></nz-option>
                <nz-option nzValue="2" nzLabel="2"></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3">Địa chỉ chi nhánh</nz-form-label>
            <nz-form-control>
              <input class="tw-rounded-md tw-w-[70%]" nz-input placeholder="" />
            </nz-form-control>
          </nz-form-item>
          <!-- ca -->
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
          <!-- chuc vu -->
          <nz-form-item nz-col nzSpan="12" class="">
            <nz-form-label class="tw-ml-3" nzRequired>Chức vụ</nz-form-label>
            <nz-form-control>
              <nz-select class="tw-w-[70%]" [formControl]="form.controls.professional">
                <nz-option nzValue="STYLIST" nzLabel="Stylist"></nz-option>
                <nz-option
                  nzValue="MASSEUR"
                  nzLabel="Masseur"
                ></nz-option>
                <nz-option
                  nzValue="RECEPTIONIST"
                  nzLabel="Receptionist"
                ></nz-option>
              </nz-select>
            </nz-form-control>
          </nz-form-item>
        </div>
      </form>
      <div class="tw-text-center">
        <button nz-button nzDanger nzType="primary" (click)="form.reset()">Làm mới</button>
        <button nz-button nzType="primary" class="tw-ml-4" (click)="createAccount()" [disabled]="form.invalid">
          Tạo tài khoản
        </button>
      </div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AccountComponent implements OnInit {
  constructor(private _fb: NonNullableFormBuilder, private _accountSvc: AccountApiService,
    private _nzMessageService: NzMessageService,) {}

  form!: FormGroup<AccountApi.RequestFormGroup>;
  model!: AccountApi.Request;

  ngOnInit(): void {
    this.form = this._fb.group<AccountApi.RequestFormGroup>({
      firstName: this._fb.control('', trimRequired),
      lastName: this._fb.control('', [trimRequired]),
      address: this._fb.control('', trimRequired),
      dob: this._fb.control('', Validators.required),
      gender: this._fb.control('', Validators.required),
      phone: this._fb.control('', [
        trimRequired,
        Validators.minLength(10),
        Validators.maxLength(12),
      ]),
      professional: this._fb.control(''),
      branch: this._fb.control(''),
      thumbnailUrl: this._fb.control('123')
    });
  }

  createAccount() {
    console.log(this.form.getRawValue());
    this.model = this.form.getRawValue();
    this._accountSvc.createAccount(this.model).subscribe(
      (data) => {
        this._nzMessageService.success('Đăng kí thành công.');
      },
      (error) => {
        this._nzMessageService.error('Đăng kí thất bại.');
      }
    );
  }

}
