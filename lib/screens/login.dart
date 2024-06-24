import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.handleLoggedIn});

  final void Function(bool isSignedIn) handleLoggedIn;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  void handleLoginAction() {
    widget.handleLoggedIn(true);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.left_chevron))),
              // TODO: Add username input text field for 'login'
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 140),
        child: CupertinoButton(
            onPressed: () {
              setState(() {
                handleLoginAction();
              });
            },
            child: const Text("Login")),
      ),
    );
  }
}
