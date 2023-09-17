import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzUploadModule } from 'ng-zorro-antd/upload';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, NzGridModule, NzUploadModule],
  template: `
    <div nz-row nzJustify="start">
      <div nz-col nzSpan="6">col-4</div>
      <div nz-col nzSpan="18">col-4</div>
    </div>
  `,
  styles: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProfileComponent {}
