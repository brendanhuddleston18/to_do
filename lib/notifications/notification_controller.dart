import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:to_do/globals.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreateMethod(
      ReceivedNotification receivedNotification) async {
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == 'viewTask') {
      if (receivedAction.payload?['taskID'] != null) {
        String taskToView = receivedAction.payload!['taskID']!;
        print('viewing task $taskToView');
      }
    } else if (receivedAction.buttonKeyPressed == 'delete') {
      if (receivedAction.payload?['taskID'] != null) {
        String taskToDelete = receivedAction.payload!['taskID']!;
        globalDeleteTask!(taskToDelete);
      }
    }
  }
}
