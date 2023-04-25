import 'package:backendless_sdk/backendless_sdk.dart';

class MobileService {
  static final _serviceName = "MobileService";

  static Future<dynamic> GetMyUser() {
    return Backendless.customService.invoke(_serviceName, "getMyUser", null);
  }
}
