import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.handleLoggedIn, required this.handleUsername});

  final void Function(bool isSignedIn) handleLoggedIn;
  final Function(String) handleUsername;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  void handleLoginAction() {
    widget.handleLoggedIn(true);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    widget.handleUsername(controller.text);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.left_chevron))),
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
                    handleLoginAction();
                  });
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
