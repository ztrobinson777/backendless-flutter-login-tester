import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:login_tester/router/route_utils.dart';
import 'package:login_tester/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    bool validInput = [emailController, passwordController].every((tf) { return tf.text.length > 0; });

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: emailController,
                enabled: !loading,
                decoration: InputDecoration(focusColor: Colors.black, border: OutlineInputBorder(), labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    validInput = value.length > 0 && passwordController.text.length > 0;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: passwordController,
                enabled: !loading,
                obscureText: true,
                decoration: InputDecoration(focusColor: Colors.black, border: OutlineInputBorder(), labelText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    validInput = value.length > 0 && emailController.text.length > 0;
                  });
                },
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(250, 50),
                ),
                child: loading ? LinearProgressIndicator() : Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
                ),
                onPressed: !validInput ? null : () {
                  if (_formKey.currentState!.validate()) {
                    setState(() { loading = true; });
                    userService.login(emailController.text, passwordController.text).catchError((error) {
                      setState(() { loading = false; });
                      PlatformException platformException = error;
                      print("login error handler");
                      print(error);
                      String message = (platformException.message ?? "").contains("Invalid login or password") ? "Invalid email or password" : "Login Failed";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    });
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }
}
