import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import LOGIN_ROUTES from './login/login.routes';
import HOME_PAGE_ROUTES from './home-page/home-page.routes';

const routes: Routes = [
  {path: '', loadChildren: () => LOGIN_ROUTES},
  {path: 'homepage', loadChildren: () => HOME_PAGE_ROUTES}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
