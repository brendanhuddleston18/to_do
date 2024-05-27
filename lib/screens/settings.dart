import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/widgets/darkmode_widget.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key, required this.handleDarkMode});

  final void Function(bool isOn) handleDarkMode;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.chevron_back)),
          middle: const Text("Settings"),
        ),
        child: CupertinoListSection(
          backgroundColor: Theme.of(context).colorScheme.background,
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          children: [
            DarkModeWidget(
              handleDarkMode: widget.handleDarkMode,
            ),
          ],
        ));
  }
}
