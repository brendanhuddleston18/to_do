import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/screens/google_signin.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget(
      {super.key, required this.handleLoggedIn, required this.handleUsername});

  final void Function(bool isSignedIn) handleLoggedIn;
  final Function(String) handleUsername;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  void handleLoginAction(String? username, String? photoUrl, String? email) {
    widget.handleLoggedIn(true);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    widget.handleUsername(username!);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 100),
        child: Column(
          children: [
            CupertinoTextField(
              controller: controller,
              placeholder: "Enter your username",
            ),
            CupertinoButton(
                onPressed: () {
                  setState(() {
                    nativeGoogleSignIn(handleLoginAction);
                  });
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
