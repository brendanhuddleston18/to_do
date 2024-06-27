import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget(
      {super.key,
      required this.userLoggedIn,
      required this.username,
      required this.handleUsername});

  final bool userLoggedIn;
  final String username;
  final Function(String) handleUsername;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool isEditing = false;

  void handleEditing() {
    if (!isEditing) {
      isEditing = true;
    } else {
      isEditing = false;
    }
  }

  TextEditingController controller = TextEditingController();

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
        child: SafeArea(
            child: Column(
          children: [
            Image.asset(
              'assets/images/defaultProfilePic.webp',
              height: 160,
              width: 160,
            ),
            CupertinoListSection(
              header: const Text("Profile Info"),
              backgroundColor: CupertinoColors.systemBackground,
              hasLeading: false,
              children: [
                CupertinoListTile(
                  title: Text(widget.username),
                  trailing: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            handleEditing();
                          },
                        );
                      },
                      icon: const Icon(CupertinoIcons.pencil_circle)),
                ),
                const CupertinoListTile(title: Text("Email")),
                const CupertinoListTile(title: Text("Etc")),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                  visible: isEditing,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: CupertinoTextField(
                      controller: controller,
                      suffix: IconButton(
                        icon: const Icon(CupertinoIcons.floppy_disk),
                        onPressed: () {
                          widget.handleUsername(controller.text);
                          isEditing = false;
                        },
                      ),
                    ),
                  )),
            )
          ],
        )),
      );
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
