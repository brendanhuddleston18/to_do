import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PullDownMenu extends StatefulWidget {
  const PullDownMenu(
      {super.key,
      required this.builder,
      required this.isLoggedIn,
      required this.username,
      required this.handleLoggedIn, 
      required this.photoUrl});

  final PullDownMenuButtonBuilder builder;
  final bool isLoggedIn;
  final String username;
  final String photoUrl;
  final Function(bool isSignedIn) handleLoggedIn;

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

  @override
  void didUpdateWidget(covariant PullDownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoggedIn != widget.isLoggedIn) {
      handleLoggedIn();
    }
  }

  void handleLoggedIn() {
    if (widget.isLoggedIn) {
      setState(() {
        signInOrSignOut = 'Sign out';
      });
    } else {
      setState(() {
        signInOrSignOut = 'Sign In';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
        itemBuilder: (context) {
          return [
            PullDownMenuHeader(
              leading: Image.network(widget.photoUrl),
              title: widget.username,
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
                } else {
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
