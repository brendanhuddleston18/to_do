import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 79, 152, 189),
        leading: const Text("Panel"),
        middle: const Text("Brendan's To Do List")
      ),
      child: Row(
        children: [
          SliverList(delegate: delegate),

          ],
        ),
    );
  }
}