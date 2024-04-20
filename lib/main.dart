import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class Colors {
//   static const blue = Color(0xFF42A5F5);
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Colors.blue, middle: Text("Brendan's To Do List")),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("Task One"), Text("Task Two"), Text("Task Three")],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
