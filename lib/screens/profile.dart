import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget(
      {super.key, required this.userLoggedIn, required this.username});

  final bool userLoggedIn;
  final String username;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.userLoggedIn) {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.left_chevron)),
          ),
          // TODO: Make this look pretty, change padding, font, icons?
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 140),
                child: Image.asset(
                  './assets/images/defaultProfilePic.webp',
                  height: 60,
                  width: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: CupertinoListSection(
                  children: [
                    Text(widget.username),
                    const Text("Email"),
                    const Text("Etc")
                  ],
                ),
              )
            ],
          ));
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.left_chevron)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 140),
          child: Column(
            children: [
              const Text("You are not logged in! Please login here!"),
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  icon: const Icon(CupertinoIcons.profile_circled))
            ],
          ),
        ),
      );
    }
  }
}
