import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        backgroundColor: Colors.white70,
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
          child: Container(
            width: 400,
            height: 600,
            color: Colors.white,
            child: Column(
              children: [
                const Text("Please use Google to Log In"),
                CupertinoButton(
                    child: Image.asset(
                      'assets/images/googleSignIn.png',
                    ),
                    onPressed: () {
                      setState(() {
                        nativeGoogleSignIn(handleLoginAction);
                      });
                    })
              ],
            ),
          ),
        ));
  }
}
