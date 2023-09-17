import { CommonModule } from "@angular/common";
import { ChangeDetectionStrategy, Component } from "@angular/core";
import { NzLayoutModule } from 'ng-zorro-antd/layout';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { RouterOutlet } from "@angular/router";
import { NzImageModule } from "ng-zorro-antd/image";
import { NzMenuModule } from 'ng-zorro-antd/menu';
import { NzToolTipModule } from 'ng-zorro-antd/tooltip';

@Component({
  selector: 'app-homepage-layout',
  standalone: true,
  imports: [CommonModule, NzLayoutModule, NzIconModule, RouterOutlet, NzImageModule, NzMenuModule, NzToolTipModule],
  template: `
  <nz-layout class="tw-min-h-screen">
      <nz-sider nzCollapsible [(nzCollapsed)]="isCollapsed" [nzTrigger]="null" class="tw-bg-gray-300">
        <div class="logo">
          <img nz-image nzSrc="../assets/icon/icon.png" heigth="50px" width="114px" />
        </div>
        <ul nz-menu nzTheme="dark" nzMode="inline">
          <li nz-submenu nzTitle="User" nzIcon="user">
            <ul>
              <li nz-menu-item>Tom</li>
              <li nz-menu-item>Bill</li>
              <li nz-menu-item>Alex</li>
            </ul>
          </li>
          <li nz-submenu nzTitle="Team" nzIcon="team">
            <ul>
              <li nz-menu-item>Team 1</li>
              <li nz-menu-item>Team 2</li>
            </ul>
          </li>
          <li nz-menu-item>
            <span nz-icon nzType="file"></span>
            <span>File</span>
          </li>
        </ul>
      </nz-sider>
      <nz-layout>
        <nz-header>
          <span
            class="trigger"
            nz-icon
            [nzType]="isCollapsed ? 'menu-unfold' : 'menu-fold'"
            (click)="isCollapsed = !isCollapsed"
          ></span>
        </nz-header>
        <nz-content class="tw-mt-5 tw-m-2 tw-p-2 tw-bg-white" id="app-content">
          <router-outlet></router-outlet>
        </nz-content>
        <nz-footer>Ant Design ©2020 Implement By Angular</nz-footer>
      </nz-layout>
    </nz-layout>
  `,
  styles: [ `
  .trigger {
    font-size: 18px;
    line-height: 64px;
    padding: 0 24px;
    cursor: pointer;
    transition: color 0.3s;
  }

  .trigger:hover {
    color: #1890ff;
  }

  .logo {
    height: 55px;
    margin: 5px 16px;
  }

  nz-header {
    background: #fff;
    padding: 0;
  }

  nz-content {
    margin: 0 16px;
  }

  nz-breadcrumb {
    margin: 16px 0;
  }

  .inner-content {
    padding: 24px;
    background: #fff;
    min-height: 360px;
  }

  nz-footer {
    text-align: center;
  }
`],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class HomepageLayoutComponent {
  isCollapsed = false;
}
