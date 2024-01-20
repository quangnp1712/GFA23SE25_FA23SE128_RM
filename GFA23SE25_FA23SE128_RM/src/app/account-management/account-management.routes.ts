import { Route } from '@angular/router';
import { AccountListComponent } from './feature/account-list.component';
import { HomepageLayoutComponent } from '../share/ui/home-page-layout.component';
import { roleGuard } from '../share/guard/role-guard';

const ACCOUNT_MANAGEMENT_ROUTES: Route[] = [
  {
    path: '',
    redirectTo: 'account-list',
    pathMatch: 'full',
  },
  {
    path: 'account-list',
    loadComponent: () =>
      import('./feature/account-list.component').then(
        (m) => m.AccountListComponent
      ),
      data: { role: ['SHOP_OWNER', 'RECEPTIONIST', 'BRANCH_MANAGER'] },
      canActivate: [roleGuard]
  },
  {
    path: 'create-account',
    loadComponent: () =>
      import('./feature/account.component').then((m) => m.AccountComponent),
      data: { role: ['SHOP_OWNER'] },
      canActivate: [roleGuard]
  },
  {
    path: 'detail-account',
    loadComponent: () =>
      import('./feature/account-update.component').then((m) => m.AccountUpdateComponent),
      data: { role: ['SHOP_OWNER', 'RECEPTIONIST', 'BRANCH_MANAGER'] },
      canActivate: [roleGuard]
  },
];
export default ACCOUNT_MANAGEMENT_ROUTES;
