import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      resolver.redirect(const AuthLayout(children: [LoginRoute()]));
    }
  }
}
