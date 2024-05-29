import 'package:flutter/cupertino.dart';

class DarkModeWidget extends StatefulWidget {
  const DarkModeWidget({
    super.key,
    required this.handleDarkMode,
    required this.handleDarkSwitch,
  });

  final void Function(bool isOn) handleDarkMode;
  final bool Function() handleDarkSwitch;

  @override
  State<DarkModeWidget> createState() => _DarkModeWidgetState();
}

class _DarkModeWidgetState extends State<DarkModeWidget> {
  bool isDark = false;

  void handleSwitch(bool value) {
    setState(
      () {
        isDark = value;
        widget.handleDarkMode(isDark);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: const Icon(CupertinoIcons.moon),
      title: const Text("Dark mode"),
      trailing: CupertinoSwitch(
        value: widget.handleDarkSwitch(),
        onChanged: handleSwitch,
      ),
    );
  }
}
