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
            middle: const Text("Profile"),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 120, 60, 0),
                child: Image.asset(
                  './assets/images/defaultProfilePic.webp',
                  height: 160,
                  width: 160,
                ),
              ),
              CupertinoListSection(
                header: const Text("Profile Info"),
                backgroundColor: CupertinoColors.systemBackground,
                hasLeading: false,
                children: [
                  CupertinoListTile(
                    title: Text(widget.username),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.pencil_circle)),
                  ),
                  const CupertinoListTile(title: Text("Email")),
                  const CupertinoListTile(title: Text("Etc")),
                ],
              ),
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
