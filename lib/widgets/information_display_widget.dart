import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationDisplayWidget extends StatefulWidget {
  const InformationDisplayWidget({
    super.key,
    required this.information,
    required this.showModal,
  });

  final String information;
  final Function(String) showModal;

  @override
  State<InformationDisplayWidget> createState() =>
      _InformationDisplayWidgetState();
}

class _InformationDisplayWidgetState extends State<InformationDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.info_circle),
      onPressed: () {
        widget.showModal(widget.information);
      },
    );
  }
}