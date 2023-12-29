import { Route } from "@angular/router";
import { LoginLayoutComponent } from "./ui/login-layout.component";

const LOGIN_ROUTES: Route[] = [{
  path: '',
  component: LoginLayoutComponent,
  children: [
    {
      path: '',
      redirectTo: 'login',
      pathMatch: 'full',
    },
    {
      path: 'login',
      loadComponent: () => import('./feature/sign-in.component').then(m => m.SignInComponent),
    },
    {
      path: 'otp',
      loadComponent: () => import('./feature/otp.component').then(m => m.OtpComponent),
    },
  ],
},]
export default LOGIN_ROUTES;
  