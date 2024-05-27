import 'package:flutter/cupertino.dart';

class DarkModeWidget extends StatefulWidget {
  const DarkModeWidget({
    super.key,
  });

  @override
  State<DarkModeWidget> createState() => _DarkModeWidgetState();
}

class _DarkModeWidgetState extends State<DarkModeWidget> {
  bool isDark = false;

  void handleSwitch(bool value) {
    setState(
      () {
        isDark = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: const Icon(CupertinoIcons.moon),
      title: const Text("Dark mode"),
      trailing: CupertinoSwitch(
        value: isDark,
        onChanged: handleSwitch,
      ),
    );
  }
}
