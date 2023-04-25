import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppService _appService;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    onStartUp();
    super.initState();
  }

  void onStartUp() async {
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 60.0, right: 60, bottom: 60),
            child: Center(
              child: Container(child: Text("LOADING")),
            )
          ),
          Center(
            child: LinearProgressIndicator(),
          ),
        ]
      )
    );
  }
}