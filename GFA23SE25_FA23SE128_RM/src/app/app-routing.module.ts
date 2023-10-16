import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import LOGIN_ROUTES from './login/login.routes';
import HOME_PAGE_ROUTES from './home-page/home-page.routes';
import ACCOUNT_MANAGEMENT_ROUTES from './account-management/account-management.routes';
import { HomepageLayoutComponent } from './share/ui/home-page-layout.component';
import BRANCH_MANAGEMENT_ROUTES from './branch-management/branch-management.routes';
import SERVICE_MANAGEMENT_ROUTES from './service-management/service-management.routes';

const routes: Routes = [
  {path: '', loadChildren: () => LOGIN_ROUTES},
  {path: '', component: HomepageLayoutComponent, children: [
    {
      path: "homepage",
      loadChildren: () => HOME_PAGE_ROUTES
    },
    {
      path: "account-management",
      loadChildren: () => ACCOUNT_MANAGEMENT_ROUTES
    },
    {
      path: "branch-management",
      loadChildren: () => BRANCH_MANAGEMENT_ROUTES
    },
    {
      path: "service-management",
      loadChildren: () => SERVICE_MANAGEMENT_ROUTES
    }
  ]},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
