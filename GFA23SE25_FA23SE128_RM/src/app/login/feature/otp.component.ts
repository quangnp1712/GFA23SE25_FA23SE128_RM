import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { NzImageModule } from 'ng-zorro-antd/image';
import { NzFormModule } from 'ng-zorro-antd/form';
import {
  FormGroup,
  FormsModule,
  NonNullableFormBuilder,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';
import { OtpApi } from '../data-access/model/otp-api.model';
import { Router, RouterLink, RouterModule } from '@angular/router';
import { OtpApiService } from '../data-access/api/otp.service';
import { NzMessageService } from 'ng-zorro-antd/message';

@Component({
  selector: 'app-sign-in',
  standalone: true,
  imports: [
    CommonModule,
    NzImageModule,
    NzFormModule,
    FormsModule,
    ReactiveFormsModule,
    NzInputModule,
    NzButtonModule,
    RouterLink,
    RouterModule,
  ],
  providers: [NzMessageService],
  template: `
    <div class="tw-text-center tw-mt-3">
      <span class="tw-text-2xl">Nhập OTP</span>
    </div>
    <form nz-form [formGroup]="validateForm" (ngSubmit)="submitForm()">
      <nz-form-item>
        <nz-form-control [nzErrorTip]="phoneErrorTpl" class="tw-text-center">
          <input
            class="tw-w-[85%] tw-mt-7 tw-rounded-full"
            [formControl]="validateForm.controls.passCode"
            nz-input
            placeholder="Nhập OTP"
          />
        </nz-form-control>
        <ng-template #phoneErrorTpl let-control>
          <ng-container *ngIf="control.hasError('trimRequired')">
            Vui Lòng Nhập OTP
          </ng-container>
          <ng-container
            *ngIf="
              control.hasError('minlength') && !control.hasError('trimRequired')
            "
          >
            OTP gồm 5 số
          </ng-container>
          <ng-container
            *ngIf="
              control.hasError('maxlength') && !control.hasError('trimRequired')
            "
          >
            OTP gồm 5 số
          </ng-container>
        </ng-template>
      </nz-form-item>
      <nz-form-item>
        <nz-form-control class="tw-text-center">
          <button
            class="tw-w-[85%] tw-rounded-full tw-bg-gradient-to-r tw-from-gray-600 tw-to-gray-300"
            nz-button
            nzType="primary"
            [disabled]="!validateForm.valid"
          >
            Đăng Nhập
          </button>
        </nz-form-control>
      </nz-form-item>
    </form>
    <div class="tw-ml-5 tw--10">
      <a [routerLink]="['/login']"> Nhập lại SĐT? </a>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class OtpComponent implements OnInit {
  constructor(
    private _fb: NonNullableFormBuilder,
    private _otpSvc: OtpApiService,
    private _router: Router,
    private _nzMessageService: NzMessageService
  ) {}
  validateForm!: FormGroup<OtpApi.RequestFormGroup>;
  model!: OtpApi.Request;

  submitForm(): void {
    this.validateForm.controls.phone.setValue(localStorage.getItem('phone')!);
    this.model = this.validateForm.getRawValue();
    this._otpSvc.getOtp(this.model).subscribe(
      (data) => {
        this._nzMessageService.success('Đăng nhập thành công.');
        this._router.navigate(['/homepage'])
      },
      (error) => {
        this._nzMessageService.error('Otp không đúng.');
      }
    );
  }

  ngOnInit(): void {
    this.validateForm = this._fb.group<OtpApi.RequestFormGroup>({
      passCode: this._fb.control('', [
        trimRequired,
        Validators.maxLength(5),
        Validators.minLength(5),
      ]),
      phone: this._fb.control(''),
    });
  }
}
