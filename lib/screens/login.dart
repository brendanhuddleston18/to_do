import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:to_do/screens/google_signin.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget(
      {super.key, required this.handleLoggedIn, required this.handleUserInfo});

  final void Function(bool isSignedIn) handleLoggedIn;
  final Function(String, String) handleUserInfo;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  void handleLoginAction(String? username, String? photoUrl, String? email) {
    widget.handleLoggedIn(true);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    widget.handleUserInfo(username!, photoUrl!);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // backgroundColor: Colors.white70,
        child: SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: List.filled(
                3,
                const BoxShadow(
                  color: Color.fromARGB(17, 80, 80, 80),
                  spreadRadius: 6,
                  blurRadius: 16,
                ))),
        width: 400,
        height: 600,
        child: Column(
          children: [
            const SafeArea(
              minimum: EdgeInsets.only(top: 32),
              child: Text(
                "TaskTango",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      "Please use Google to login",
                      style: TextStyle(fontSize: 14),
                    ),
                    CupertinoButton(
                        child: Image.asset(
                          'assets/images/googleSignIn.png',
                          width: 200,
                          height: 150,
                        ),
                        onPressed: () {
                          setState(() {
                            nativeGoogleSignIn(handleLoginAction);
                          });
                        }),
                  ],
                )),
            const SafeArea(
                minimum: EdgeInsets.only(top: 60, bottom: 50),
                child: Divider(
                  indent: 40,
                  endIndent: 40,
                )),
            const Text(
              "TaskTango information blah blah",
              style: TextStyle(
                  color: Color.fromARGB(255, 56, 56, 56), fontSize: 12),
            )
          ],
        ),
      ),
    ));
  }
}
