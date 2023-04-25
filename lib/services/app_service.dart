import 'dart:async';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:login_tester/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class AppService with ChangeNotifier {
  late final UserService userService;

  final StreamController<bool> _backendlessLoginStateChange = StreamController<bool>.broadcast();
  final StreamController<bool> _hasUserStateChange = StreamController<bool>.broadcast();

  bool _initialized = false;
  bool _backendlessLoginState = false;
  bool _hasUser = false;

  AppService(this.userService);

  bool get initialized => _initialized;
  bool get backendlessLoginState => _backendlessLoginState;
  bool get hasUser => _hasUser;

  Stream<bool> get backendlessLoginStateChange => _backendlessLoginStateChange.stream;
  Stream<bool> get hasUserStateChange => _hasUserStateChange.stream;

  set backendlessLoginState(bool state) {
    _backendlessLoginState = state;
    _backendlessLoginStateChange.add(state);
    notifyListeners();
  }

  set hasUser(bool value) {
    _hasUser = value;
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    await userService.initialize();
    _initialized = true;
    await Future.delayed(Duration(seconds: 5));
    notifyListeners();
  }

  Future<bool> getBackendlessLoginStatus() async {
    return await Backendless.userService.isValidLogin().then((isLoggedIn) {
      return isLoggedIn == true ? true : false;
    })
    .catchError((error) {
      print(error);
      return false;
    });
  }
}