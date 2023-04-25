import 'package:login_tester/router/route_utils.dart';
import 'package:login_tester/services/app_service.dart';
import 'package:go_router/go_router.dart';

import '../widgets/landing.dart';
import '../widgets/login.dart';
import '../widgets/splash_page.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: APP_PAGE.home.toPath,
    routes: [
      GoRoute(name: APP_PAGE.splash.toName, path: APP_PAGE.splash.toPath, builder: (context, state) => SplashPage()),
      GoRoute(name: APP_PAGE.home.toName, path: APP_PAGE.home.toPath, pageBuilder: (context, state) => NoTransitionPage(child: LandingPageTemplate())),
      GoRoute(name: APP_PAGE.login.toName, path: APP_PAGE.login.toPath, builder: (context, state) => Login()),
    ],
    redirect: (context, state) {
      try {
        final isLoggedIn = appService.hasUser;
        final isInitialized = appService.initialized;

        final isGoingToLogin = state.subloc == APP_PAGE.login.toPath; //loginLocation;
        final isGoingToSplash = state.subloc == APP_PAGE.splash.toPath;

        if(!isInitialized && !isGoingToSplash) {
          return APP_PAGE.splash.toPath; //splashLocation;
        }
        else if(isInitialized && !isLoggedIn && !(isGoingToLogin)) {
          return APP_PAGE.login.toPath; //loginLocation;
        }
        else if((isInitialized && isGoingToSplash) || (isLoggedIn && (isGoingToLogin))) {
          return APP_PAGE.home.toPath;
        }

        return null;
      }
      catch (error) {
        print("redirect error");
        print(error);
        return null;
      }
    }
  );
}