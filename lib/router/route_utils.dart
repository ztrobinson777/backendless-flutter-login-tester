enum APP_PAGE {
  splash,
  login,
  home
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch(this) {
      case APP_PAGE.splash:
        return "/splash";
      case APP_PAGE.login:
        return "/login";
      case APP_PAGE.home:
        return "/";
      default: {
        return "/";
      }
    }
  }

  String get toName {
    switch(this) {
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.login:
        return "LOGIN";
      case APP_PAGE.home:
        return "HOME";
      default: {
        return "HOME";
      }
    }
  }

  String get toTitle {
    switch(this) {
      case APP_PAGE.splash:
        return "Splash";
      case APP_PAGE.login:
        return "Login";
      case APP_PAGE.home:
        return "Home";
      default: {
        return "Home";
      }
    }
  }
}