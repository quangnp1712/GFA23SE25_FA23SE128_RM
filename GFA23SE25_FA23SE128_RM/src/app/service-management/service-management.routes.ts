import { Route } from '@angular/router';

const SERVICE_MANAGEMENT_ROUTES: Route[] = [
  {
    path: '',
    redirectTo: 'service-list',
    pathMatch: 'full',
  },
  {
    path: 'service-list',
    loadComponent: () =>
      import('./feature/service-list.component').then(
        (m) => m.ServiceListComponent
      ),
  },
  {
    path: 'create-service',
    loadComponent: () =>
      import('./feature/service.component').then((m) => m.ServiceComponent),
  },
];
export default SERVICE_MANAGEMENT_ROUTES;
