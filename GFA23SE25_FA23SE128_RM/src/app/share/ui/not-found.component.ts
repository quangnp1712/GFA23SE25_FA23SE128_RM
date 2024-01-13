import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzResultModule } from 'ng-zorro-antd/result';

@Component({
  selector: 'nz-demo-result-fot',
  imports: [NzResultModule, NzButtonModule],
  standalone: true,
  template: `
    <nz-result nzStatus="403" nzTitle="403" nzSubTitle="Sorry, you are not authorized to access this page.">
      <div nz-result-extra>
        <button nz-button nzType="primary" (click)="back()">Back Home</button>
      </div>
    </nz-result>
  `
})
export class NotFoundComponent {
  constructor(private _router: Router){}

  back(): void {
    this._router.navigate(["/homepage/profile"])
  }
}
