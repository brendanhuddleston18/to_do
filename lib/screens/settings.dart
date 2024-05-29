import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/widgets/darkmode_widget.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget(
      {super.key,
      required this.handleDarkMode,
      required this.currentTheme,
      required this.handleDarkSwitch});

  final void Function(bool isOn) handleDarkMode;
  final CupertinoThemeData currentTheme;
  final bool Function() handleDarkSwitch;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: widget.currentTheme.primaryContrastingColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.chevron_back)),
          middle: const Text("Settings"),
        ),
        child: CupertinoListSection(
          backgroundColor: widget.currentTheme.primaryContrastingColor,
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          children: [
            DarkModeWidget(
              handleDarkSwitch: widget.handleDarkSwitch,
              handleDarkMode: widget.handleDarkMode,
            ),
          ],
        ));
  }
}
