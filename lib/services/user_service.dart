import 'dart:async';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'backendless_mobile_service.dart';
import '../models/user.dart';

class UserService extends ChangeNotifier {
  final StreamController<bool> _onUserStateChange = StreamController<bool>.broadcast();
  Stream<bool> get onUserStateChange => _onUserStateChange.stream;

  late User _user;
  User get user => _user;

  Future<bool> getBackendlessLoginStatus() async {

    return await Backendless.userService.isValidLogin().then((isLoggedIn) {
      return isLoggedIn == true ? true : false;
    })
    .catchError((error) {
      print(error);
      return false;
    });
  }

  Future<void> setUser() async {
    Backendless.userService.loggedInUser()
      .then((userId) {
        if(userId != null) {
          return userId;
        }
        else {
          throw PlatformException(code: "No userId");
        }
      })
      .then((userId) {
        MobileService.GetMyUser().then((userData) async {
          if(userData != null) {
            _user = User.fromUserData(userData);
            _onUserStateChange.add(true);
            notifyListeners();
          }
          else {
            throw PlatformException(code: "No user data");
          }
        });
      });
  }

  Future<void> initialize() async {
    if(await getBackendlessLoginStatus() == true) {
      await setUser();
    }
  }

  Future<void> login(String email, String password) async {
    if(await getBackendlessLoginStatus() == false) {
      return Backendless.userService.login(email, password, true).then((user) async {
        setUser();
      });
    }
    else {
      return setUser();
    }
  }
}