import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzImageModule } from 'ng-zorro-antd/image';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzMenuModule } from 'ng-zorro-antd/menu';
import { NzUploadModule } from 'ng-zorro-antd/upload';
import { NzCalendarModule } from 'ng-zorro-antd/calendar';
import { NzAlertModule } from 'ng-zorro-antd/alert';
import { NzBadgeModule } from 'ng-zorro-antd/badge';

@Component({
  selector: 'app-account-update',
  standalone: true,
  imports: [
    CommonModule,
    NzGridModule,
    NzUploadModule,
    NzImageModule,
    NzMenuModule,
    NzInputModule,
    NzButtonModule,
    NzCalendarModule,
    NzAlertModule,
    NzBadgeModule,
  ],
  template: `
    <div nz-row nzJustify="start">
      <div nz-col nzSpan="6">
        <div class=" tw-text-center">
          <img
            class="tw-rounded-full"
            nz-image
            width="50%"
            height="50%"
            nzSrc="https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png"
            alt=""
          />
          <h1>Yasuo</h1>
          <h5>Staff</h5>
        </div>
      </div>
      <div nz-col nzSpan="18">
        <div nz-row>
          <div nz-col nzSpan="12">
            <h3 class="tw-ml-5">Họ</h3>
            <input nz-input disabled class="tw-w-[80%] tw-ml-5" />
            <h3 class="tw-ml-5">Email</h3>
            <input nz-input disabled class="tw-w-[80%] tw-ml-5" />
            <h3 class="tw-ml-5">Giới tính</h3>
            <input nz-input disabled class="tw-w-[80%] tw-ml-5" />
          </div>
          <div nz-col nzSpan="12">
            <h3 class="tw-ml-5">Tên</h3>
            <input nz-input disabled class="tw-w-[80%] tw-ml-5" />
            <h3 class="tw-ml-5">Số điện thoại</h3>
            <input nz-input disabled class="tw-w-[80%] tw-ml-5" />
            <h3 class="tw-ml-5">Ngày sinh</h3>
            <input nz-input disabled class="tw-w-[80%] tw-ml-5" />
          </div>
        </div>
        <h3 class="tw-ml-5">Địa Chỉ</h3>
        <input nz-input disabled class="tw-w-[90%] tw-ml-5" /> <br />

        <!-- calendar -->
        <h3 class="tw-ml-5">Lịch làm</h3>
        <nz-calendar nz-col nzSpan="22">
          <ul *nzDateCell="let date" class="events">
            <ng-container *ngFor="let event of objects">
              <li *ngIf="event.date.getTime() === date.getTime()">
                <nz-badge
                  [nzStatus]="event.type"
                  [nzText]="event.title"
                ></nz-badge>
              </li>
            </ng-container>
          </ul>
        </nz-calendar>

        <!-- end -->

        <div class="tw-mt-7 tw-text-center">
          <button nz-button nzType="primary" nzDanger>Hủy</button>
          <button nz-button class="tw-ml-3" nzType="primary">Cập Nhật</button>
        </div>
      </div>
    </div>
  `,
  styles: [
    `
      .events {
        list-style: none;
        margin: 0;
        padding: 0;
      }

      .events .ant-badge-status {
        overflow: hidden;
        white-space: nowrap;
        width: 100%;
        text-overflow: ellipsis;
        font-size: 12px;
      }

      .notes-month {
        text-align: center;
        font-size: 28px;
      }

      .notes-month section {
        font-size: 28px;
      }
    `,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AccountUpdateComponent implements OnInit {
  constructor() {
  }
  ngOnInit(): void {
    console.log(this.mai);
  }
  current = new Date();
  mai = new Date('12/22/2023');

  objects = [
    {
      type: 'success',
      content:
        'This is very long usual event with very very long decription...',
      title: 'This is title to event with long description',
      date: this.mai,
    },
  ];
}
