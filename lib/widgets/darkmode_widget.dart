import 'package:flutter/cupertino.dart';

class DarkModeWidget extends StatefulWidget {
  const DarkModeWidget({super.key, required this.color});

  final Color color;

  @override
  State<DarkModeWidget> createState() => _DarkModeWidgetState();
}

class _DarkModeWidgetState extends State<DarkModeWidget> {
  bool switchState = false;
  void handleSwitch(bool value) {
    setState(
      () {
        switchState = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      backgroundColor: widget.color,
      leading: const Icon(CupertinoIcons.moon),
      title: const Text("Dark mode"),
      trailing: CupertinoSwitch(
        value: switchState,
        onChanged: handleSwitch,
      ),
    );
  }
}
