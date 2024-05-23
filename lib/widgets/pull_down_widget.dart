import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class SidePanelWidget extends StatefulWidget {
  const SidePanelWidget({super.key});

  @override
  State<SidePanelWidget> createState() => _SidePanelWidgetState();
}

class _SidePanelWidgetState extends State<SidePanelWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {}, icon: const Icon(CupertinoIcons.ellipsis));
  }
}

// -------------------------------------//

class PullDownMenu extends StatelessWidget {
  const PullDownMenu({super.key, required this.builder});

  final PullDownMenuButtonBuilder builder;

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
              onTap: () {},
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
                icon: CupertinoIcons.trash_circle_fill,
              )
            ]),
            const PullDownMenuDivider.large(),
            PullDownMenuItem(onTap: () {}, title: "Settings"),
            PullDownMenuItem(onTap: () {}, title: "About"),
            const PullDownMenuDivider.large(),
            PullDownMenuItem(onTap: () {}, title: "Log out")
          ];
        },
        buttonBuilder: builder);
  }
}

// class PullDownMenu extends StatefulWidget {
//   const PullDownMenu({super.key, required this.builder});



//   @override
//   State<PullDownMenu> createState() => _PullDownMenuState();
// }

// class _PullDownMenuState extends State<PullDownMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return PullDownButton(itemBuilder: (context){
//       return [PullDownMenuHeader(leading: ColoredBox(
//               color: CupertinoColors.systemBlue.resolveFrom(context),
//             ), title: "Profile")];
//     }, buttonBuilder: buttonBuilder);
//   }
// }
