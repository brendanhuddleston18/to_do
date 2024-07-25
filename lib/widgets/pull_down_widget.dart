import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:to_do/screens/google_signin.dart';

class PullDownMenu extends StatefulWidget {
  const PullDownMenu({
    super.key,
    required this.builder,
    required this.isLoggedIn,
    required this.username,
    required this.handleLoggedIn,
    required this.photoUrl,
    required this.deleteAll,
    required this.getTasks,
  });

  final PullDownMenuButtonBuilder builder;
  final Function() getTasks;
  final bool isLoggedIn;
  final String username;
  final String photoUrl;

  final Function(bool isSignedIn) handleLoggedIn;
  final Future<void> Function() deleteAll;

  @override
  State<PullDownMenu> createState() => _PullDownMenuState();
}

class _PullDownMenuState extends State<PullDownMenu> {
  String signInOrSignOut = 'Sign in';

  @override
  void initState() {
    super.initState();
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
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
                onTap: () {
                  widget.deleteAll();
                  widget.getTasks();
                },
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
                signOut();
                Navigator.pushNamed(context, '/login');
              },
              title: "Sign out",
              icon: CupertinoIcons.device_phone_portrait,
              isDestructive: true,
            )
          ];
        },
        buttonBuilder: widget.builder);
  }
}
