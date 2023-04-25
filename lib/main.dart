import 'dart:async';
import 'dart:convert';

import 'package:login_tester/router/app_router.dart';
import 'package:login_tester/services/app_service.dart';
import 'package:login_tester/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Tester());
}

class Tester extends StatefulWidget {

  const Tester({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  late UserService userService;
  late AppService appService;

  late StreamSubscription<bool> userSubscription;

  String? route;

  void onUserStateChange(bool hasUser) {
    appService.hasUser = hasUser;
  }

  @override
  void initState() {
    userService = UserService();
    appService = AppService(userService);

    userSubscription = userService.onUserStateChange.listen(onUserStateChange);

    Future.sync(() async {
      final jsonString = await DefaultAssetBundle.of(context).loadString("assets/config.json");
      var config = jsonDecode(jsonString);

      await Backendless.initApp(
        applicationId: config["applicationID"],
        customDomain: config["applicationSubDomain"],
        iosApiKey: config["iOSAPIKey"]
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        ChangeNotifierProvider(create: (_) => userService)
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(context, listen: true).router;
          return MaterialApp.router(
            routerConfig: goRouter,
            theme: ThemeData(colorScheme: ColorScheme.light().copyWith(primary: Colors.black)),
            debugShowCheckedModeBanner: false
          );
        }
      )
    );
  }

  @override
  void dispose() {
    userSubscription.cancel();

    super.dispose();
  }
}