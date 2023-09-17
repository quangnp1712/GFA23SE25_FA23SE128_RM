import { Route } from "@angular/router";
import { HomepageLayoutComponent } from "./ui/home-page-layout.component";

const HOME_PAGE_ROUTES: Route[] = [{
  path: '',
  component: HomepageLayoutComponent,
  children: [
    {
      path: '',
      redirectTo: 'profile',
      pathMatch: 'full',
    },
    {
      path: 'profile',
      loadComponent: () => import('./feature/profile.component').then(m => m.ProfileComponent),
    },
  ],
},]
export default HOME_PAGE_ROUTES;
