import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SignInComponent } from './login/feature/sign-in.component';
import LOGIN_ROUTES from './login/login.routes';

const routes: Routes = [
  {path: '', loadChildren: () => LOGIN_ROUTES}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
