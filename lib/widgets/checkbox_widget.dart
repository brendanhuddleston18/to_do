import 'package:flutter/cupertino.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({
    super.key,
  });

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool? checkedState = false;
  void handleCheckedState(bool? value) {
    setState(
      () {
        checkedState = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoCheckbox(
        value: checkedState, onChanged: handleCheckedState);
  }
}
