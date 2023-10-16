import { Route } from '@angular/router';
import { HomepageLayoutComponent } from '../share/ui/home-page-layout.component';

const BRANCH_MANAGEMENT_ROUTES: Route[] = [
  {
    path: '',
    redirectTo: 'branch-list',
    pathMatch: 'full',
  },
  {
    path: 'branch-list',
    loadComponent: () =>
      import('./feature/branch-list.component').then(
        (m) => m.BranchListComponent
      ),
  },
  {
    path: 'create-branch',
    loadComponent: () =>
      import('./feature/branch.component').then((m) => m.BranchComponent),
  },
];
export default BRANCH_MANAGEMENT_ROUTES;
