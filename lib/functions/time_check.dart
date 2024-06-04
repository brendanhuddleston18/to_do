import 'package:path/path.dart';
import 'package:intl/intl.dart';

bool timeCheck(String reminderTime){
  DateTime currentTime = DateTime.now();
  String formattedCurrentTime = DateFormat('dd-MMM-yyyy - kk:mm').format(currentTime);

  if (reminderTime == formattedCurrentTime){
    return true;
  } else {
    return false;
  }
}