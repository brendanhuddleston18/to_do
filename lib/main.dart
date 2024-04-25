import 'package:flutter/cupertino.dart';
import 'package:to_do/screens/home.dart';

// class Colors {
//   static const blue = Color(0xFF42A5F5);
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Home(
        onDeleteTask: (String taskToDelete, List listToRemove) {
          setState(() {
            listToRemove.remove(taskToDelete)
          })
        },
      ),
      debugShowCheckedModeBanner: false,
      );
  }
}