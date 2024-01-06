import { Route } from '@angular/router';
import { AccountListComponent } from './feature/account-list.component';
import { HomepageLayoutComponent } from '../share/ui/home-page-layout.component';

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
  },
  {
    path: 'create-account',
    loadComponent: () =>
      import('./feature/account.component').then((m) => m.AccountComponent),
  },
  {
    path: 'update-account',
    loadComponent: () =>
      import('./feature/account-update.component').then((m) => m.AccountUpdateComponent),
  },
];
export default ACCOUNT_MANAGEMENT_ROUTES;
