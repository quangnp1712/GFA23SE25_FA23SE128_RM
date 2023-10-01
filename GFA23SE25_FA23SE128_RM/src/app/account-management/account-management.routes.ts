import { Route } from "@angular/router";
import { AccountListComponent } from "./feature/account-list.component";
import { HomepageLayoutComponent } from "../home-page/ui/home-page-layout.component";

const ACCOUNT_MANAGEMENT_ROUTES: Route[] = [{
  path: '',
  component: HomepageLayoutComponent,
  children: [
    {
      path: '',
      redirectTo: 'account-list',
      pathMatch: 'full',
    },
    {
      path: 'account-list',
      loadComponent: () => import('./feature/account-list.component').then(m => m.AccountListComponent),
    },
  ],
},]
export default ACCOUNT_MANAGEMENT_ROUTES;
