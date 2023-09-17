import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzImageModule } from 'ng-zorro-antd/image';
import { NzMenuModule } from 'ng-zorro-antd/menu';
import { NzUploadModule } from 'ng-zorro-antd/upload';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, NzGridModule, NzUploadModule, NzImageModule, NzMenuModule],
  template: `
    <div nz-row nzJustify="start">
      <div nz-col nzSpan="6">
        <div class=" tw-text-center">
          <img
            class="tw-rounded-full"
            nz-image
            width="200px"
            height="200px"
            nzSrc="https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png"
            alt=""
          />
          <h1>Yasuo</h1>
          <h5>Shop owner</h5>
        </div>
        <ul nz-menu nzTheme="light" nzMode="inline">
          <li nz-menu-item>
            <span>Thông tin tài khoản</span>
          </li>
          <li nz-menu-item>
            <span>123</span>
          </li>
          <li nz-menu-item>
            <span class="tw-text-red-500">Đăng xuất</span>
          </li>
        </ul>
      </div>
      <div nz-col nzSpan="18">col-4</div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProfileComponent {}
