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
import { SignInApi } from '../../data-access/model/sign-in-api.model';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { trimRequired } from 'src/app/share/form-validator/trim-required.validator';

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
    NzButtonModule
  ],
  template: `
    <div class="background">
      <div>
      <div class="tw-pl-[36%] tw-pt-[10%]">
        <div
          class="tw-bg-gray-200 tw-w-[30%] tw-h-[400px] tw-absolute tw-rounded-lg tw-opacity-90"
        >
          <div class="tw-text-center tw-mt-7">
            <img
              nz-image
              width="100px"
              height="100px"
              nzSrc="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0-KahDh8XGzH-AoNcXIQao0qwCsXoxbIswA&usqp=CAU"
              alt=""
            />
            <h1>ĐĂNG NHẬP</h1>
            <span class="tw-text-2xl">Nhập số điện thoại</span>
          </div>
          <form nz-form [formGroup]="validateForm" (ngSubmit)="submitForm()">
            <nz-form-item>
              <nz-form-control [nzErrorTip]="phoneErrorTpl"  class="tw-text-center">
                <input class="tw-w-[85%] tw-mt-7 tw-rounded-full" [formControl]="validateForm.controls.phone" nz-input placeholder="Nhấp Số điện thoại của bạn"/>
              </nz-form-control>
              <ng-template #phoneErrorTpl let-control>
              <ng-container *ngIf="control.hasError('trimRequired')">
                Vui Lòng Nhập Sđt
              </ng-container>
              <ng-container *ngIf="control.hasError('minlength') && !control.hasError('trimRequired')">
                Sđt gồm 10 số
              </ng-container>
              <ng-container *ngIf="control.hasError('maxlength') && !control.hasError('trimRequired')">
                Sđt gồm 10 số
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
                  Tiếp Tục
                </button>
              </nz-form-control>
            </nz-form-item>
          </form>
        </div>
      </div>
    </div>
  `,
  styles: [
    `
      .background {
        height: 100%;
        width: 100%;
        background-image: url(https://img.freepik.com/premium-photo/stylish-professional-barber-scissors-hair-cutting-shears-black-background-hairdresser-salon_609048-2672.jpg?w=2000);
        background-size: cover;
      }
    `,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class SignInComponent implements OnInit {
  constructor(private _fb: NonNullableFormBuilder) {}
  validateForm!: FormGroup<SignInApi.RequestFormGroup>;

  submitForm(): void {
    console.log('submit', this.validateForm.value);
  }

  ngOnInit(): void {
    this.validateForm = this._fb.group<SignInApi.RequestFormGroup>({
      phone: this._fb.control('', [
        trimRequired,
        Validators.maxLength(10),
        Validators.minLength(10),
      ]),
    });
  }
}
