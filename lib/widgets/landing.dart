import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/user_service.dart';


class LandingPageTemplate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingPageTemplate();
}

class _LandingPageTemplate extends State<LandingPageTemplate> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    final userService = Provider.of<UserService>(context, listen: false);

    return FutureBuilder(
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            resizeToAvoidBottomInset: true,
            body: Container(
              child: Text("LOGGED IN AS " + userService.user.email)
            ),
          )
        );
      });
  }
}
