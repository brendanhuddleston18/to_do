import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PullDownMenu extends StatefulWidget {
  const PullDownMenu(
      {super.key, required this.builder, required this.isLoggedIn});

  final PullDownMenuButtonBuilder builder;
  final bool isLoggedIn;

  @override
  State<PullDownMenu> createState() => _PullDownMenuState();
}

class _PullDownMenuState extends State<PullDownMenu> {
  String signInOrSignOut = 'Sign in';

  @override
  void initState() {
    super.initState();
    handleLoggedIn();
  }

  // TODO: Fix sign-in/sign-out state in pulldown widget
  void handleLoggedIn() {
    setState(
      () {
        if (widget.isLoggedIn) {
          signInOrSignOut = 'Sign out';
        } else {
          signInOrSignOut = 'Sign In';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
        itemBuilder: (context) {
          return [
            PullDownMenuHeader(
              leading: ColoredBox(
                color: CupertinoColors.systemBlue.resolveFrom(context),
              ),
              title: "Profile",
              subtitle: "Tap to open",
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: CupertinoIcons.profile_circled,
            ),
            const PullDownMenuDivider.large(),
            PullDownMenuActionsRow.medium(items: [
              PullDownMenuItem(
                onTap: () {},
                title: "Mark all as done",
                icon: CupertinoIcons.check_mark,
              ),
              PullDownMenuItem(
                onTap: () {},
                title: "Delete all Tasks",
                icon: CupertinoIcons.trash,
              )
            ]),
            const PullDownMenuDivider.large(),
            PullDownMenuItem(
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
                title: "Settings",
                icon: CupertinoIcons.gear),
            PullDownMenuItem(
                onTap: () {}, title: "About", icon: CupertinoIcons.book),
            const PullDownMenuDivider.large(),
            PullDownMenuItem(
              onTap: () {
                if (!widget.isLoggedIn) {
                  Navigator.pushNamed(context, '/login');
                }
              },
              title: signInOrSignOut,
              icon: CupertinoIcons.device_phone_portrait,
              isDestructive: true,
            )
          ];
        },
        buttonBuilder: widget.builder);
  }
}
